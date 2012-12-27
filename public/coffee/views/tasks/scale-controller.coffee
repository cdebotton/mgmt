define [
	'backbone'
	'jquery'
	'mousetrap'
	'ns'
	'animate'
], (Backbone, $, Mousetrap, ns) ->

	ns 'United.Views.Tasks.ScaleController'
	class United.Views.Tasks.ScaleController extends Backbone.View

		el: '#timescale-wrapper'

		events:
			'mousedown #timescale-knob':	'startDrag'
			'mousedown #timescale-slider':	'jumpDrag'
			'blur #timescale-input':		'updateZoomInput'

		initX: 0
		offset: 144

		initialize: ->
			@startListening()
			@slider = @$ '#timescale-slider'
			@knob = @$ '#timescale-knob'
			@body = $ 'body'
			@total = @slider.width() - 20
			@input = @$ '#timescale-input'
			@knob.animate { 'left': @offset }, 375, 'ease-in'
			@render()

		startListening: ->
			Mousetrap.bind ['ctrl+shift+pageup'], @zoomIn
			Mousetrap.bind ['ctrl+shift+pagedown'], @zoomOut
			BU.EventBus.on 'set-view', @setView, @
			@model.on 'change:zoom', @render, @

		stopListening: ->
			Mousetrap.unbind ['ctrl+shift+pageup'], @zoomIn
			Mousetrap.unbind ['ctrl+shift+pagedown'], @zoomOut
			@model.off 'change:zoom', @render, @
			BU.EventBus.off 'set-view', @setView, @

		startDrag: (e) =>
			@body.on 'mousemove', @onDrag
			@body.on 'mouseup', @stopDrag
			@initX = e.pageX
			e.stopPropagation()

		jumpDrag: (e) =>
			@startDrag e
			@offset = e.offsetX - 10
			if @offset < 0
				@offset = 0
			else if @offset > 180
				@offset = 180
			zoom = @zoomToOffset @offset, @total
			@model.set 'zoom', zoom
			@knob.css 'left', @offset
			BU.EventBus.trigger 'update-zoom', @model.get 'zoom'

		zoomIn: (e) =>
			zoom = @model.get('zoom') + 10
			if zoom > 100 then zoom = 100
			offset = Math.round zoom * (@total / 100)
			@jumpDrag { offsetX: offset, stopPropagation: () -> return false }
			@model.set 'zoom', zoom
			return false

		zoomOut: (e) =>
			zoom = @model.get('zoom') - 10
			if zoom < 0 then zoom = 0
			offset = Math.round zoom * (@total / 100)
			@jumpDrag { offsetX: offset, stopPropagation: () -> return false }
			@model.set 'zoom', zoom
			return false

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
			BU.EventBus.trigger 'percentage-changed'

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

		setView: (type) ->
			switch type
				when 'task' then @$el.css({ display: 'block', opacity: 0 }).stop().animate { opacity: 1 }, 75, 'ease-out'
				else @$el.stop().animate { opacity: 0 }, 75, 'ease-in', => @$el.css { display: 'none' }