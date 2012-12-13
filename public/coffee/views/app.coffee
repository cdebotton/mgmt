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
	'models/task'
], (Backbone, _, $, namespace) ->
	
	namespace 'BU.EventBus'
	BU.EventBus = _.extend {}, Backbone.Events

	namespace 'BU.View.App'
	class BU.View.App extends Backbone.View

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
			_.extend {}, @sub_views,
				graphTimeline:	new BU.View.GraphTimeline
					model: @model
				profilePalette:	new BU.View.ProfilePalette
					model: @model
				taskTimeline:	new BU.View.TaskTimeline
					model: @model
				dateGuides: 	new BU.View.DateGuides
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
			@openModal new BU.Model.Task
			e.preventDefault()

		openModal: (task) ->
			@modal = new BU.View.EditModal
				model: task
			@$el.append @modal.render().$el