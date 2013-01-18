define [
	'backbone'
	'ns'
	'morris'

], (Backbone, ns, Morris) ->

	ns 'United.Views.Dashboard.PdoGraph'
	class United.Views.Dashboard.PdoGraph extends Backbone.View
		el: '#pdo-graph'

		initialize: -> @render()

		render: ->
			json = window.jsonPdoGrid
			data = []
			for date, pdos of json
				data.push {
					q: date
					a: pdos.pdo_count
					b: pdos.pdo_credit.toFixed 2
				}
			Morris.Line
				element: 'pdo-graph',
				data: data,
				xkey: 'q',
				ykeys: ['a', 'b'],
				labels: ['Accrued', 'Rate'],
				lineColors: ['#3a87ad','#b4d5e6'],
				lineWidth: 2
				dateFormat: (x) ->
					date = new Date x
					"#{date.getFullYear()}-#{date.getMonth()+1}"
				xLabels: 'month'
				smooth: false
