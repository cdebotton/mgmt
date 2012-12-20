define [
	'backbone'
	'underscore'
	'jquery'
	'ns'
	'jst'
	'views/task-element'
	'views/overage'
], (Backbone, _, $, namespace) ->

	namespace 'BU.Views.UserTimeline'
	class BU.Views.UserTimeline extends Backbone.View

		tagName: 'article'

		className: 'timeline-object'

		overages: []

		DRAGGING = false

		OFFSET: 0

		events:
			'mousedown':	'startDrag'

		initialize: ->
			@body = $ 'body'
			@startListening()

		startListening: ->
			if BU.Session.isAdmin()
				BU.EventBus.on 'percentage-points-calculated', @drawRanges, @
				BU.EventBus.on 'percentage-changed', @calculateOverages, @
				@model.get('tasks').on 'change:start_date change:end_date change:user change:percentage', @calculateOverages, @
				BU.EventBus.on 'zoom-grid-updated', @calculateOverages, @			

			BU.EventBus.on 'task-added', @taskCreated, @
			@model.on 'add:tasks', @addOne, @
			@model.on 'reset:tasks remove:tasks', @addAll, @
			@model.get('tasks').on 'change:track', @adjustHeight, @

		stopListening: ->
			if BU.Session.isAdmin()
				BU.EventBus.off 'percentage-points-calculated', @drawRanges, @
				BU.EventBus.off 'zoom-grid-updated', @calculateOverages, @
				BU.EventBus.off 'percentage-changed', @calculateOverages, @
				@model.get('tasks').off 'change:start_date change:end_date change:user change:percentage', @calculateOverages, @

			BU.EventBus.off 'task-added', @taskCreated, @
			@model.off 'add:tasks', @addOne, @
			@model.off 'reset:tasks remove:tasks', @addAll, @
			@model.get('tasks').off 'change:track', @adjustHeight, @
		render: ->
			ctx = @model.toJSON()
			html = BU.JST['UserTimeline'] ctx
			@$el.html html
			@addAll()
			@adjustHeight()
			if BU.Session.isAdmin()
				@calculateOverages()
			@

		calculateOverages: () ->
			tasks = @model.get('tasks')
			starts = tasks.pluck 'start_date'
			ends = tasks.pluck 'end_date'
			ranges = []
			dates = _.uniq starts.concat(ends).sort((a,b) -> a-b), true, (date, index, array) -> date.getTime()
			for date, i in dates
				if i < dates.length-1
					ranges.push [date, dates[i+1]]
			for range, i in ranges
				startpoint = range[0]
				endpoint = range[1]
				totalPercentage = 0
				for k in [0...tasks.length]
					task = tasks.at k
					taskstart = task.get 'start_date'
					taskend = task.get 'end_date'
					if (startpoint < taskend) and (endpoint > taskstart)
						totalPercentage += +task.get 'percentage'
				range.push totalPercentage
			BU.EventBus.trigger 'plot-ranges', ranges, @cid

		drawRanges: (response, caller) ->
			if caller isnt @cid then return
			_.each @overages, (range) -> range.clear()
			@overages = []
			for range in response
				view = new BU.Views.Overage
					model: new Backbone.Model range
				html = view.render().$el
				@overages.push view
				@$el.append html

		taskCreated: (task, userId) ->
			if userId is @model.get 'id'
				@addOne task

		addOne: (task) =>
			view = new BU.Views.TaskElement
				model: task
			html = view.render().$el
			@$el.append html

		addAll: ->
			@$el.html ''
			@model.get('tasks').each @addOne

		adjustHeight: (model, value, status) ->
			highest = (@model.get('tasks').max (task) -> +task.get('track'))?.get 'track'
			if highest > 2
				@$el.css 'height', (highest * 60) + 65
			else @$el.css 'height', 185

		startDrag: (e) =>
			@body.on 'mousemove', @onDrag
			@body.on 'mouseup', @stopDrag
			@XHOME = e.originalEvent.clientX
			DRAGGING = true
			e.stopPropagation()
			e.preventDefault()

		onDrag: (e) =>
			if not DRAGGING then return false
			e.stopPropagation()
			nextDx = @XHOME - e.originalEvent.clientX
			@OFFSET += parseInt nextDx * 1.75
			@XHOME = e.originalEvent.clientX
			values = ["#{@OFFSET}px", 0, 0].join ', '
			BU.EventBus.trigger 'offset-timeline-from-user-timeline', values
			e.preventDefault()

		stopDrag: (e) =>
			@body.off 'mousemove', @onDrag
			@body.off 'mouseup', @stopDrag
			DRAGGING = false
			@XHOME = 0
			e.preventDefault()