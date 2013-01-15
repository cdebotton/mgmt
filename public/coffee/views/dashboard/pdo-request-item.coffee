define [
	'backbone'
	'ns'
	'jst'
], (Backbone, ns) ->

	ns 'United.Views.Dashboard.PdoRequestItem'
	class United.Views.Dashboard.PdoRequestItem extends Backbone.View
		MONTHS = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']

		tagName: 'li'

		events:
			'click .delete-request':		'deleteRequest'

		initialize: ->
			United.JST.Hb.registerHelper 'formatDate', @formatDate
			United.JST.Hb.registerHelper 'printStatus', @printStatus
			@model.on 'destroy', @remove, @

		render: ->
			ctx = @model.toJSON()
			html = United.JST.PdoRequestListItem ctx
			@$el.html html
			@

		formatDate: (date) ->
			date = new Date date
			MONTHS[date.getMonth()] + '. ' + date.getDate() + ', ' + date.getFullYear()

		printStatus: (status) ->
			if status is true then 'Approved' else 'Unapproved'

		deleteRequest: (e) =>
			e.preventDefault()
			@model.destroy()
