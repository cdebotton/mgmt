define [
	'backbone'
	'ns'
], (Backbone, ns) ->

	ns 'United.Models.Tasks.ScaleController'
	class United.Models.Tasks.ScaleController extends Backbone.Model

		defaults:
			zoom: 80