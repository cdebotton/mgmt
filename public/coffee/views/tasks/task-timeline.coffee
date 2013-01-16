define [
	'backbone'
	'underscore'
	'ns'
	'views/tasks/user-timeline'
], (Backbone, _, ns) ->

	ns 'United.Views.Tasks.TaskTimeline'
	class United.Views.Tasks.TaskTimeline extends Backbone.View

		el: '#task-timeline-wrapper'

		views: []

		initialize: ->
			@startListening()
			@parent = @$el.parent()
			@model.on 'add:user', @addOne, @
			@model.on 'reset:user', @addAll, @
			@model.on 'remove:user', @addAll, @

			@addAll()

		startListening: ->
			United.EventBus.on 'set-filter', @setFilter, @
			@$el.parent().show()

		stopListening: ->
			United.EventBus.off 'set-filter', @setFilter, @
			@$el.parent().hide()

		addOne: (user) =>
			view = new United.Views.Tasks.UserTimeline
				model: user
			@views.push view
			el = view.render().$el
			@$el.append el

		addAll: (users) ->
			@model.get('users').each @addOne

		setFilter: (type, filter) ->
			_.each @views, (view) -> view.remove()
			if type is null then return @addAll()
			users = @model.get('users').filter (user) ->
				matches = user.get(type).filter (item) ->
					+item.get('id') is +filter
				matches.length > 0
			if users.length > 0 then _.each users, @addOne
