define [
	'backbone'
	'ns'
	'views/dashboard/pdo-request'
], (Backbone, ns) ->

	ns 'United.Views.Dashboard.Dashboard'
	class United.Views.Dashboard.Dashboard extends Backbone.View
		REQUEST_OPEN = false
		LIST_OPEN = false

		el: '#dashboard-container'

		events:
			'click #request-time-off': 'createNewPdo'
			'click #request-counter':  'showRequests'

		initialize: ->
			@model.get('session').on 'add:requests', @updateRequests, @
			@model.get('session').on 'remove:requests', @updateRequests, @
			United.JST.Hb.registerHelper 'getYear', @getYear
			United.JST.Hb.registerHelper 'getMonth', @getMonth
			United.JST.Hb.registerHelper 'getDate', @getDate
			United.EventBus.on 'request-closed', @requestClosed, @

		createNewPdo: (e) =>
			@model.get('session').get('requests').add {}
			@requestView = new United.Views.Dashboard.PdoRequest
				model: @model.get('session').get('requests').last()
				open: REQUEST_OPEN
			REQUEST_OPEN = true
			e.preventDefault()

		updateRequests: (model) ->
			@$('#request-counter .badge').html @model.get('session').get('requests').length

		getYear: (date) -> date.getFullYear()

		getMonth: (date) -> parseInt(date.getMonth()) + 1

		getDate: (date) -> date.getDate()

		requestClosed: -> REQUEST_OPEN = false

		showRequests: (e) =>
			view = new United.Views.Dashboard.RequestList
				model: @model.get('session')
				open: LIST_OPEN
			LIST_OPEN = true
			e.preventDefault()
