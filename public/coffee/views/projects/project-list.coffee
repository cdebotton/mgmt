define [
	'backbone'
	'jquery'
	'ns'
	'animate'
	'views/projects/project-edit'
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
			United.EventBus.on 'open-project', @editProject, @
			@model.on 'add:projects', @editProject, @
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
			@model.get('projects').add {}
			e.preventDefault()

		editProject: (project) =>
			if not United.Models.Users.Session.isAdmin()
				return false
			editor = new United.Views.Projects.ProjectEdit
				model: project
				open: DRAWER_OPEN
			editor.render()
			DRAWER_OPEN = true

		drawerClosed: -> DRAWER_OPEN = false
