define [
	'backbone'
	'underscore'
	'ns'
	'jquery'
	'jst'
	'animate'
	'views/widgets/livesearch-input'
	'models/widgets/livesearch'
	'relational'
], (Backbone, _, ns, $) ->

	ns 'United.Views.Tasks.EditTask'
	class United.Views.Tasks.EditTask extends Backbone.View
		EXPOSED = false
		tagName:	'section'

		className:	'striped-cheech'

		events:
			'change [name="name"]':			'setName'
			'change [name="developer_id"]':	'setUser'
			'change [name="start_year"]':	'setStartYear'
			'change [name="start_month"]':	'setStartMonth'
			'change [name="start_day"]':	'setStartDay'
			'change [name="end_year"]':		'setEndYear'
			'change [name="end_month"]':	'setEndMonth'
			'change [name="end_day"]':		'setEndDay'
			'change [name="percentage"]':	'setPercentage'
			'change [name="color"]':		'setColor'
			'click .icon-remove':			'closeModal'
			'click button[type="submit"]':	'saveTask'

		initialize: ->
			United.JST.Hb.registerHelper 'printUsers', @printUsers
			United.JST.Hb.registerHelper 'printColors', @printColors
			United.JST.Hb.registerHelper 'printMonth', @printMonth
			United.JST.Hb.registerHelper 'printDay', @printDay
			United.JST.Hb.registerHelper 'printYear', @printYear
			@model.on 'change:client change:start_date change:end_date', @render, @

		render: ->
			@body = $ 'body'
			ctx = @model.toJSON()
			if (@model.get('project'))
				ctx.project = @model.get('project').toJSON()
				if (@model.get('project').get('client'))
					ctx.project.client = @model.get('project').get('client').toJSON()
			ctx.user_list = window.users
			html = United.JST.EditModal ctx
			@$el.html html
			@

		setup: ->
			@liveSearch = new United.Views.Widgets.LiveSearchInput
				el: '#task-search'
				model: new United.Models.Widgets.LiveSearch
					queryUri: '/api/v1/schedules/unassigned'
			if @model.get('project')
				@liveSearch.populate @model.get('project')
			@liveSearch.model.on 'change:result', @updateTask, @

		updateTask: (search) ->
			result = search.get('result')
			ctx = @model.parse result.attributes
			@model.set ctx
			@$('.edit-modal').css 'opacity', 1

		expose: () ->
			EXPOSED = true
			@body.bind 'keyup', @bindEscape
			@$el.animate {
				opacity: 1
			}, 150, 'ease-in', @dropModal

		dropModal: =>
			@setup()
			@$('.edit-modal').delay(150).css({
				top: '50%'
				opacity: 1
				marginTop: -($(window).height()+250)
			}).animate {
				marginTop: -250
			}

		closeModal: (e) =>
			if not EXPOSED then return
			EXPOSED = false
			@$('.edit-modal').animate {
				marginTop: -($(window).height()+250)
			}, => @$el.animate { opacity: 0 }, => @$el.remove()
			@body.unbind 'keyup', @bindEscape
			United.EventBus.trigger 'modal-closed'
			e.preventDefault()

		setName: (e) =>
			@model.set 'name', e.currentTarget.value

		setUser: (e) =>
			@model.set 'user', e.currentTarget.value

		setStartYear: (e) =>
			d = @model.get 'start_date'
			t = new Date e.currentTarget.value, d.getMonth(), d.getDate(), 0, 0, 0 ,0
			@model.set 'start_date', t

		setStartMonth: (e) =>
			d = @model.get 'start_date'
			t = new Date d.getFullYear(), parseInt(e.currentTarget.value) - 1, d.getDate(), 0, 0, 0, 0
			@model.set 'start_date', t

		setStartDay: (e) =>
			d = @model.get 'start_date'
			t = new Date d.getFullYear(), d.getMonth(), e.currentTarget.value, 0, 0, 0, 0
			@model.set 'start_date', t

		setEndYear: (e) =>
			@model.set 'end_date', @model.get('end_date').setFullYear e.currentTarget.value

		setEndMonth: (e) =>
			@model.set 'end_date', @model.get('end_date').setMonth (parseInt(e.currentTarget.value) - 1)

		setEndDay: (e) =>
			@model.set 'end_date', @model.get('end_date').setDate e.currentTarget.value

		setPercentage: (e) =>
			@model.set 'percentage', e.currentTarget.value

		setColor: (e) =>
			@model.set 'color', e.currentTarget.value

		bindEscape: (e) => if e.keyCode is 27 then @closeModal e

		saveTask: (e) =>
			@model.save null, {
				wait: true
				success: => @closeModal e
			}
			@closeModal e

		printUsers: (array, user_id, opts) =>
			if array?.length
				buffer = ''
				for user, key in array
					item = {
						id: user.id
						email: user.email
						selected: if user_id and +user.id is +user_id then ' SELECTED' else ''
					}
					buffer += opts.fn item
				return buffer
			else return opts.elseFn

		printColors: (opts) =>
			colors = { blue: 'Blue', red: 'Red', green: 'Green', yellow: 'Yellow' }
			buffer = ''
			for id, color of colors
				buffer += opts.fn {
					id: id
					color: color
					selected: if @model.get('task')?.get('color') is id then ' SELECTED' else ''
				}
			return buffer

		printMonth: (date) -> date.getMonth() + 1

		printDay: (date) -> date.getDate()

		printYear: (date) -> date.getFullYear()
