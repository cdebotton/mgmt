define [
	'backbone'
	'underscore'
	'ns'
	'animate'
	'views/widgets/livesearch-item'
], (Backbone, _, ns) ->

	ns 'United.Views.Widgets.LiveSearchList'
	class United.Views.Widgets.LiveSearchList extends Backbone.View
		EXPOSED = false

		tagName: 'ul'

		className: 'livesearch-list'

		initialize: ->
			United.EventBus.on 'search-results-found', @render, @
			United.EventBus.on 'live-search-hide', @hide, @

		render: (query, results, src) ->
			if src isnt @options.listenTo then return
			if not EXPOSED then @expose()
			@$el.html ''
			results.each (result, key) =>
				result.set 'query', query
				view = new United.Views.Widgets.LiveSearchItem
					model: result
				html = view.render().$el
				@$el.append html

		expose: ->
			EXPOSED = true
			@$el.css {
				opacity: 0
				display: 'block'
			}
			@$el.animate { opacity: 1 }, 175, 'ease-in'

		hide: (src) ->
			if src isnt @options.listenTo or not EXPOSED then return
			EXPOSED = false
			@$el.animate {
				opacity: 0
			}, 175, 'ease-out', =>
				@$el.html ''
				@$el.css 'display', 'none'
