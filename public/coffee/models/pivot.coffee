define [
	'backbone'
	'ns'
	'relational'
], (Backbone, ns) ->

	ns 'BU.Model.Pivot'
	class BU.Model.Pivot extends Backbone.RelationalModel