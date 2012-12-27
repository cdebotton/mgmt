define [
	'backbone'
	'ns'
	'models/clients/client'
], (Backbone, ns) ->

	ns 'United.Collections.Clients.Clients'
	class United.Collections.Clients.Clients extends Backbone.Collection
		model: United.Models.Clients.Client