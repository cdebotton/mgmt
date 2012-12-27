define [
	'backbone'
	'ns'
	'views/tasks/user-calendar'
], (Backbone, ns) ->

	ns 'United.Views.Tasks.CalendarView'
	class United.Views.Tasks.CalendarView extends Backbone.View

		el: '#calendar-view'

		initialize: ->
			@container = $ '.container'
			@startListening()

		startListening: ->
			@model.on 'add:users', @addOne, @
			@model.on 'reset:users', @addAll, @

		stopListening: ->
			@model.off 'add:users', @addOne, @
			@model.off 'reset:users', @addAll, @

		addOne: (user) =>
			view = new United.Views.Tasks.UserCalendar
				model: user
			html = view.render().$el
			@container.append html

		addAll: (collection) ->
			@container.html ''
			@model.get('users').each @addOne