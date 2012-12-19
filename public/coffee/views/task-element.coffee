define [
	'backbone'
	'ns'
	'jst'
], (Backbone, namespace) ->

	namespace 'BU.Views.TaskElement'
	class BU.Views.TaskElement extends Backbone.View

		DAY_TO_MILLISECONDS = 86400000

		PX_PER_DAY = 41

		tagName: 'div'

		className: 'task-element'

		events:
			'mousedown .grip':	'scrubStart'
			'mousedown':		'scrubStart'
			'click .icon-edit':	'editModal'

		initialize: ->
			@body = $ 'body'
			if BU.Session.isAdmin()
				BU.EventBus.on 'start-drag', @setOpacity, @
				BU.EventBus.on 'stop-drag', @unsetOpacity, @
				@body.on 'mousemove', @scrubMove
				@body.on 'mouseup', @scrubStop
				@model.on 'change:end_date', @updatePositions, @
				@model.on 'change:start_date', @updatePositions, @
				@model.on 'change:track', @updatePositions, @
				@model.on 'change:color', @updateColor, @
				@model.on 'change:name change:client change:project_code', @render, @
				@model.on 'change:percentage', @render, @
			else @$el.addClass 'no-drag'

			BU.EventBus.on 'zoom-grid-updated', @updateZoom, @
			BU.EventBus.on 'offset-timeline', @offsetTimeline, @
			BU.JST.Hb.registerHelper 'formatDate', @formatDate	
			@start = @model.get 'start_date'
			@end = @model.get 'end_date'
			
			if @model.get('color') isnt null then @$el.addClass @model.get 'color'
			BU.EventBus.on 'gridpoint-dispatch', @gridPointsReceived, @

		render: ->
			BU.EventBus.trigger 'where-am-i', @cid, @start, @end
			BU.EventBus.trigger 'percentage-changed'
			ctx = @model.toJSON()
			ctx.isAdmin = BU.Session.isAdmin()
			html = BU.JST['TaskElement'] ctx
			@$el.html html
			@

		updatePositions: (model) ->
			@start = @model.get 'start_date'
			@end = @model.get 'end_date'
			BU.EventBus.trigger 'where-am-i', @cid, @start, @end
			@render()

		gridPointsReceived: (cid, p1, p2, offset) ->
			if cid isnt @cid then return false
			dx = p1
			width = p2 - p1
			@$el.css
				marginLeft: dx
				width: width
				marginTop: 10 +@model.get('track') * 60
				'-webkit-transform':	"translate3d(#{offset}px, 0, 0)"
				
		scrubStart: (e) =>
			if not BU.Session.isAdmin() then return false
			if e.which isnt 1 then return false
			BU.EventBus.trigger 'start-drag', @model.get 'id'
			@dragging = true
			obj = $ e.currentTarget
			@property = switch 1 is 1
				when obj.hasClass 'left' then ['start_date']
				when obj.hasClass 'right' then ['end_date']
				else ['start_date', 'end_date']
			@initX = e.pageX
			e.stopImmediatePropagation()
			e.preventDefault()

		scrubMove: (e) =>
			if not BU.Session.isAdmin() then return false
			if not @dragging then return false
			updateObject = {
				start_date: @model.get 'start_date'
				end_date:	@model.get 'end_date'
				track:		@model.get 'track'
			}
			if @property.length > 1
				targetTrack = Math.floor (e.pageY - @$el.parent().offset().top) / 48
				if targetTrack isnt updateObject.track then updateObject.track = targetTrack
			dx = e.pageX - @initX
			if Math.abs(dx) > PX_PER_DAY
				units = Math.round dx / PX_PER_DAY
				days = DAY_TO_MILLISECONDS * units
				@initX = e.pageX
				for property, key in @property
					date = @model.get property
					epoch = date.getTime()
					epoch += days
					date = new Date epoch
					if updateObject[property] isnt date then updateObject[property] = date
			@model.set updateObject
			left = @$el.offset().left
			right = left + @$el.outerWidth()
			BU.EventBus.trigger 'update-timeline-transform', e.pageX, left, right, dx

		scrubStop: (e) =>
			if not BU.Session.isAdmin() then return false
			if @dragging
				BU.EventBus.trigger 'stop-drag', @model.get 'id'
				@dragging = false
				@property = undefined
				@initX = 0
				@model.save()

		setOpacity: (id) ->
			if id isnt @model.get 'id'
				@$el.css 'opacity', 0.35

		unsetOpacity: (id) ->
			if id isnt @model.get 'id'
				@$el.css 'opacity', 1

		formatDate: (date) ->
			months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
			new Handlebars.SafeString "#{months[date.getMonth()]}. #{date.getDate()}, #{date.getFullYear()}"


		offsetTimeline: (dx) ->
			@$el.css
				'-webkit-transform':	"translate3d(#{dx})"

		editModal: (e) =>
			if not BU.Session.isAdmin() then return false
			BU.EventBus.trigger 'open-modal', @model
			e.preventDefault()

		updateColor: =>
			if not BU.Session.isAdmin() then return false
			@$el[0].className = "task-element #{@model.get 'color'}"

		updateZoom: (zoom) ->
			BU.EventBus.trigger 'where-am-i', @cid, @model.get('start_date'), @model.get 'end_date'
			BU.EventBus.trigger 'percentage-changed'