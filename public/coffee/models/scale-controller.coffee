define [
	'backbone'
	'ns'
], (Backbone, ns) ->

	ns 'BU.Models.ScaleController'
	class BU.Models.ScaleController extends Backbone.Model

		defaults:
			zoom: 80