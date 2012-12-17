define [
	'backbone',
	'ns',
	'views/user-timeline'
], (Backbone, namespace) ->

	namespace 'BU.Views.TaskTimeline'
	class BU.Views.TaskTimeline extends Backbone.View

		el: '#task-timeline-wrapper'

		initialize: ->
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