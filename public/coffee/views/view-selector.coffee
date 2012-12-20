define [
	'backbone'
	'ns'
], (Backbone, ns) ->

	class BU.Views.ViewSelector extends Backbone.View

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