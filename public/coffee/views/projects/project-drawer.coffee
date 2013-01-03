define [
	'backbone'
	'jquery'
	'ns'
	'jst'
	'animate'
	'views/tasks/task-element'
], (Backbone, $, ns) ->

	ns 'United.Views.Projects.ProjectDrawer'
	class United.Views.Projects.ProjectDrawer extends Backbone.View
		TASK_DRAWER_OPEN = false

		tagName:	'section'
		
		className:	'project-drawer'
		
		events:
			'click button[type="submit"]':		'saveProject'
			'click .add-task-to-project':		'newTask'
			'click .icon-remove':				'closeDrawer'
			'click #save-task':					'saveTask'
			'keyup input[name="project-name"]':	'setName'
			'keyup input[name="code"]':			'setCode'
			'keyup input[name="client"]':		'setClient'
			'keyup input[name="task-name"]':	'updateTaskName'
			'keyup input[name="start_year"]':	'updateStartYear'
			'keyup input[name="start_month"]':	'updateStartMonth'
			'keyup input[name="start_day"]':	'updateStartDay'
			'keyup input[name="end_year"]':		'updateEndYear'
			'keyup input[name="end_month"]':	'updateEndMonth'
			'keyup input[name="end_day"]':		'updateEndDay'
			'keyup input[name="percentage"]':	'updatePercentage'
			'change select[name="color"]':		'updateColor'
			'change select[name="user_id"]':	'updateUserId'

		initialize: ->
			@model.get('project').get('tasks').on 'add', @selectNewTask, @
			@model.get('project').get('tasks').on 'add', @updateTaskPreview, @
			@model.on 'change:selected', @editTask, @
			United.EventBus.on 'animate-drawer-in', @animateIn, @
			United.JST.Hb.registerHelper 'printUsers', @printUsers
			United.JST.Hb.registerHelper 'printColors', @printColors

		render: ->
			@body = $ 'body'
			ctx = @model.get('project').toJSON()
			html = United.JST.ProjectDrawer ctx
			@$el.html html
			@taskHolder = @$el.find '#project-task-holder'
			@projectOverview = @$el.find '#project-overview'
			@

		setName: (e) =>
			@model.get('project').set 'name', e.currentTarget.value

		setCode: (e) =>
			@model.get('project').set 'code', e.currentTarget.value

		setClient: (e) =>
			@model.get('project').set 'name', e.currentTarget.value

		selectNewTask: (model) ->
			model.on 'change', @updateTaskPreview, @
			@model.set 'selected', model

		newTask: (e) =>
			d = new Date()
			t = new Date d.getFullYear(), d.getMonth(), d.getDate()
			n = new Date t.getTime()
			n.setDate n.getDate() + 14
			@model.get('project').get('tasks').add {
				name: 'New Task'
				start_date: t
				end_date: n
				project: @model.get('project')
			}
			e.preventDefault()

		editTask: (model, task) ->
			s = task.get 'start_date'
			e = task.get 'end_date'
			ctx = task.toJSON()
			console.log ctx
			ctx.start_month = s.getMonth()+1
			ctx.start_day = s.getDate()
			ctx.start_year = s.getFullYear()
			ctx.end_month = e.getMonth()+1
			ctx.end_day = e.getDate()
			ctx.end_year = e.getFullYear()
			ctx.users = @model.get('users').toJSON()
			html = United.JST.ProjectTaskDrawer ctx
			@taskHolder.html html
			h = @taskHolder.innerHeight()
			@taskHolder.css {
				height: 0
				opacity: 1
			}
			@taskHolder.animate {
				height: h
			}, 175, 'ease-in'
			@

		updateTaskName: (e) =>
			@model.get('selected').set 'name', e.currentTarget.value

		updateTaskPreview: (task) ->
			@projectOverview.html ''
			tasks = @model.get('project').get('tasks')
			start = tasks.first().get 'start_date'
			tasks.comparator = (task) -> task.get 'end_date'
			end = tasks.last().get 'end_date'
			start = start.getTime()
			end = end.getTime()
			@projectOverview.css {
				height: tasks.length * 50 + ((tasks.length - 1) * 10)
			}
			tasks.each (task, key) =>
				view = new United.Views.Tasks.TaskElement
					model: task
					demo: true
				el = view.render().$el
				el.addClass 'demo'
				s = view.model.get('start_date').getTime()
				e = view.model.get('end_date').getTime()
				dx = 10 + (s - start) * 910
				width = 10 + ((e - start) / (end - start)) * 910
				el.css {
					left: dx
					width: width
				}
				@projectOverview.append el

		animateIn: () ->
			@$el.css 'margin-top', -@$el.innerHeight()
			@$el.animate { 'margin-top': 0 }, 175, 'ease-in'
			@body.bind 'keyup', @bindEscape

		closeDrawer: (e) =>
			@$el.animate { 'margin-top': -@$el.innerHeight() }, 175, 'ease-out', =>
				@remove()
				United.EventBus.trigger 'close-project-drawer'			
			e.preventDefault()

		bindEscape: (e) => if e.keyCode is 27 then @closeDrawer e

		updateStartYear: (e) =>
			selected = @model.get 'selected'
			start_date = selected.get 'start_date'
			target = parseInt(e.currentTarget.value)
			new_date = new Date target, start_date.getMonth(), start_date.getDate(), 0, 0, 0
			@model.get('selected').set 'start_date', new_date
			@validateDates()

		updateStartMonth: (e) =>
			selected = @model.get 'selected'
			start_date = selected.get 'start_date'
			target = parseInt(e.currentTarget.value) - 1
			new_date = new Date start_date.getFullYear(), target, start_date.getDate(), 0, 0, 0
			@model.get('selected').set 'start_date', new_date
			@validateDates()

		updateStartDay: (e) =>
			selected = @model.get 'selected'
			start_date = selected.get 'start_date'
			target = parseInt(e.currentTarget.value)
			new_date = new Date start_date.getFullYear(), start_date.getMonth(), target, 0, 0, 0
			@model.get('selected').set 'start_date', new_date
			@validateDates()

		updateEndYear: (e) =>
			selected = @model.get 'selected'
			end_date = selected.get 'end_date'
			target = parseInt(e.currentTarget.value)
			new_date = new Date target, end_date.getMonth(), end_date.getDate(), 0, 0, 0
			@model.get('selected').set 'end_date', new_date
			@validateDates()

		updateEndMonth: (e) =>
			selected = @model.get 'selected'
			end_date = selected.get 'end_date'
			target = parseInt(e.currentTarget.value) - 1
			new_date = new Date end_date.getFullYear(), target, end_date.getDate(), 0, 0, 0
			@model.get('selected').set 'end_date', new_date
			@validateDates()

		updateEndDay: (e) =>
			selected = @model.get 'selected'
			end_date = selected.get 'end_date'
			target = parseInt(e.currentTarget.value)
			new_date = new Date end_date.getFullYear(), end_date.getMonth(), target, 0, 0, 0
			@model.get('selected').set 'end_date', new_date
			@validateDates()

		validateDates: ->
			s = @model.get('selected').get 'start_date'
			e = @model.get('selected').get 'end_date'
			console.log s, e
			if s > e then @model.get('selected').set 'end_date', e.setDate e.getDate + 1

		updateColor: (e) =>
			@model.get('selected').set 'color', e.currentTarget.value

		updateUserId: (e) =>
			@model.get('selected').set 'user_id', e.currentTarget.value

		updatePercentage: (e) =>
			@model.get('selected').set 'percentage', parseInt e.currentTarget.value

		saveProject: (e) =>

		saveTask: (e) =>
			if @model.get('project').isNew()
				@model.get('project').save null, {
					wait: true
					success: (project, attrs, status) =>
						project.set 'id', attrs.id
						@model.get('selected').set 'author_id', window.user_id
						@model.get('selected').save null, {
							wait: true
							success: (task, attrs, status) =>
								@model.get('selected').set 'id', attrs.id
						}
				}

		printUsers: (array, opts) =>
			if array?.length
				buffer = ''
				for user, key in array
					item = {
						id: user.id
						email: user.email
						selected: if @model.get('task')?.has('user') and +user.id is +@model.get('task').get('user').get('id') then ' SELECTED' else ''
					}
					buffer += opts.fn item
				return buffer
			else return opts.elseFn

		printColors: (opts) =>
			colors = { blue: 'Blue', red: 'Red', green: 'Green', yellow: 'Yellow' }
			buffer = ''
			for id, color of colors
				buffer += opts.fn {
					id: id
					color: color
					selected: if @model.get('task')?.get('color') is id then ' SELECTED' else ''
				}
			return buffer
