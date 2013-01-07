define [
	'backbone'
	'ns'
	'jst'
], (Backbone, ns) ->

	ns 'United.Views.Projects.ProjectTaskEdit'
	class United.Views.Projects.ProjectTaskEdit extends Backbone.View

		el: '#project-task-holder'

		events:
			'click #save-task':					'saveTask'
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
			@render()

		render: () ->
			task = @model.get 'task'
			console.log task.get 'project'
			s = task.get 'start_date'
			e = task.get 'end_date'
			console.log task
			ctx = task.toJSON()
			ctx.start_month = s.getMonth()+1
			ctx.start_day = s.getDate()
			ctx.start_year = s.getFullYear()
			ctx.end_month = e.getMonth()+1
			ctx.end_day = e.getDate()
			ctx.end_year = e.getFullYear()
			ctx.users = window.users
			html = United.JST.ProjectTaskDrawer ctx
			@$el.html html
			h = @$el.innerHeight()
			@$el.css {
				height: 0
				opacity: 1
			}
			@$el.animate {
				height: h
			}, 175, 'ease-in'
			console.log @$el, html, ctx
			@

		updateTaskName: (e) =>
			@model.get('task').set 'name', e.currentTarget.value

		updateStartYear: (e) =>
			selected = @model.get 'task'
			start_date = selected.get 'start_date'
			target = parseInt(e.currentTarget.value)
			new_date = new Date target, start_date.getMonth(), start_date.getDate(), 0, 0, 0
			@model.get('task').set 'start_date', new_date
			@validateDates()

		updateStartMonth: (e) =>
			selected = @model.get 'task'
			start_date = selected.get 'start_date'
			target = parseInt(e.currentTarget.value) - 1
			new_date = new Date start_date.getFullYear(), target, start_date.getDate(), 0, 0, 0
			@model.get('task').set 'start_date', new_date
			@validateDates()

		updateStartDay: (e) =>
			selected = @model.get 'task'
			start_date = selected.get 'start_date'
			target = parseInt(e.currentTarget.value)
			new_date = new Date start_date.getFullYear(), start_date.getMonth(), target, 0, 0, 0
			@model.get('task').set 'start_date', new_date
			@validateDates()

		updateEndYear: (e) =>
			selected = @model.get 'task'
			end_date = selected.get 'end_date'
			target = parseInt(e.currentTarget.value)
			new_date = new Date target, end_date.getMonth(), end_date.getDate(), 0, 0, 0
			@model.get('task').set 'end_date', new_date
			@validateDates()

		updateEndMonth: (e) =>
			selected = @model.get 'task'
			end_date = selected.get 'end_date'
			target = parseInt(e.currentTarget.value) - 1
			new_date = new Date end_date.getFullYear(), target, end_date.getDate(), 0, 0, 0
			@model.get('task').set 'end_date', new_date
			@validateDates()

		updateEndDay: (e) =>
			selected = @model.get 'task'
			end_date = selected.get 'end_date'
			target = parseInt(e.currentTarget.value)
			new_date = new Date end_date.getFullYear(), end_date.getMonth(), target, 0, 0, 0
			@model.get('task').set 'end_date', new_date
			@validateDates()

		validateDates: ->
			s = @model.get('task').get 'start_date'
			e = @model.get('task').get 'end_date'
			#if s >= e
			#	target = new Date s.getTime()
			#	@model.get('task').set 'end_date', target.setDate target.getDate + 2
			#	alert @model.get('task').get('end_date')

		updateColor: (e) =>
			@model.get('task').set 'color', e.currentTarget.value

		updateUserId: (e) =>
			@model.get('task').set 'user_id', e.currentTarget.value

		updatePercentage: (e) =>
			@model.get('task').set 'percentage', parseInt e.currentTarget.value

		saveTask: (e) =>
			if @model.get('project').isNew()
				###
				@model.get('project').save null, {
					wait: true
					success: (project, attrs, status) =>
						project.set 'id', attrs.id
						console.log @model.toJSON()
				}
				###

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
