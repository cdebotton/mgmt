define [
	'backbone'
	'ns'
	'relational'
], (Backbone, ns) ->

	ns 'United.Models.Pdos.Pdo'
	class United.Models.Pdos.Pdo extends Backbone.RelationalModel
	United.Models.Pdos.Pdo.setup()
