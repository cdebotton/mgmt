define [
	'backbone'
	'ns'
	'models/widgets/livesearch-source'
], (Backbone, ns) ->

	ns 'United.Collections.Widgets.LiveSearchSources'
	class United.Collections.Widgets.LiveSearchSources extends Backbone.Collection
		model: United.Models.Widgets.LiveSearchSource
