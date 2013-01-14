define [
	'backbone'
	'ns'
	'relational'
], (Backbone, ns) ->

	ns 'United.Models.Dashboard.PdoRequest'
	class United.Models.Dashboard.PdoRequest extends Backbone.RelationalModel

	United.Models.Dashboard.PdoRequest.setup()
