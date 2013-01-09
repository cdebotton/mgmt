define [
	'backbone'
	'jquery'
	'ns'
	'animate'
	'views/projects/project-edit'
	'models/projects/project-edit'
	'models/clients/client'
	'views/projects/project-item'
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
			United.EventBus.on 'open-project', @dropDrawer, @
			@model.on 'add:projects', @addOne, @
			@model.on 'reset:projects', @addAll, @
			@projectList = @$ '#project-list'
			@addAll()

		addOne: (project) =>
			view = new United.Views.Projects.ProjectItem
				model: project
			@projectList.prepend view.render().$el

		addAll: (projects) =>
			@projectList.html ''
			@model.get('projects').each @addOne

		createNewProject: (e) =>
			project = new United.Models.Projects.Project
			@model.get('projects').add project
			@dropDrawer project
			e.preventDefault()

		dropDrawer: (project = null) =>
			if not United.Models.Users.Session.isAdmin()
				return false
			@drawer?.remove()

			params = {}
			params['users'] = @model.get('users')
			if project isnt null then params['project'] = project
			@drawer = new United.Views.Projects.ProjectEdit
				model: new United.Models.Projects.ProjectEdit params
			@$el.prepend @drawer.render().$el
			@drawer.setup()
			if not DRAWER_OPEN
				DRAWER_OPEN = true
				United.EventBus.trigger 'animate-drawer-in'

		drawerClosed: -> DRAWER_OPEN = false
