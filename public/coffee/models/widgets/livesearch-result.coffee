define [
	'backbone'
	'ns'
	'relational'
], (Backbone, ns) ->

	ns 'United.Models.Widgets.LiveSearchResult'
	class United.Models.Widgets.LiveSearchResult extends Backbone.RelationalModel
	United.Models.Widgets.LiveSearchResult.setup()
