define [
	'backbone'
	'ns'
	'relational'
], (Backbone, ns) ->

	t = new Date()
	t.setHours 0, 0, 0, 0
	n = new Date t.getTime()
	n.setDate t.getDate() + 7

	ns 'United.Models.Dashboard.PdoRequest'
	class United.Models.Dashboard.PdoRequest extends Backbone.RelationalModel

		url: -> "/api/v1/requests"

		defaults:
			start_date: t
			end_date: n
			type: null
			message: null
			status: false

	United.Models.Dashboard.PdoRequest.setup()
