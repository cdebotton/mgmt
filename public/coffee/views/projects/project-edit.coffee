define [
	'backbone'
	'jquery'
	'underscore'
	'ns'
	'jst'
	'animate'
	'models/clients/client'
	'views/projects/project-task-edit'
	'models/projects/project-task-edit'
	'views/projects/project-overview'
	'models/projects/project-overview'
	'views/widgets/livesearch-input'
	'models/widgets/livesearch'
], (Backbone, $, _, ns) ->

	ns 'United.Views.Projects.ProjectEdit'
	class United.Views.Projects.ProjectEdit extends Backbone.View
		tagName:	'section'

		className:	'project-drawer'

		events:
			'click #save-project':			'saveProject'
			'click .add-task-to-project':		'newTask'
			'click #close-project-drawer':		'closeDrawer'
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
			@model.get('project').set 'client_name', e.currentTarget.value

		editTask: (task) ->
			@taskEditor = new United.Views.Projects.ProjectTaskEdit
				model: new United.Models.Projects.ProjectTaskEdit
					task: task
			@taskHolder.html @taskEditor.render().$el

		newTask: (e) =>
			@model.get('project').get('tasks').add {}
			e.preventDefault()

		setup: ->
			@overview = new United.Views.Projects.ProjectOverview
				model: new United.Models.Projects.ProjectOverview
					project: @model.get 'project'
			@liveSearch = new United.Views.Widgets.LiveSearchInput
				el: '#client-search'
				model: new United.Models.Widgets.LiveSearch
					sources: window.clients
			if @model.get('project').get('client')
				@liveSearch.setValue 'id', @model.get('project').get('client').get('id')
			@liveSearch.$el.on 'keyup', @setClient
			@liveSearch.model.on 'change', @setClientProps

		animateIn: () ->
			@$el.css 'margin-top', -@$el.innerHeight()
			@$el.animate { 'margin-top': 0 }, 175, 'ease-in'
			@body.bind 'keyup', @bindEscape

		closeDrawer: (e) =>
			if @model.get('project').isNew()
				@model.get('project').destroy()
			@$el.animate { 'margin-top': -@$el.innerHeight() }, 175, 'ease-out', =>
				@taskHolder.remove()
				@liveSearch.remove()
				@remove()
				United.EventBus.trigger 'close-project-drawer'
			e.preventDefault()

		bindEscape: (e) => if e.keyCode is 27 then @closeDrawer e

		setClientProps: (model) =>
			@model.get('project').set {
				client_id: model.get 'value'
				client_name: model.get 'client_name'
			}

		saveProject: (e) =>
			@model.get('project').save null, { wait: true }
			###
			@modal = new United.Views.Widgets.Modal
					model: new Backbone.Model
						title: 'Unsaved Project!'
						msg: '<p>The project must be saved before child tasks can be added.</p>'
						options:
							'Save Project': @saveProjectModal
							'Cancel': United.Views.Widgets.Modal.prototype.closeModal
			###
