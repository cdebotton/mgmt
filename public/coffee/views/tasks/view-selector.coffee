define [
	'backbone'
	'ns'
], (Backbone, ns) ->

	ns 'United.Views.Tasks.ViewSelector'
	class United.Views.Tasks.ViewSelector extends Backbone.View

		el: '#view-selector'

		events:
			'click a': 	'setView'

		initialize: ->
			@model.on 'change:currentView', @setActive, @

		setView: (e) =>
			btn = $ e.currentTarget
			if (type = btn.data('view'))
				@model.set 'currentView', type
			e.preventDefault()

		setActive: (model, type) ->
			current = @$ "[data-view=\"#{type}\"]"
			current.parent().addClass('active').siblings('li').removeClass('active')