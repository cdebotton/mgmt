define [
	'backbone'
	'underscore'
	'ns'
	'jquery'
	'jst'
	'animate'
	'models/clients/client'
	'views/widgets/livesearch-input'
	'models/widgets/livesearch'
	'relational'
], (Backbone, _, ns, $) ->

	ns 'United.Views.Tasks.EditTask'
	class United.Views.Tasks.EditTask extends Backbone.View
		tagName:	'section'

		className:	'striped-cheech'

		events:
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
			ctx.user_list = window.users
			html = United.JST.EditModal ctx
			@$el.html html
			@$user 			= @$ '[name="developer_id"]'
			@expose()
			@

		setup: ->
			@liveSearch = new United.Views.Widgets.LiveSearchInput
				el: '#task-search'
				model: new United.Models.Widgets.LiveSearch
					queryUri: '/api/v1/schedules/unassigned'
			@liveSearch.model.on 'change:result', @updateTask, @

		updateTask: (search) ->
			result = search.get('result')
			task = new United.Models.Tasks.Task
			ctx = task.parse result.attributes
			task.set ctx
			@$client.val task.get('project').get('client').get('name')

		expose: () ->
			@body.bind 'keyup', @bindEscape
			@$el.css('opacity', 0).animate {
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
			@$('.edit-modal').animate {
				marginTop: -($(window).height()+250)
			}, => @$el.animate { opacity: 0 }, => @$el.remove()
			@body.unbind 'keyup', @bindEscape
			United.EventBus.trigger 'modal-closed'
			e.preventDefault()

		bindEscape: (e) => if e.keyCode is 27 then @closeModal e

		saveTask: (e) =>
			attrs = {
				'author_id':		window.author_id
				'name':				@$name.val()
				'client':			@$client.val()
				'start_date':		new Date @$start_year.val(), parseInt(@$start_month.val()) - 1, @$start_day.val()
				'end_date':			new Date @$end_year.val(), parseInt(@$end_month.val()) - 1, @$end_day.val()
				'color':			@$color.val()
				'track':			0
				'percentage':		@$percentage.val()
				'user':				{ 'id': parseInt @$user.val() }
			}

			if @model.has 'task'
				for attr, key of attrs
					@model.get('task').set attr, key
				@model.get('task').save()
			else
				task = new United.Models.Tasks.Task attrs
				task.save null, { wait: true }

			@closeModal e

		printUsers: (array, opts) =>
			if array?.length
				buffer = ''
				for user, key in array
					item = {
						id: user.id
						email: user.email
						selected: if @model.get('task')?.has('user') and +user.id is +@model.get('task').get('user').get('id') then ' SELECTED' else ''
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
