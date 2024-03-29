define [
	'backbone'
	'ns'
	'dropdown'
], (Backbone, ns) ->

	ns 'United.Views.Tasks.GraphFilters'
	class United.Views.Tasks.GraphFilters extends Backbone.View
		el: '#filter-menu'

		events:
			'click [data-discipline]':		'filterDiscipline'
			'click [data-role]':			'filterRole'
			'click [data-reset-filter]':	'resetFilter'

		initialize: ->
			@model.on 'change', @alertFilterChange, @

		filterDiscipline: (e) ->
			btn = $ e.currentTarget
			@model.set { 
				'filterType': 	'disciplines' 
				'filter': 		btn.data 'discipline'
			}

		filterRole: (e) ->
			btn = $ e.currentTarget
			@model.set { 
				'filterType': 	'roles' 
				'filter': 		btn.data 'role'
			}

		resetFilter: (e) =>
			@model.set { 
				'filterType': 	null
				'filter': 		null
			}

		alertFilterChange: ->
			United.EventBus.trigger 'set-filter', @model.get('filterType'), @model.get('filter')