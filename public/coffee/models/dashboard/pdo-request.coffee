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

		parse: (resp) ->
			if resp.start_date? and not resp.start_date instanceof Date
				resp.start_date = new Date resp.start_date
			if resp.end_date? and not resp.end_date instanceof Date
				resp.end_date = new Date resp.end_date
			resp

	United.Models.Dashboard.PdoRequest.setup()
