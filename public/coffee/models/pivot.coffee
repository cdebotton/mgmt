define [
	'backbone'
	'ns'
	'relational'
], (Backbone, ns) ->

	ns 'BU.Models.Pivot'
	class BU.Models.Pivot extends Backbone.RelationalModel