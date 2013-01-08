define [
	'backbone'
	'ns'
	'relational'
], (Backbone, ns) ->

	ns 'United.Models.Widgets.LiveSearchSource'
	class United.Models.Widgets.LiveSearchSource extends Backbone.RelationalModel
	United.Models.Widgets.LiveSearchSource.setup()
