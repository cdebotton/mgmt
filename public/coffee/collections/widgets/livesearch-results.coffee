define [
	'backbone'
	'ns'
	'models/widgets/livesearch-result'
], (Backbone, ns) ->

	ns 'United.Collections.Widgets.LiveSearchResults'
	class United.Collections.Widgets.LiveSearchResults extends Backbone.Collection
		model: United.Models.Widgets.LiveSearchResult
