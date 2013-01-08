define [
	'backbone'
	'ns'
	'jst'
	'widgets/modal'
], (Backbone, ns) ->

	ns 'United.Views.Projects.ProjectTaskEdit'
	class United.Views.Projects.ProjectTaskEdit extends Backbone.View
		events:
			'click #save-task':					'saveTask'
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
			United.JST.Hb.registerHelper 'printUsers', @printUsers
			United.JST.Hb.registerHelper 'printColors', @printColors

		render: () ->
			@$el.css 'opacity', 0
			task = @model.get 'task'
			s = task.get 'start_date'
			e = task.get 'end_date'
			ctx = task.toJSON()
			ctx.start_month = s.getMonth()+1
			ctx.start_day = s.getDate()
			ctx.start_year = s.getFullYear()
			ctx.end_month = e.getMonth()+1
			ctx.end_day = e.getDate()
			ctx.end_year = e.getFullYear()
			ctx.users = window.users
			html = United.JST.ProjectTaskDrawer ctx
			@$el.css 'height', 'auto'
			@$el.html html
			h = @$el.innerHeight()
			@$el.css {
				height:		0
				opacity:	1
			}
			@$el.animate {
				height:		h
			}, 175, 'ease-in'
			@model.get('task').on 'change', (task) -> console.log task.cid
			@

		animateOut: =>
			@$el.animate {
				height:		0
			}, 175, 'ease-out', =>
				United.EventBus.trigger 'close-project-task-drawer'
				@remove()

		updateTaskName: (e) =>
			@model.get('task').set 'name', e.currentTarget.value

		updateStartYear: (e) =>
			selected = @model.get 'task'
			start_date = selected.get 'start_date'
			target = parseInt(e.currentTarget.value)
			new_date = new Date target, start_date.getMonth(), start_date.getDate(), 0, 0, 0
			@model.get('task').set 'start_date', new_date
			console.log @model.get 'task'
			@validateDates()

		updateStartMonth: (e) =>
			selected = @model.get 'task'
			start_date = selected.get 'start_date'
			target = parseInt(e.currentTarget.value) - 1
			new_date = new Date start_date.getFullYear(), target, start_date.getDate(), 0, 0, 0
			@model.get('task').set 'start_date', new_date
			@validateDates()

		updateStartDay: (e) =>
			selected = @model.get 'task'
			start_date = selected.get 'start_date'
			target = parseInt(e.currentTarget.value)
			new_date = new Date start_date.getFullYear(), start_date.getMonth(), target, 0, 0, 0
			@model.get('task').set 'start_date', new_date
			@validateDates()

		updateEndYear: (e) =>
			selected = @model.get 'task'
			end_date = selected.get 'end_date'
			target = parseInt(e.currentTarget.value)
			new_date = new Date target, end_date.getMonth(), end_date.getDate(), 0, 0, 0
			@model.get('task').set 'end_date', new_date
			@validateDates()

		updateEndMonth: (e) =>
			selected = @model.get 'task'
			end_date = selected.get 'end_date'
			target = parseInt(e.currentTarget.value) - 1
			new_date = new Date end_date.getFullYear(), target, end_date.getDate(), 0, 0, 0
			@model.get('task').set 'end_date', new_date
			@validateDates()

		updateEndDay: (e) =>
			selected = @model.get 'task'
			end_date = selected.get 'end_date'
			target = parseInt(e.currentTarget.value)
			new_date = new Date end_date.getFullYear(), end_date.getMonth(), target, 0, 0, 0
			@model.get('task').set 'end_date', new_date
			@validateDates()

		validateDates: ->
			s = @model.get('task').get 'start_date'
			e = @model.get('task').get 'end_date'
			#if s >= e
			#	target = new Date s.getTime()
			#	@model.get('task').set 'end_date', target.setDate target.getDate + 2
			#	alert @model.get('task').get('end_date')

		updateColor: (e) =>
			@model.get('task').set 'color', e.currentTarget.value

		updateUserId: (e) =>
			@model.get('task').set 'user_id', e.currentTarget.value

		updatePercentage: (e) =>
			@model.get('task').set 'percentage', parseInt e.currentTarget.value

		saveProjectModal: (e) =>
			task = @model.get 'task'
			@model.get('task').get('project').save null, {
				wait: true
				silent: true
				success: (project, attrs, status) =>
					project.set 'id', attrs.id, { silent: true }
					@model.set 'task', task, { silent: true}
					@model.get('task').set 'project_id', attrs.id, { silent: true }
					project.get('tasks').at(0).save null, {
						wait: true
						silent: true
						success: (task, attrs, status) =>
							task.set 'id', attrs.id, { silent: true }
							@animateOut()
					}
					@modal.closeModal()
				}
			e.preventDefault()

		saveTask: (e) =>
			if @model.get('task').get('project').isNew()
				@modal = new United.Widgets.Modal
					model: new Backbone.Model
						title: 'Unsaved Project!'
						msg: '<p>The project must be saved before child tasks can be added.</p>'
						options:
							'Save Project': @saveProjectModal
							'Cancel': United.Widgets.Modal.prototype.closeModal
			else @model.get('task').save null, {
				wait: true
				success: (task, attrs, status) =>
					@model.get('task').set 'id', attrs.id
					@animateOut()
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
