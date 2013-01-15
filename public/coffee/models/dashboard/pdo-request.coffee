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
			message: ''
			status: false

		isValid: () ->
			if not (new Date @attributes.start_date) instanceof Date
				return 'The start date is not a valid date.'
			if not (new Date @attributes.end_date) instanceof Date
				return 'The end date is not a valid date.'
			if @attributes.end_date < @attributes.start_date
				return 'The end date must come after the start date'
			if @attributes.type is null or @attributes.type is 'null'
				return 'You must select a type of request.'
			else return true

		parse: (resp) ->
			if resp.start_date? and not resp.start_date instanceof Date
				resp.start_date = new Date resp.start_date
			if resp.end_date? and not resp.end_date instanceof Date
				resp.end_date = new Date resp.end_date
			resp

	United.Models.Dashboard.PdoRequest.setup()
