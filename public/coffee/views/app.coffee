define [
	'backbone'
	'underscore'
	'ns'
	'views/tasks/schedule-manager'
	'views/projects/project-list'
	
], (Backbone, _, ns) ->
	
	ns 'United.EventBus'
	United.EventBus = _.extend {}, Backbone.Events

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