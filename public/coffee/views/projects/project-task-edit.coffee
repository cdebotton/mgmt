define [
	'backbone'
	'ns'
	'jst'
], (Backbone, ns) ->

	ns 'United.Views.Projects.ProjectTaskEdit'
	class United.Views.Projects.ProjectTaskEdit extends Backbone.View
		events:
			'click #task-done':					'animateOut'
			'keyup input[name="task-name"]':	'updateTaskName'
			'keyup input[name="start_year"]':	'updateStartYear'
			'keyup input[name="start_month"]':	'updateStartMonth'
			'keyup input[name="start_day"]':	'updateStartDay'
			'keyup input[name="end_year"]':		'updateEndYear'
			'keyup input[name="end_month"]':	'updateEndMonth'
			'keyup input[name="end_day"]':		'updateEndDay'
			'keyup input[name="percentage"]':	'updatePercentage'
			'change select[name="color"]':		'updateColor'
			'change select[name="user_id"]':	'updateUserId'

		keyPressTimer: null

		keyPressTimeout: 50

		initialize: ->
			United.JST.Hb.registerHelper 'printUsers', @printUsers
			United.JST.Hb.registerHelper 'printColors', @printColors

		render: () ->
			@$el.css 'opacity', 0
			task = @model.get 'task'
			s = task.get 'start_date'
			e = task.get 'end_date'
			ctx = task.toJSON()
			ctx.start_month = s.getMonth()+1
			ctx.start_day = s.getDate()
			ctx.start_year = s.getFullYear()
			ctx.end_month = e.getMonth()+1
			ctx.end_day = e.getDate()
			ctx.end_year = e.getFullYear()
			ctx.users = window.users
			html = United.JST.ProjectTaskDrawer ctx
			@$el.css 'height', 'auto'
			@$el.html html
			h = @$el.innerHeight()
			@$el.css {
				height:		0
				opacity:	1
			}
			@$el.animate {
				height:		h
			}, 175, 'ease-in'
			@

		animateOut: =>
			@$el.animate {
				height:		0
			}, 175, 'ease-out', =>
				United.EventBus.trigger 'close-project-task-drawer'
				@remove()

		updateTaskName: (e) =>
			@model.get('task').set 'name', e.currentTarget.value

		updateStartYear: (e) =>
			clearTimeout @keyPressTimer
			@keyPressTimer = setTimeout () =>
				selected = @model.get 'task'
				start_date = selected.get 'start_date'
				target = parseInt(e.currentTarget.value)
				new_date = new Date target, start_date.getMonth(), start_date.getDate(), 0, 0, 0
				if new_date > @model.get 'end_date'
					return
				@model.get('task').set 'start_date', new_date
			, @keyPressTimeout

		updateStartMonth: (e) =>
			clearTimeout @keyPressTimer
			@keyPressTimer = setTimeout () =>
				selected = @model.get 'task'
				start_date = selected.get 'start_date'
				target = parseInt(e.currentTarget.value)
				if target > 12 then target = 12
				else if target < 1 then target = 1
				new_date = new Date start_date.getFullYear(), target - 1, start_date.getDate(), 0, 0, 0
				if new_date > @model.get 'end_date'
					return
				@model.get('task').set 'start_date', new_date
			, @keyPressTimeout

		updateStartDay: (e) =>
			clearTimeout @keyPressTimer
			@keyPressTimer = setTimeout () =>
				selected = @model.get 'task'
				start_date = selected.get 'start_date'
				target = parseInt(e.currentTarget.value)
				if target > 31 then target = 31
				else if target < 1 then target = 1
				new_date = new Date start_date.getFullYear(), start_date.getMonth(), target, 0, 0, 0
				if new_date > @model.get 'end_date'
					return
				@model.get('task').set 'start_date', new_date
			, @keyPressTimeout

		updateEndYear: (e) =>
			clearTimeout @keyPressTimer
			@keyPressTimer = setTimeout () =>
				selected = @model.get 'task'
				end_date = selected.get 'end_date'
				target = parseInt(e.currentTarget.value)
				new_date = new Date target, end_date.getMonth(), end_date.getDate(), 0, 0, 0
				if new_date < @model.get 'start_date'
					return
				@model.get('task').set 'end_date', new_date
			, @keyPressTimeout

		updateEndMonth: (e) =>
			clearTimeout @keyPressTimer
			@keyPressTimer = setTimeout () =>
				selected = @model.get 'task'
				end_date = selected.get 'end_date'
				target = parseInt(e.currentTarget.value)
				if target > 12 then target = 12
				else if target < 1 then target = 1
				new_date = new Date end_date.getFullYear(), target - 1, end_date.getDate(), 0, 0, 0
				if new_date < @model.get 'start_date'
					return
				@model.get('task').set 'end_date', new_date
			, @keyPressTimeout

		updateEndDay: (e) =>
			clearTimeout @keyPressTimer
			@keyPressTimer = setTimeout () =>
				selected = @model.get 'task'
				end_date = selected.get 'end_date'
				target = parseInt(e.currentTarget.value)
				if target > 31 then target = 31
				else if target < 1 then target = 1
				new_date = new Date end_date.getFullYear(), end_date.getMonth(), target, 0, 0, 0
				if new_date < @model.get 'start_date'
					return
				@model.get('task').set 'end_date', new_date
			, @keyPressTimeout

		updateColor: (e) =>
			@model.get('task').set 'color', e.currentTarget.value

		updateUserId: (e) =>
			@model.get('task').set 'user_id', e.currentTarget.value

		updatePercentage: (e) =>
			@model.get('task').set 'percentage', parseInt e.currentTarget.value

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
