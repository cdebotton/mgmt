define [
	'backbone'
	'underscore'
	'ns'
	'jst'
], (Backbone, _, ns) ->

	class United.Views.Tasks.UserCalendar extends Backbone.View

		tagName: 'article'

		className: 'user-calendar-item'

		months: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

		days: ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']

		initialize: ->
			United.JST.Hb.registerHelper 'printSchedule', @printSchedule

		render: ->
			ctx = @model.toJSON()
			ctx.events = @renderDates()
			html = United.JST.UserCalendar ctx
			@$el.html html
			@

		renderDates: ->
			yesterday = new Date()
			yesterday.setDate yesterday.getDate() - 1
			current = @model.get('tasks').filter (task) ->
				task.get('start_date') > yesterday or task.get('end_date') > yesterday
			dates = []
			_.each current, (task) ->
				dates.push task.get('start_date').getTime()
				dates.push task.get('end_date').getTime()
			dates.sort (a, b) -> a > b
			dates = _.unique dates, true
			dates[i] = new Date(date) for date, i in dates
			
			events = []
			for date in dates
				events.push {
					date: date
					tasks: _.filter current, (task) ->
						start = task.get('start_date').toString()
						end = task.get('end_date').toString()
						day = date.toString()
						start is day or end is day
				}
			events

		printSchedule: (array, opts) =>
			if array?.length > 0
				buffer = ''
				for ev in array
					item = {}
					date = new Date ev.date
					item.list = []
					month = @months[date.getMonth()]
					day = date.getDate()
					year = date.getFullYear()
					dayVal = date.getDay() - 1
					if dayVal < 0 then dayVal = 6
					dayVal = @days[dayVal]
					item.readableDate = "#{dayVal} #{month} #{day}, #{year}"
					if ev.tasks?.length
						for task in ev.tasks
							task_item = {}
							task_item.color = task.get 'color'
							if task.get('start_date').toString() is date.toString()
								task_item.title = "Begin #{task.get 'name'}, #{task.get 'client'}"
							else if task.get('end_date').toString() is date.toString()
								task_item.title = "Complete #{task.get 'name'}, #{task.get 'client'}"
							item.list.push task_item
					else delete ev.tasks
					buffer += opts.fn item
				return buffer