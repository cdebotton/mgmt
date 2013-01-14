define [
	'backbone'
	'underscore'
	'ns'
	'animate'
	'jst'
], (Backbone, _, ns) ->

	ns 'United.Views.Dashboard.PdoRequest'
	class United.Views.Dashboard.PdoRequest extends Backbone.View
		PDO_TYPES = {
			'Please select a type':			'null'
			'Vacation':						'vacation'
			'Voting':						'voting'
			'Jury Duty':					'jury duty'
			'Maternity Leave':				'maternity leave'
			'Funeral Leave':				'funeral leave'
			'Other':						'other'
		}
		el: '#pdo-request'

		events:
			'click #make-request':			'makeRequest'
			'click .icon-remove':			'cancelRequest'
			'click #cancel-request':		'cancelRequest'
			'keyup [name="start_month"]':	'setStartMonth'
			'keyup [name="start_day"]':		'setStartDay'
			'keyup [name="start_year"]':	'setStartYear'
			'keyup [name="end_month"]':		'setEndMonth'
			'keyup [name="end_day"]':		'setEndDay'
			'keyup [name="end_year"]':		'setEndYear'
			'keyup [name="message"]':		'setMessage'
			'change [name="pdo-type"]':		'setType'

		initialize: ->
			United.JST.Hb.registerHelper 'printTypes', @printTypes
			@model.on 'destroy', @destroyed, @
			@render()

		render: ->
			ctx = @model.toJSON()
			html = United.JST.PdoRequest ctx
			@$el.html html
			if @options.open is false
				@$el.css {
					opacity: 0
					display: 'block'
				}
				h = @$el.outerHeight()
				@$el.css {
					marginTop: -(h + 10)
					opacity: 1
				}
				@$el.animate {
					marginTop: 0
				}, 175, 'ease-out'

		makeRequest: (e) ->
			e.preventDefault()
			@model.save {}, {
				wait: true
				success: _.bind @destroyed, @
			}

		cancelRequest: (e) =>
			e.preventDefault()
			@model.destroy()

		destroyed: (model) ->
			United.EventBus.trigger 'request-closed'
			h = @$el.innerHeight()
			@$el.animate {
				marginTop: -(h+10)
			}, 175, 'ease-int', () =>
				@$el.html ''
				@undelegateEvents()

		setStartYear: (e) =>
			if e.currentTarget.value.match /^\d{4}$/
				date = new Date @model.get 'start_date'
				date.setYear parseInt e.currentTarget.value, 10
				if date < @model.get 'end_date'
					@model.set 'start_date', date

		setStartMonth: (e) =>
			target = (parseInt e.currentTarget.value, 10) - 1
			if 0 <= target <= 12
				date = new Date @model.get 'start_date'
				date.setMonth target
				if date < @model.get 'end_date'
					@model.set 'start_date', date

		setStartDay: (e) =>
			target = parseInt e.currentTarget.value, 10
			if 0 < target < 32
				date = new Date @model.get 'start_date'
				date.setDate target
				if date < @model.get 'end_date'
					@model.set 'start_date', date

		setEndYear: (e) =>
			if e.currentTarget.value.match /^\d{4}$/
				date = new Date @model.get 'end_date'
				date.setYear parseInt e.currentTarget.value, 10
				if date > @model.get 'start_date'
					@model.set 'end_date', date

		setEndMonth: (e) =>
			target = (parseInt e.currentTarget.value, 10) - 1
			if 0 <= target <= 12
				date = new Date @model.get 'end_date'
				date.setMonth target
				if date > @model.get 'start_date'
					@model.set 'end_date', date

		setEndDay: (e) =>
			target = parseInt e.currentTarget.value, 10
			if 0 < target < 32
				date = new Date @model.get 'end_date'
				date.setDate target
				if date > @model.get 'start_date'
					@model.set 'end_date', date

		setType: (e) =>
			@model.set 'type', e.currentTarget.value

		setMessage: (e) =>
			@model.set 'message', e.currentTarget.value

		printTypes: (selected, opts) ->
			buffer = ''
			for key, value of PDO_TYPES
				item = {
					key: key
					value: value
					selected: if value is selected then ' SELECTED' else ''
				}
				buffer += opts.fn item
			buffer
