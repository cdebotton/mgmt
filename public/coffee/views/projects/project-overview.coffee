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
			@addAll()

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
			dy = 15
			siblings = _.without @tasks, task
			for comp, key in siblings
				start = task.get('start_date')
				end = task.get('end_date')
				compstart = comp.model.get('start_date')
				compend = comp.model.get('end_date')
				if start < compend and end > compstart and comp.options.dy is dy
					dy += 60
					if dy > @viewportHeight then @viewportHeight = dy
			el.css {
				left:	dx
				top:	dy
				width:	width
			}
			view.options.dy = dy
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
