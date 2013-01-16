define [
	'backbone'
	'underscore'
	'jquery'
	'ns'
	'jst'
	'views/tasks/task-element'
	'views/pdos/pdo-element'
	'views/tasks/overage'
], (Backbone, _, $, ns) ->

	ns 'United.Views.Tasks.UserTimeline'
	class United.Views.Tasks.UserTimeline extends Backbone.View

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
			if United.Models.Users.Session.isAdmin()
				United.EventBus.on 'percentage-points-calculated', @drawRanges, @
				United.EventBus.on 'percentage-changed', @calculateOverages, @
				@model.get('tasks').on 'change:start_date change:end_date change:user change:percentage', @calculateOverages, @
				United.EventBus.on 'zoom-grid-updated', @calculateOverages, @

			document.addEventListener 'mouseout', @mouseout, false
			United.EventBus.on 'task-added', @taskCreated, @
			@model.on 'add:tasks', @addOne, @
			@model.on 'reset:tasks remove:tasks', @addAll, @
			@model.get('tasks').on 'change:track', @adjustHeight, @

		stopListening: ->
			if United.Models.Users.Session.isAdmin()
				United.EventBus.off 'percentage-points-calculated', @drawRanges, @
				United.EventBus.off 'zoom-grid-updated', @calculateOverages, @
				United.EventBus.off 'percentage-changed', @calculateOverages, @
				@model.get('tasks').off 'change:start_date change:end_date change:user change:percentage', @calculateOverages, @

			document.removeEventListener 'mouseout', @mouseout, false
			United.EventBus.off 'task-added', @taskCreated, @
			@model.off 'add:tasks', @addOne, @
			@model.off 'reset:tasks remove:tasks', @addAll, @
			@model.get('tasks').off 'change:track', @adjustHeight, @

		mouseout: (e) =>
			if DRAGGING
				from = e.relatedTarget or e.toElement
				if not from or from.nodeName is 'HTML'
					return @stopDrag e

		render: ->
			ctx = @model.toJSON()
			html = United.JST['UserTimeline'] ctx
			@$el.html html
			@addAll()
			@adjustHeight()
			if United.Models.Users.Session.isAdmin()
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
			United.EventBus.trigger 'plot-ranges', ranges, @cid

		drawRanges: (response, caller) ->
			if caller isnt @cid then return
			_.each @overages, (range) -> range.clear()
			@overages = []
			for range in response
				view = new United.Views.Tasks.Overage
					model: new Backbone.Model range
				html = view.render().$el
				@overages.push view
				@$el.append html

		taskCreated: (task, userId) ->
			if userId is @model.get 'id'
				@addOne task

		addOne: (object) =>
			view = new United.Views.Tasks.TaskElement
				model: object
			html = view.render().$el
			@$el.append html

		addAll: ->
			@$el.html ''
			@model.get('tasks').each @addOne
			@model.get('pdos').each @drawPdo

		drawPdo: (pdo) =>
			view = new United.Views.Pdos.PdoElement
				model: pdo
			html = view.render().$el
			@$el.append html

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
			United.EventBus.trigger 'offset-timeline-from-user-timeline', values
			e.preventDefault()

		stopDrag: (e) =>
			@body.off 'mousemove', @onDrag
			@body.off 'mouseup', @stopDrag
			DRAGGING = false
			@XHOME = 0
			e.preventDefault()
