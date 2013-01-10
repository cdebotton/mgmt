define [
	'backbone'
	'underscore'
	'ns'
	'views/tasks/task-element'
], (Backbone, _, ns) ->

	ns 'United.Views.Projects.ProjectOverview'
	class United.Views.Projects.ProjectOverview extends Backbone.View
		tasks: []
		el: '#project-overview'
		viewportHeight: 20

		initialize: ->
			@model.get('project').get('tasks').on 'add', @addAll, @
			@model.get('project').get('tasks').on 'change', @addAll, @
			if @model.get('project').get('tasks').length > 0
				@model.get('project').get('tasks').each (task) -> task.set '_o-track', 0
				@generateTracks()
			@addAll()

		findConflicts: (task, sibling) ->
			adjacent = task['_o-track'] is sibling['_o-track']
			overlap = task.start_date < sibling.end_date and sibling.end_date > task.start_date
			adjacent and overlap

		generateTracks: ->
			tasks = @model.get('project').get('tasks').models
			for task, i in tasks
				if i is 0 then continue
				track = 0
				for j in [0..i-1]
					sibling = tasks[j]
					fakeAttrs = _.extend {}, task.attributes, { '_o-track': track }
					if @findConflicts fakeAttrs, sibling.attributes
						track++
				task.set '_o-track', track


		addAll: () =>
			@viewportHeight = 20
			@generateRange()
			_.each @tasks, (task, key) =>
				task.remove()
				delete @tasks[key]
			@tasks = []
			@$el.html ''
			@model.get('project').get('tasks').each @addOne
			@$el.css 'height', @viewportHeight+35

		addOne: (task, key) =>
			view = new United.Views.Tasks.TaskElement
					model:	task
					demo:	true
			el = view.render().$el
			el.addClass 'demo'
			s = view.model.get('start_date').getTime()
			e = view.model.get('end_date').getTime()
			dx = 10 + ((s - @start) * @scale)
			width = (e - s) * @scale
			dy = 15 + (task.get('_o-track') * 60)
			el.css {
				left:	dx
				top:	dy
				width:	width
			}
			@tasks.push view
			@$el.append el

		generateRange: ->
			tasks = @model.get('project').get('tasks')
			if tasks.length
				tasks.comparator = (task) -> task.get 'start_date'
				tasks.sort()
				start = tasks.first().get 'start_date'
				tasks.comparator = (task) -> task.get 'end_date'
				tasks.sort()
				end = tasks.last().get 'end_date'
				tasks.comparator = (task) -> task.get 'start_date'
				tasks.sort()
				@start = start.getTime()
				@end = end.getTime()
				diff = end - start
				@scale = 910 / diff
				@$el.css {
					height: tasks.length * 50 + ((tasks.length - 1) * 10)
				}
