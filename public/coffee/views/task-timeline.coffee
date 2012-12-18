define [
	'backbone'
	'underscore'
	'ns'
	'views/user-timeline'
], (Backbone, _, namespace) ->

	namespace 'BU.Views.TaskTimeline'
	class BU.Views.TaskTimeline extends Backbone.View

		el: '#task-timeline-wrapper'

		initialize: ->
			BU.EventBus.on 'set-filter', @setFilter, @
			@parent = @$el.parent()
			@model.on 'add:user', @addOne, @
			@model.on 'reset:user', @addAll, @
			@model.on 'remove:user', @addAll, @
			@addAll()

		addOne: (user) =>
			view = new BU.Views.UserTimeline
				model: user
			el = view.render().$el
			@$el.append el

		addAll: (users) ->
			@model.get('users').each @addOne

		setFilter: (type, filter) ->
			@$el.html ''
			if type is null then return @addAll()
			users = @model.get('users').filter (user) ->
				matches = user.get(type).filter (item) ->
					+item.get('id') is +filter
				matches.length > 0
			
			if users.length > 0 then _.each users, @addOne