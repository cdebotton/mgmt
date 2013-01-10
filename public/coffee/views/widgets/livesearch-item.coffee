define [
	'backbone'
	'ns'
], (Backbone, ns) ->

	ns 'United.Views.Widgets.LiveSearchItem'
	class United.Views.Widgets.LiveSearchItem extends Backbone.View
		tagName: 'li'

		events:
			'click':	'selected'

		initialize: ->
			@model.on 'change:active', @highlight, @

		render: ->
			query = @model.get('query').replace /[\-\[\]{}()*+?.,\\\^$|#\s]/g, '\\$&'
			string = @model.get('name').replace new RegExp('(' + query + ')', 'ig'), ($1, match) ->
				'<strong>' + match + '</strong>'
			@$el.html "<icon class=\"icon icon-chevron-right\"></icon>#{string}"
			@

		highlight: (model, active, status) ->
			if active is true
				@$el.addClass 'active'
			else @$el.removeClass 'active'

		selected: (e) =>
			e.preventDefault()
			e.stopPropagation()
			@model.trigger 'selected', @model
