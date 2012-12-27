define [
	'backbone'
	'jquery'
	'underscore'
	'ns'
	'mousetrap'
	'views/tasks/profile-palette'
	'views/tasks/task-timeline'
	'views/tasks/graph-timeline'
	'views/tasks/date-guides'
	'views/tasks/edit-modal'
	'models/tasks/edit-modal'
	'models/tasks/task'
	'views/tasks/scale-controller'
	'models/tasks/scale-controller'
	'views/tasks/graph-filters'
	'models/tasks/graph-filters'
	'views/tasks/view-selector'
	'models/tasks/view-selector'
	'views/tasks/calendar'
], (Backbone, $, _, ns, Mousetrap) ->

	ns 'United.Views.Tasks.ScheduleManager'
	class United.Views.Tasks.ScheduleManager extends Backbone.View
		el: '#schedule-viewport'

		MODAL_OPEN = false

		events:
			'selectstart': 'disableSelection'
			'click #new-task-toggle': 'createNewTask'

		initialize: ->
			Mousetrap.bind ['ctrl+shift+n', 'ctrl+shift+alt+n'], => @openModal()
			BU.EventBus.on 'modal-closed', @modalClosed, @
			BU.EventBus.on 'open-modal', @openModal, @
			BU.EventBus.on 'set-view', @setView, @
			BU.Session = @model.get 'session'
			@window = $(window)
			@header = @$ '.navbar'
			@dy = @$el.offset().top
			@window.on 'scroll', @affix
			@window.on 'resize', @adjust
			@sub_views = _.extend {}, {
				graphFilters:		new United.Views.Tasks.GraphFilters
										model: new United.Models.Tasks.GraphFilters
				viewSelector:		new United.Views.Tasks.ViewSelector
										model: new United.Models.Tasks.ViewSelector
				scaleController:	new United.Views.Tasks.ScaleController
										model: new United.Models.Tasks.ScaleController
			}
			@task_views = _.extend {}, {
				graphTimeline:		new United.Views.Tasks.GraphTimeline
										model: @model
				profilePalette:		new United.Views.Tasks.ProfilePalette
										model: @model
				taskTimeline:		new United.Views.Tasks.TaskTimeline
										model: @model
				#dateGuides: 		new United.Views.Tasks.DateGuides	
			}
			@calendar_views = _.extend {}, {
				calendarView:		new United.Views.Tasks.CalendarView
										model: @model
			}
			@adjust()
			@sub_views.viewSelector.model.set 'currentView', 'task'

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

		openModal: (task = null) =>
			if MODAL_OPEN
				return false
			MODAL_OPEN = true
			if not BU.Session.isAdmin() then return false
			params = {}
			params['users'] = @model.get('users')
			if task isnt null then params['task'] = task
			@modal = new United.Views.Tasks.EditModal
				model: new United.Models.Tasks.EditModal params
			@$el.append @modal.render().$el
			return false

		modalClosed: -> MODAL_OPEN = false

		setView: (type) ->
			switch type
				when 'task'
					_.each @task_views, (view) ->
						view.startListening()
						view.$el.show()
					_.each @calendar_views, (view) ->
						view.stopListening()
						view.$el.hide()

				when 'calendar'
					_.each @task_views, (view) ->
						view.stopListening()
						view.$el.hide()
					_.each @calendar_views, (view) ->
						view.startListening()
						view.$el.show()
					@calendar_views.calendarView.addAll()