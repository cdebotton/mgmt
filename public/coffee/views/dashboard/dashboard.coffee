define [
	'backbone'
	'ns'
	'views/dashboard/pdo-request'
], (Backbone, ns) ->

	ns 'United.Views.Dashboard.Dashboard'
	class United.Views.Dashboard.Dashboard extends Backbone.View
		REQUEST_OPEN = false

		el: '#dashboard-container'

		events:
			'click #request-time-off': 'createNewPdo'

		initialize: ->
			United.JST.Hb.registerHelper 'getYear', @getYear
			United.JST.Hb.registerHelper 'getMonth', @getMonth
			United.JST.Hb.registerHelper 'getDate', @getDate
			United.EventBus.on 'request-closed', @requestClosed, @
			@model.get('session').on 'add:requests', @editRequest, @

		createNewPdo: (e) =>
			@model.get('session').get('requests').add {}
			e.preventDefault()

		editRequest: (request) ->
			@requestView = new United.Views.Dashboard.PdoRequest
				model: request
				open: REQUEST_OPEN
			REQUEST_OPEN = true

		getYear: (date) -> date.getFullYear()

		getMonth: (date) -> parseInt(date.getMonth()) + 1

		getDate: (date) -> date.getDate()

		requestClosed: -> REQUEST_OPEN = false
