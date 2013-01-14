define [
	'backbone'
	'ns'
	'models/dashboard/pdo-request'
], (Backbone, ns) ->

	ns 'United.Collections.Dashboard.PdoRequests'
	class United.Collections.Dashboard.PdoRequests extends Backbone.Collection
		model: United.Models.Dashboard.PdoRequest
