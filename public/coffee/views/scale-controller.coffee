define [
	'backbone'
	'ns'
	'animate'
], (Backbone, ns) ->

	ns 'BU.Views.ScaleController'
	class BU.Views.ScaleController extends Backbone.View

		el: '#timescale-wrapper'

		events:
			'mousedown #timescale-knob':	'startDrag'
			'blur #timescale-input':		'updateZoomInput'

		initX: 0
		offset: 144

		initialize: ->
			@model.on 'change:zoom', @render, @
			@slider = @$ '#timescale-slider'
			@knob = @$ '#timescale-knob'
			@body = $ 'body'
			@total = @slider.width() - 20
			@input = @$ '#timescale-input'
			@knob.animate { 'left': @offset }, 375, 'ease-in'
			@render()

		startDrag: (e) =>
			@initX = e.pageX
			@body.on 'mousemove', @onDrag
			@body.on 'mouseup', @stopDrag

		onDrag: (e) =>
			dx = e.pageX - @initX
			@offset += dx
			if @offset < 0
				@offset = 0
			else if @offset > 180
				@offset = 180
			@knob.css 'left', @offset
			@initX = e.pageX
			zoom = @zoomToOffset @offset, @total
			@model.set 'zoom', zoom
			BU.EventBus.trigger 'update-zoom', @model.get 'zoom'

		render: ->
			@input.val @model.get 'zoom'

		stopDrag: (e) =>
			@body.off 'mousemove', @onDrag
			@body.off 'mouseup', @stopDrag

		updateZoomInput: (e) =>
			zoom = e.currentTarget.value
			if zoom > 100 then zoom = 100
			else if zoom < 0 then zoom = 0
			@model.set 'zoom', zoom
			@knob.animate { left: @offsetToZoom zoom }, 375, 'ease-in'
			BU.EventBus.trigger 'update-zoom', @model.get 'zoom'

		zoomToOffset: (offset, total) ->
			Math.ceil 100 * (offset / total)

		offsetToZoom: (value) ->
			Math.round value * (@total / 100)