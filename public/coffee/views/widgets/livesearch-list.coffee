define [
	'backbone'
	'ns'
], (Backbone, ns) ->

	ns 'United.Views.Widgets.LiveSearchList'
	class United.Views.Widgets.LiveSearchList extends Backbone.View
		tagName: 'ul'

		clasName: 'livesearch-list'

		initialize: ->
