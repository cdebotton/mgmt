define [
	'backbone'
	'ns'
	'models/pdos/pdo'
], (Backbone, ns) ->

	ns 'United.Collections.Pdos.Pdos'
	class United.Collections.Pdos.Pdos extends Backbone.Collection
		model: United.Models.Pdos.Pdo
