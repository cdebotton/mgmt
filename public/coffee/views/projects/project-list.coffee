define [
	'backbone'
	'jquery'
	'ns'
	'jst'
	'animate'
	'views/projects/project-modal'
	'models/projects/edit-modal'
], (Backbone, $, ns) ->

	ns 'United.Views.Projects.ProjectList'
	class United.Views.Projects.ProjectList extends Backbone.View

		MODAL_OPEN = false

		el: '#project-manager'

		events:
			'click #new-project':		'openModal'

		initialize: ->
			United.EventBus.on 'modal-closed', @modalClosed, @
			United.Models.Users.Session = @model.get 'session'

		openModal: (project = null) =>
			if MODAL_OPEN or not United.Models.Users.Session.isAdmin()
				return false
			MODAL_OPEN = true
			params = {}
			params['users'] = @model.get('users')
			if project isnt null then params['project'] = project
			@modal = new United.Views.Projects.ProjectModal
				model: new United.Models.Projects.EditModal params
			@$el.append @modal.render().$el
			return false

		modelClosed: ->
			MODAL_OPEN = false