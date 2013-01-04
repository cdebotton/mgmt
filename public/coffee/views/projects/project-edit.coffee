define [
	'backbone'
	'jquery'
	'ns'
	'jst'
	'animate'
	'views/tasks/task-element'
	'views/projects/project-task-edit'
	'models/projects/project-task-edit'
	'views/projects/project-overview'
	'models/projects/project-overview'
], (Backbone, $, ns) ->

	ns 'United.Views.Projects.ProjectEdit'
	class United.Views.Projects.ProjectEdit extends Backbone.View
		TASK_DRAWER_OPEN = false

		tagName:	'section'

		className:	'project-drawer'

		events:
			'click button[type="submit"]':		'saveProject'
			'click .add-task-to-project':		'newTask'
			'click .icon-remove':				'closeDrawer'
			'keyup input[name="project-name"]':	'setName'
			'keyup input[name="code"]':			'setCode'
			'keyup input[name="client"]':		'setClient'

		initialize: ->
			United.EventBus.on 'animate-drawer-in', @animateIn, @

		render: ->
			@body = $ 'body'
			ctx = @model.get('project').toJSON()
			html = United.JST.ProjectDrawer ctx
			@$el.html html
			@overview = new United.Views.Projects.ProjectOverview
				model: new United.Models.Projects.ProjectOverview
					project: @model.get 'project'
			@

		setName: (e) =>
			@model.get('project').set 'name', e.currentTarget.value

		setCode: (e) =>
			@model.get('project').set 'code', e.currentTarget.value

		setClient: (e) =>
			@model.get('project').set 'name', e.currentTarget.value

		selectNewTask: (model) ->
			#model.on 'change', @updateTaskPreview, @
			#United.EventBus.trigger 'edit-task-element', model

		newTask: (e) =>
			@model.get('project').get('tasks').add {}
			e.preventDefault()

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


		saveProject: (e) =>
