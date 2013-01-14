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
			console.log @model.get('session')

		createNewPdo: (e) =>

			e.preventDefault()
