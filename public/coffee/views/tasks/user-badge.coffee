define [
	'backbone',
	'ns',
	'jst'
], (Backbone, namespace) ->

	namespace 'United.Views.Tasks.UserBadge'
	class United.Views.Tasks.UserBadge extends Backbone.View

		tagName: 'article'
		
		className: 'user-object'

		initialize: ->
			@model.get('tasks').on 'change:track', @adjustHeight, @

		render: ->
			ctx = @model.toJSON()
			html = BU.JST['UserBadge'] ctx
			@$el.html html
			@adjustHeight()
			@

		adjustHeight: (model, value, status) ->
			highest = (@model.get('tasks').max (task) -> +task.get('track'))?.get 'track'
			if highest > 2
				@$el.css 'height', (highest * 60) + 70
			else @$el.css 'height', 184