define [
	'backbone'
	'ns'
	'views/dashboard/pdo-request'
], (Backbone, ns) ->

	ns 'United.Views.Dashboard.Dashboard'
	class United.Views.Dashboard.Dashboard extends Backbone.View
		el: '#dashboard-container'

		events:
			'click #request-time-off': 'createNewPdo'

		initialize: ->

		createNewPdo: (e) =>
			e.preventDefault()
