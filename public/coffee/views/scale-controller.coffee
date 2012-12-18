define [
	'backbone'
	'ns'
], (Backbone, ns) ->

	ns 'BU.Views.ScaleController'
	class BU.Views.ScaleController extends Backbone.View

		el: '#timescale-wrapper'

		events:
			'mousedown #timescale-knob':	'startDrag'

		initX: 0
		offset: 0

		initialize: ->
			@slider = @$ '#timescale-slider'
			@knob = @$ '#timescale-knob'
			@body = $ 'body'
			@total = @slider.width() - 20

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
			percentage = Math.ceil 100 * (@offset / @total)
			console.log percentage

		stopDrag: (e) =>
			@body.off 'mousemove', @onDrag
			@body.off 'mouseup', @stopDrag