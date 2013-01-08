define [
	'backbone'
	'jquery'
	'ns'
	'jst'
	'animate'
	'views/projects/project-edit'
	'models/projects/project-edit'
	'models/clients/client'
	#'models/projects/project'
	#'models/tasks/task'
], (Backbone, $, ns) ->

	ns 'United.Views.Projects.ProjectList'
	class United.Views.Projects.ProjectList extends Backbone.View

		DRAWER_OPEN = false

		el: '#project-manager'

		events:
			'click #new-project':		'createNewProject'

		initialize: ->
			United.EventBus.on 'close-project-drawer', @drawerClosed, @
			United.Models.Users.Session = @model.get 'session'

		createNewProject: (e) =>
			project = new United.Models.Projects.Project
			@dropDrawer project
			e.preventDefault()

		dropDrawer: (project = null) =>
			if DRAWER_OPEN or not United.Models.Users.Session.isAdmin()
				return false
			DRAWER_OPEN = true
			params = {}
			params['users'] = @model.get('users')
			if project isnt null then params['project'] = project
			@drawer = new United.Views.Projects.ProjectEdit
				model: new United.Models.Projects.ProjectEdit params
			@$el.prepend @drawer.render().$el
			United.EventBus.trigger 'animate-drawer-in'

		drawerClosed: -> DRAWER_OPEN = false
