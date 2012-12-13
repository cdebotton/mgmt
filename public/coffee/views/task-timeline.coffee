define [
	'backbone',
	'ns',
	'views/user-timeline'
], (Backbone, namespace) ->

	namespace 'BU.View.TaskTimeline'
	class BU.View.TaskTimeline extends Backbone.View

		el: '#task-timeline-wrapper'

		initialize: ->
			@parent = @$el.parent()
			@model.on 'add:user', @addOne, @
			@model.on 'reset:user', @addAll, @
			@model.on 'remove:user', @addAll, @
			@addAll()

		addOne: (user) =>
			view = new BU.View.UserTimeline
				model: user
			el = view.render().$el
			@$el.append el

		addAll: (users) ->
			@model.get('users').each @addOne