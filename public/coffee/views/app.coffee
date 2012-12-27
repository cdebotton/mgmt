define [
	'backbone'
	'underscore'
	'ns'
	'views/tasks/schedule-manager'
	
], (Backbone, _, namespace) ->
	
	namespace 'BU.EventBus'
	BU.EventBus = _.extend {}, Backbone.Events

	namespace 'United.Views.App'
	class United.Views.App extends Backbone.View

		initialize: ->
			@model.get('session').on 'change:id', @authed, @
			@model.get('session').fetch()

		authed: (model, value, changes) ->
			switch @model.get 'controller'
				when 'schedules' then new United.Views.Tasks.ScheduleManager
					model: @model
				when 'projects' then return