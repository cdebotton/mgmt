define [
	'backbone'
	'ns'
	'jst'
], (Backbone, ns) ->

	ns 'United.Views.Dashboard.PdoList'
	class United.Views.Dashboard.PdoList extends Backbone.View
		MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

		el: '#pdo-list'

		initialize: ->
			United.JST.Hb.registerHelper 'printRequests', @printRequests

		render: ->
			ctx = @model.toJSON()
			html = United.JST.PdoRequestList ctx
			@$el.html html
			@

		printRequests: (requests, opts) ->
			if requests?.length
				buffer = ''
				for request, i in requests
					s = request.start_date
					e = request.end_date
					item = {}
					item.id = request.id
					item.type = (request.type.split(' ').map (word) -> word[0].toUpperCase() + word.slice(1).toLowerCase()).join ' '
					item.start = MONTHS[s.getMonth()] + '. ' + s.getDate() + ', ' + s.getFullYear()
					item.end = MONTHS[e.getMonth()] + '. ' + e.getDate() + ', ' + e.getFullYear()
					item.status = if item.status is true then 'Approved' else 'Unapproved'
				buffer += opts.fn item
			else return opts.inverse()
