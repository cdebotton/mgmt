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
			if @model.get('project').get('tasks').length > 0 then @generateTracks()
			@addAll()

		findConflicts: (task, previousTask) ->
			task.start_date < previousTask.end_date and
				previousTask.end_date > task.start_date

		generateTracks: ->
			tasks = @model.get('project').get('tasks').models
			task.set('_o-track', 0) for task, i in tasks
			for task, i in tasks[0..tasks.length]
				if i is 0 then continue
				track = task.get '_o-track'
				conflicts = true
				console.log task.get 'name'
				for previous, j in tasks[0..i-1]
					if (@findConflicts task.attributes, previous.attributes) is true
						track++
				task.set '_o-track', track

			#console.log "#{task.get 'name'}: #{task.get '_o-track'}" for task, i in tasks

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
			siblings = _.without @tasks, task
			###
			for comp, key in siblings
				start = task.get('start_date')
				end = task.get('end_date')
				compstart = comp.model.get('start_date')
				compend = comp.model.get('end_date')
				if start < compend and end > compstart and comp.options.dy is dy
					dy += 60
					if dy > @viewportHeight then @viewportHeight = dy
			###
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
