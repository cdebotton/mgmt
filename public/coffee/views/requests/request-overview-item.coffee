define [
	'backbone'
	'ns'
], (Backbone, ns) ->

	ns 'United.Views.Requests.RequestOverviewItem'
	class United.Views.Requests.RequestOverviewItem extends Backbone.View
		tagName: 'article'

		className: 'request-overview-item'
