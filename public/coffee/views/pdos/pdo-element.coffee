define [
	'backbone'
	'ns'
], (Backbone, ns) ->

	ns 'United.Views.Pdos.PdoElement'
	class United.Views.Pdos.PdoElement extends Backbone.View
		tagName: 'div'

		className: 'pdo-element'

		initialize: () ->
			United.EventBus.on 'gridpoint-dispatch', @gridPointsReceived, @
			United.EventBus.on 'offset-timeline', @offsetTimeline, @

		render: ->
			United.EventBus.trigger 'where-am-i', @cid, @model.get('start_date'), @model.get('end_date')
			@$el.html('<article>Out<br/>of<br/>office.</article>')
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
