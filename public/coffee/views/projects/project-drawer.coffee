define [
	'backbone'
	'jquery'
	'ns'
	'jst'
	'animate'
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
			'keyup input[name="name"]':			'setName'
			'keyup input[name="code"]':			'setCode'
			'keyup input[name="client"]':		'setClient'

		initialize: ->
			@model.get('project').get('tasks').on 'add', @selectNewTask, @
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
			@

		setName: (e) =>
			@model.get('project').set 'name', e.currentTarget.value

		setCode: (e) =>
			@model.get('project').set 'code', e.currentTarget.value

		setClient: (e) =>
			@model.get('project').set 'name', e.currentTarget.value

		selectNewTask: (model) ->
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
			ctx.start_month = s.getMonth()+1
			ctx.start_day = s.getDate()
			ctx.start_year = s.getFullYear()
			ctx.end_month = e.getMonth()+1
			ctx.end_day = e.getDate()
			ctx.end_year = e.getFullYear()
			#console.log ctx
			html = United.JST.ProjectTaskDrawer ctx
			@taskHolder.html html
			@

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

		saveProject: (e) =>
			
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
