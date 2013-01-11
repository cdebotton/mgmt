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

		initialize: ->
			United.JST.Hb.registerHelper 'printUsers', @printUsers
			United.JST.Hb.registerHelper 'printColors', @printColors

		render: () ->
			@$el.css 'opacity', 0
			task = @model.get 'task'
			s = task.get 'start_date'
			e = task.get 'end_date'
			ctx = task.toJSON()
			if task.get('user')
				ctx.user_id = task.get('user').get('id')
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
			selected = @model.get 'task'
			start_date = selected.get 'start_date'
			target = parseInt(e.currentTarget.value)
			if target.toString().match /^\d{4}$/
				d = new Date start_date
				d.setYear target
				if d < selected.get 'end_date'
					@model.get('task').set 'start_date', d

		updateStartMonth: (e) =>
			selected = @model.get 'task'
			start_date = selected.get 'start_date'
			target = parseInt(e.currentTarget.value)
			if 0 < target < 13
				d = new Date start_date
				d.setMonth target - 1
				if d < selected.get 'end_date'
					@model.get('task').set 'start_date', d

		updateStartDay: (e) =>
			selected = @model.get 'task'
			start_date = selected.get 'start_date'
			target = parseInt(e.currentTarget.value)
			if 0 < target < 32
				d = new Date start_date
				d.setDate target
				if d < selected.get 'end_date'
					@model.get('task').set 'start_date', d

		updateEndYear: (e) =>
			selected = @model.get 'task'
			end_date = selected.get 'end_date'
			target = parseInt(e.currentTarget.value)
			if target.toString().match /^\d{4}$/
				d = new Date end_date
				d.setYear target
				if d > selected.get 'start_date'
					@model.get('task').set 'end_date', d

		updateEndMonth: (e) =>
			selected = @model.get 'task'
			end_date = selected.get 'end_date'
			target = parseInt(e.currentTarget.value)
			if 0 < target < 13
				d = new Date end_date
				d.setMonth target - 1
				if d > selected.get 'start_date'
					@model.get('task').set 'end_date', d

		updateEndDay: (e) =>
			selected = @model.get 'task'
			end_date = selected.get 'end_date'
			target = parseInt(e.currentTarget.value)
			if 0 < target < 32
				d = new Date end_date
				d.setDate target
				if d > selected.get 'start_date'
					@model.get('task').set 'end_date', d

		updateColor: (e) =>
			@model.get('task').set 'color', e.currentTarget.value

		updateUserId: (e) =>
			@model.get('task').set 'user_id', e.currentTarget.value

		updatePercentage: (e) =>
			@model.get('task').set 'percentage', parseInt e.currentTarget.value

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
