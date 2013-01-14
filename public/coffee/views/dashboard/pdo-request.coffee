define [
	'backbone'
	'ns'
	'animate'
	'jst'
], (Backbone, ns) ->
	t = new Date()
	t.setHours 0, 0, 0, 0
	n = new Date()
	n.setDate t.getDate() + 7
	ns 'United.Views.Dashboard.PdoRequest'
	class United.Views.Dashboard.PdoRequest extends Backbone.View
		el: '#pdo-request'

		defaults:
			start_date: t
			end_date: n

		initialize: ->

