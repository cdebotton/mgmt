define [
	'backbone'
	'underscore'
	'ns'
	'views/requests/request-overview-item'
], (Backbone, _, ns) ->

	ns 'United.Views.Requests.RequestOverview'
	class United.Views.Requests.RequestOverview extends Backbone.View
		MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

		el: '#request-overview-body'

		initialize: ->
			United.JST.Hb.registerHelper 'printType', @printType
			United.JST.Hb.registerHelper 'printTypeClass', @printTypeClass
			United.JST.Hb.registerHelper 'printDate', @printDate
			United.JST.Hb.registerHelper 'printMsg', @printMsg
			@requests = new Backbone.Collection window.requests
			@requests.on 'add', @addOne, @
			@requests.on 'reset', @addAll, @
			@addAll()

		addOne: (item) ->
			view = new United.Views.Requests.RequestOverviewItem
				model: item
			@$el.append view.render().$el
			view.setup()

		addAll: (items) ->
			@$el.html ''
			@requests.each _.bind @addOne, @

		printType: (type) ->
			new United.JST.Hb.SafeString (type.split(' ').map (word) ->
				word[0].toUpperCase() + word.slice(1).toLowerCase()).join ' '

		printTypeClass: (type) ->
			switch type
				when 'vacation' then 'info'
				when 'jury duty' then 'warning'
				when 'maternity leave' then 'danger'
				when 'voting' then 'success'
				when 'funeral leave' then 'important'
				else 'inverse'

		printDate: (date) ->
			date = new Date date
			MONTHS[date.getMonth() + 1] + ' ' + date.getDate() + ', ' + date.getFullYear()

		printMsg: (msg) ->
			new Handlebars.SafeString msg
