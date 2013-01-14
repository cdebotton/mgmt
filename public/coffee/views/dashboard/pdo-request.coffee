define [
	'backbone'
	'ns'
	'animate'
], (Backbone, ns) ->

	ns 'United.Views.Dashboard.PdoRequest'
	class United.Views.Dashboard.PdoRequest extends Backbone.View
		el: '#pdo-request'

		initialize: ->
