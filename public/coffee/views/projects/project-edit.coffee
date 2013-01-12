define [
	'backbone'
	'jquery'
	'underscore'
	'ns'
	'jst'
	'animate'
	'models/clients/client'
	'views/projects/project-task-edit'
	'views/projects/project-overview'
	'models/projects/project-overview'
	'views/widgets/livesearch-input'
	'models/widgets/livesearch'
	'views/widgets/modal'
], (Backbone, $, _, ns) ->

	ns 'United.Views.Projects.ProjectEdit'
	class United.Views.Projects.ProjectEdit extends Backbone.View
		el: '#project-drawer'

		TASK_OPEN = false

		events:
			'click #save-project':				'saveProject'
			'click .add-task-to-project':		'newTask'
			'click #close-project-drawer':		'closeDrawer'
			'keyup input[name="project-name"]':	'setName'
			'keyup input[name="code"]':			'setCode'
			'keyup input[name="client"]':		'setClient'

		initialize: ->
			United.EventBus.on 'animate-drawer-in', @animateIn, @
			United.EventBus.on 'close-project-task-drawer', @taskClosed, @
			United.EventBus.on 'load-task-in-editor', @editTask, @
			@model.get('tasks').on 'add', @editTask, @

		render: ->
			@body = $ 'body'
			ctx = @model.toJSON()
			html = United.JST.ProjectDrawer ctx
			@$el.html html
			@setup()
			if @options.open is false
				h = @$el.innerHeight() + 10
				@$el.css({
					marginTop: -h
					display: 'block'
				}).animate {
					marginTop: 0
				}, '175', 'ease-out'
			@

		setName: (e) =>
			@model.set 'name', e.currentTarget.value

		setCode: (e) =>
			@model.set 'code', e.currentTarget.value

		setClient: (e) =>
			@model.set 'client_name', e.currentTarget.value

		editTask: (task) ->
			taskEditor = new United.Views.Projects.ProjectTaskEdit
				model: task
				open: TASK_OPEN
			taskEditor.render()
			TASK_OPEN = true

		newTask: (e) =>
			@model.get('tasks').add {}
			e.preventDefault()

		taskClosed: ->
			TASK_OPEN = false

		setup: ->
			@overview = new United.Views.Projects.ProjectOverview
				model: new United.Models.Projects.ProjectOverview
					project: @model
			@liveSearch = new United.Views.Widgets.LiveSearchInput
				el: '#client-search'
				model: new United.Models.Widgets.LiveSearch
					sources: window.clients
			if @model.get('client')
				@liveSearch.setValue 'id', @model.get('client').get('id')
			@liveSearch.$el.on 'keyup', @setClient
			@liveSearch.model.on 'change', @setClientProps

		animateIn: () ->
			@$el.css 'margin-top', -@$el.innerHeight()
			@$el.animate { 'margin-top': 0 }, 175, 'ease-in'
			@body.bind 'keyup', @bindEscape

		closeDrawer: (e) =>
			if @model.isNew()
				@model.destroy()
			@$el.animate { 'margin-top': -(@$el.innerHeight() + 10) }, 175, 'ease-out', =>
				@taskHolder.remove()
				@liveSearch.remove()
				@$el.html ''
				@$el.css {
					display: 'none'
					marginTop: 0
				}
				United.EventBus.trigger 'close-project-drawer'
			e.preventDefault()

		bindEscape: (e) => if e.keyCode is 27 then @closeDrawer e

		setClientProps: (model) =>
			@model.set {
				result: model
			}

		saveProject: (e) =>
			@model.save null, { wait: true }
			@modal = new United.Views.Widgets.Modal
					model: new Backbone.Model
						title: 'Unsaved Project!'
						msg: "<p>#{@model.get('name')} and its tasks have been saved.</p>"
						options:
							'Great!': United.Views.Widgets.Modal.prototype.closeModal
