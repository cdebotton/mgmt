define [
	'backbone'
	'ns'
	'jst'
], (Backbone, ns) ->

	ns 'United.Views.Pdos.PdoElement'
	class United.Views.Pdos.PdoElement extends Backbone.View
		MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

		tagName: 'div'

		className: 'pdo-element'

		initialize: () ->
			United.EventBus.on 'gridpoint-dispatch', @gridPointsReceived, @
			United.EventBus.on 'offset-timeline', @offsetTimeline, @
			United.EventBus.on 'zoom-grid-updated', @updateZoom, @
			United.JST.Hb.registerHelper 'printDate', @printDate

		render: ->
			United.EventBus.trigger 'where-am-i', @cid, @model.get('start_date'), @model.get('end_date')
			ctx = @model.toJSON()
			html = United.JST.PdoElement ctx
			@$el.html html
			@

		gridPointsReceived: (cid, p1, p2, offset) ->
			if cid isnt @cid then return false
			dx = p1
			width = p2 - p1
			@$el.css
				marginLeft: dx
				width: width
				marginTop: 10 +@model.get('track') * 60
				'-webkit-transform':	"translate3d(#{offset}px, 0, 0)"

		offsetTimeline: (dx) ->
			@$el.css
				'-webkit-transform':	"translate3d(#{dx})"

		updateZoom: (zoom) ->
			United.EventBus.trigger 'where-am-i', @cid, @model.get('start_date'), @model.get 'end_date'

		printDate: (date) ->
			date = new Date date
			new Handlebars.SafeString MONTHS[date.getMonth()] + ' ' + date.getDate() + ', ' + date.getFullYear()
