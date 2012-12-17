define [
	'backbone',
	'ns',
	'jst'
], (Backbone, namespace) ->

	namespace 'BU.Views.GraphTimeline'
	class BU.Views.GraphTimeline extends Backbone.View

		el: '#graph-timeline-wrapper'
		DAY_TO_MILLISECONDS = 86400000
		months: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec']
		days: ['Mon', 'Tues', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun']
		today: new Date()
		currentTime: null
		ticks: {dates: []}
		grid: {}
		RANGE = 504
		XHOME: 0
		OFFSET: 0
		DRAGGING = false
		events:
			'mousedown':	'startDrag'

		initialize: ->
			BU.EventBus.on 'on-scroll', @affix, @
			BU.EventBus.on 'adjust', @adjust, @
			BU.EventBus.on 'update-timeline-transform', @updateTransform, @
			BU.EventBus.on 'plot-ranges', @plotRanges, @
			BU.JST.Hb.registerHelper 'outputGraph', @outputGraph

			@body = $ 'body'
			@body.on 'mousemove', @onDrag
			@body.on 'mouseup', @stopDrag
			@parent = @$el.parent()
			@dy = @$el.offset().top

			today = new Date()
			today.setHours 0
			today.setMinutes 0
			today.setSeconds 0
			today.setMilliseconds 0
			@currentTime = today.getTime()

			start = new Date @currentTime - @countMilli RANGE / 2
			start.setHours 0
			start.setMinutes 0
			start.setSeconds 0
			start.setMilliseconds 0

			end = new Date @currentTime + @countMilli RANGE / 2
			end.setHours 0
			end.setMinutes 0
			end.setSeconds 0
			end.setMilliseconds 0

			@drawTicks start, end
			BU.EventBus.on 'where-am-i', @locateTimelineObject, @
			@render start, today

		drawTicks: (start, end) ->
			@ticks = {dates: []}
			dx = 0
			c = 0
			d = start
			while d <= end
				epoch = d.getTime()
				@grid[epoch] = dx
				dx += 21
				if c % 7 is 0
					@ticks.dates.push {
						dx: dx
						epoch: epoch
						readable: @readableDate d
					}
				c++
				d.setDate d.getDate() + 1

		locateTimelineObject: (cid, start_date, end_date) ->
			p1 = (new Date start_date).getTime()
			p2 = (new Date end_date).getTime()
			x = @grid[@currentTime]
			dx = @grid[p1] - x + 50
			dx2 = @grid[p2] - x + 50
			BU.EventBus.trigger 'gridpoint-dispatch', cid, dx, dx2, @OFFSET

		render: (start, target) ->
			ctx = @ticks
			html = BU.JST['GraphTimeline'] ctx
			@$el.html html
			dx = -@calculateOffset start, target
			@$el.css
				width: 4 * Math.abs dx
				left: dx
			@

		startDrag: (e) =>
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
			BU.EventBus.trigger 'offset-timeline', values
			e.preventDefault()

		stopDrag: (e) =>
			DRAGGING = false
			@XHOME = 0
			e.preventDefault()

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

		calculateDayOffset: (start, target) ->
			(target.getTime() - start.getTime()) / DAY_TO_MILLISECONDS

		calculateOffset: (start, target) ->
			epochDiff = @calculateDayOffset start, target
			px = - (21 * epochDiff) - 75
			px

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
			BU.EventBus.trigger 'offset-timeline', values

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
			BU.EventBus.trigger 'percentage-points-calculated', response, caller