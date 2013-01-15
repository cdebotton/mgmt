define [
	'backbone'
	'underscore'
	'ns'
	'views/tasks/schedule-manager'
	'views/projects/project-list'
	'views/users/user-list'
	'views/dashboard/dashboard'
	'views/requests/request-overview'

], (Backbone, _, ns) ->

	ns 'United.EventBus'
	United.EventBus = _.extend {}, Backbone.Events
	United.EventUID = 0
	United.Event = {}

	ns 'United.Views.App'
	class United.Views.App extends Backbone.View
		initialize: ->
			@model.get('session').on 'change:id', @authed, @
			@model.get('session').fetch()

		authed: (model, value, changes) ->
			switch @model.get 'controller'
				when 'schedules' then new United.Views.Tasks.ScheduleManager
					model: @model
				when 'projects' then new United.Views.Projects.ProjectList
					model: @model
				when 'users' then new United.Views.Users.UserList
					model: @model
				when 'requests' then new United.Views.Requests.RequestOverview
					model: @model
				when '' then new United.Views.Dashboard.Dashboard
					model: @model
