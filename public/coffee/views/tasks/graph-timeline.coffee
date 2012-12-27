define [
	'backbone'
	'mousetrap'
	'ns'
	'jst'
], (Backbone,  Mousetrap, ns) ->

	ns 'United.Views.Tasks.GraphTimeline'
	class United.Views.Tasks.GraphTimeline extends Backbone.View

		el: '#graph-timeline-wrapper'
		DAY_TO_MILLISECONDS = 86400000
		months: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec']
		days: ['Mon', 'Tues', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun']
		currentTime: null
		ticks: {dates: []}
		grid: {}
		RANGE = 1008
		XHOME: 0
		OFFSET: 0
		DRAGGING = false
		PX_PER_DAY = 41
		zoomLevels: []
		events:
			'mousedown':	'startDrag'

		initialize: ->
			@startListening()
			United.JST.Hb.registerHelper 'outputGraph', @outputGraph
			@body = $ 'body'
			@parent = @$el.parent()
			@dy = @$el.offset().top
			@generateDateRanges()
			@drawTicks()
			@render()
			min = 11
			lim = 201
			range = [min...lim]
			@zoomLevels.push num for num in range by 2

		startListening: ->
			Mousetrap.bind 'ctrl+shift+left', @shiftBackMonth
			Mousetrap.bind 'ctrl+shift+right', @shiftRightMonth
			United.EventBus.on 'update-zoom', @updateZoom, @
			United.EventBus.on 'on-scroll', @affix, @
			United.EventBus.on 'adjust', @adjust, @
			United.EventBus.on 'update-timeline-transform', @updateTransform, @
			United.EventBus.on 'plot-ranges', @plotRanges, @
			United.EventBus.on 'where-am-i', @locateTimelineObject, @
			United.EventBus.on 'offset-timeline-from-user-timeline', @offsetTimelineFromUserTimeline, @
			document.addEventListener 'mouseout', @mouseout, false
			@$el.parent().show()

		stopListening: ->
			Mousetrap.unbind 'ctrl+left', @shiftBackMonth
			Mousetrap.unbind 'ctrl+right', @shiftRightMonth
			United.EventBus.off 'update-zoom', @updateZoom, @
			United.EventBus.off 'on-scroll', @affix, @
			United.EventBus.off 'adjust', @adjust, @
			United.EventBus.off 'update-timeline-transform', @updateTransform, @
			United.EventBus.off 'plot-ranges', @plotRanges, @
			United.EventBus.off 'where-am-i', @locateTimelineObject, @
			United.EventBus.off 'offset-timeline-from-user-timeline', @offsetTimelineFromUserTimeline, @
			document.removeEventListener 'mouseout', @mouseout, false
			@$el.parent().hide()

		mouseout: (e) =>
			if DRAGGING
				from = e.relatedTarget or e.toElement
				if not from or from.nodeName is 'HTML'
					return @stopDrag e

		generateDateRanges: () ->
			@today = new Date()
			@today.setHours 0
			@today.setMinutes 0
			@today.setSeconds 0
			@today.setMilliseconds 0
			@currentTime = @today.getTime()

			@start = new Date @currentTime - @countMilli RANGE / 2
			@start.setHours 0
			@start.setMinutes 0
			@start.setSeconds 0
			@start.setMilliseconds 0

			@end = new Date @currentTime + @countMilli RANGE / 2
			@end.setHours 0
			@end.setMinutes 0
			@end.setSeconds 0
			@end.setMilliseconds 0

		drawTicks: () ->
			@ticks = {dates: []}
			dx = 0
			c = 0
			d = @start
			while d <= @end
				epoch = d.getTime()
				@grid[epoch] = dx
				dx += PX_PER_DAY
				if c % 7 is 0
					@ticks.dates.push {
						dx: dx
						epoch: epoch
						readable: @readableDate d
					}
				c++
				d.setDate d.getDate() + 1

		locateTimelineObject: (cid, @start_date, @end_date) ->
			p1 = (new Date @start_date).getTime()
			p2 = (new Date @end_date).getTime()
			x = @grid[@currentTime]
			dx = @grid[p1] - x + 50
			dx2 = @grid[p2] - x + 50
			United.EventBus.trigger 'gridpoint-dispatch', cid, dx, dx2, @OFFSET

		render: (redraw = true) ->
			if redraw is true
				ctx = @ticks
				html = United.JST['GraphTimeline'] ctx
				@$el.html html
			dx = -@calculateOffset()
			@$el.css
				width: 4 * Math.abs dx
				left: dx
			@

		startDrag: (e) =>
			@body.on 'mousemove', @onDrag
			@body.on 'mouseup', @stopDrag
			@XHOME = e.originalEvent.clientX
			DRAGGING = true
			e.preventDefault()

		onDrag: (e) =>
			if not DRAGGING then return false
			nextDx = @XHOME - e.originalEvent.clientX
			@OFFSET += parseInt nextDx * 1.75
			@XHOME = e.originalEvent.clientX
			values = ["#{@OFFSET}px", 0, 0].join ', '
			@$el.css '-webkit-transform': "translate3d(#{values})"
			United.EventBus.trigger 'offset-timeline', values
			e.preventDefault()

		stopDrag: (e) =>
			@body.off 'mousemove', @onDrag
			@body.off 'mouseup', @stopDrag
			DRAGGING = false
			@XHOME = 0
			e.preventDefault()

		shiftBackMonth: (e) =>
			time = new Date @currentTime - (30 * DAY_TO_MILLISECONDS)
			time.setHours 0
			time.setMinutes 0
			time.setSeconds 0
			time.setMilliseconds 0
			px = @grid[time.getTime()]
			#@$el.css '-webkit-transform': "translate3d(#{values.join ', '})"
			#United.EventBus.trigger 'offset-timeline', values

		shiftRightMonth: (e) =>
			console.log 'right'

		affix: (scrollTop) ->
			scrollTop += 42
			if scrollTop > @dy then @parent.addClass 'affix'
			else @parent.removeClass 'affix'

		outputGraph: (array, options) ->
			if array?.length > 0
				buffer = ''
				for item, i in array
					item.ticks = []
					item.ticks.push i for i in [0...6]
					buffer += options.fn item
				return buffer
			else options.elseFn()

		calculateDayOffset: () ->
			(@today.getTime() - @start.getTime()) / DAY_TO_MILLISECONDS

		calculateOffset: () ->
			epochDiff = @calculateDayOffset()
			px = - (PX_PER_DAY * epochDiff) - 75


		getMonth: (date) -> @months[date.getMonth()]

		getYear: (date) -> date.getFullYear()

		getDate: (date) -> date.getDate()

		getDay: (date) ->
			dayVal = date.getDay() - 1
			if dayVal < 0 then dayVal = 6
			@days[dayVal]

		countMilli: (days) -> DAY_TO_MILLISECONDS * days

		readableDate: (date) -> "#{@getDay date} #{@getMonth date} #{@getDate date} #{@getYear date}"

		adjust: (@ww, @wh) -> return

		updateTransform: (x, left, right, dx) ->
			if dx > 0 and right > (@ww - 175)
				@OFFSET += - (right - @ww) - 175
			else if dx < 0 and left < 250
				@OFFSET -= - (left + 50)
			values = ["#{@OFFSET}px", 0, 0].join ', '
			@$el.css '-webkit-transform': "translate3d(#{values})"
			United.EventBus.trigger 'offset-timeline', values

		offsetTimelineFromUserTimeline: (values) ->
			@$el.css '-webkit-transform': "translate3d(#{values})"
			United.EventBus.trigger 'offset-timeline', values

		plotRanges: (ranges, caller) ->
			response = []
			for range, r in ranges
				x = @grid[range[0].getTime()] - @grid[@currentTime] + 50
				width = @grid[range[1].getTime()] - @grid[@currentTime] - x + 50
				response.push {
					x: x
					width: width
					value: range[2]
				}
			United.EventBus.trigger 'percentage-points-calculated', response, caller

		updateZoom: (zoom) ->
			if PX_PER_DAY isnt (px = @zoomLevels[zoom])
				PX_PER_DAY = px
				@generateDateRanges()
				@drawTicks()
				@render false
				@$('.tick-mark+.tick-mark').css {
					marginLeft: px-1
				}
				United.EventBus.trigger 'zoom-grid-updated'