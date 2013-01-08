define [
	'backbone'
	'jquery'
	'ns'
	'jst'
	'animate'
	'views/projects/project-task-edit'
	'models/projects/project-task-edit'
	'views/projects/project-overview'
	'models/projects/project-overview'
	'views/widgets/livesearch-input'
	'models/widgets/livesearch'
], (Backbone, $, ns) ->

	ns 'United.Views.Projects.ProjectEdit'
	class United.Views.Projects.ProjectEdit extends Backbone.View
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
			United.EventBus.on 'load-task-in-editor', @editTask, @
			@model.get('project').get('tasks').on 'add', @editTask, @

		render: ->
			@body = $ 'body'
			ctx = @model.get('project').toJSON()
			html = United.JST.ProjectDrawer ctx
			@$el.html html
			@taskHolder = @$ '#project-task-holder'
			@

		setName: (e) =>
			@model.get('project').set 'name', e.currentTarget.value

		setCode: (e) =>
			@model.get('project').set 'code', e.currentTarget.value

		setClient: (e) =>
			@model.get('project').set 'name', e.currentTarget.value

		editTask: (task) ->
			@taskEditor = new United.Views.Projects.ProjectTaskEdit
				model: new United.Models.Projects.ProjectTaskEdit
					task: task
			@taskHolder.html @taskEditor.render().$el

		newTask: (e) =>
			@model.get('project').get('tasks').add {}
			e.preventDefault()

		animateIn: () ->
			@overview = new United.Views.Projects.ProjectOverview
				model: new United.Models.Projects.ProjectOverview
					project: @model.get 'project'
			@liveSearch = new United.Views.Widgets.LiveSearchInput
				el: '#client-search'
				model: new United.Models.Widgets.LiveSearch
					sources: window.clients
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
