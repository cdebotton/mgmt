define [
	'backbone'
	'underscore'
	'jquery'
	'ns'
	'views/create-palette'
	'views/profile-palette'
	'views/task-timeline'
	'views/graph-timeline'
	'views/date-guides'
	'views/edit-modal'
	'models/edit-modal'
	'models/task'
	'views/scale-controller'
	'models/scale-controller'
	'views/graph-filters'
	'models/graph-filters'
	'views/view-selector'
	'models/view-selector'
	'views/calendar'
], (Backbone, _, $, namespace) ->
	
	namespace 'BU.EventBus'
	BU.EventBus = _.extend {}, Backbone.Events

	namespace 'BU.Views.App'
	class BU.Views.App extends Backbone.View

		el: '#schedule-viewport'

		events:
			'selectstart': 'disableSelection'
			'click #new-task-toggle': 'createNewTask'

		initialize: ->
			BU.EventBus.on 'open-modal', @openModal, @
			@window = $(window)
			@header = @$ '.navbar'
			@dy = @$el.offset().top
			@window.on 'scroll', @affix
			@window.on 'resize', @adjust
			@sub_views = _.extend {}, {
				graphTimeline:		new BU.Views.GraphTimeline
										model: @model
				profilePalette:		new BU.Views.ProfilePalette
										model: @model
				taskTimeline:		new BU.Views.TaskTimeline
										model: @model
				dateGuides: 		new BU.Views.DateGuides
				scaleController:	new BU.Views.ScaleController
										model: new BU.Models.ScaleController
				graphFilters:		new BU.Views.GraphFilters
										model: new BU.Models.GraphFilters
				viewSelector:		new BU.Views.ViewSelector
										model: new BU.Models.ViewSelector
				calendarView:		new BU.Views.CalendarView
										model: @model
			}
			@adjust()

		disableSelection: (e) -> e.preventDefault()

		affix: (e) =>
			scrollTop = @window.scrollTop()
			BU.EventBus.trigger 'on-scroll', scrollTop
			if scrollTop > @dy
				@header.addClass 'affix'
				BU.EventBus.trigger 'nav-affix', true
			else
				@header.removeClass 'affix'
				BU.EventBus.trigger 'nav-affix', false

		adjust: (e) =>
			w = @window.width()
			h = @window.height()
			BU.EventBus.trigger 'adjust', w, h

		createNewTask: (e) =>
			@openModal()
			e.preventDefault()

		openModal: (task = null) ->
			params = {}
			params['users'] = @model.get('users')
			if task isnt null then params['task'] = task
			@modal = new BU.Views.EditModal
				model: new BU.Models.EditModal params
			@$el.append @modal.render().$el