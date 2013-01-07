define [
	'backbone'
	'ns'
	'views/tasks/task-element'
], (Backbone, ns) ->

	ns 'United.Views.Projects.ProjectOverview'
	class United.Views.Projects.ProjectOverview extends Backbone.View
		el: '#project-overview'

		initialize: ->
			#@model.get('project').get('tasks').on 'add', @updateTaskPreview, @
			@model.get('project').get('tasks').on 'add', @addOne, @
			@addAll()

		addAll: () =>
			@$el.html ''
			@model.get('project').get('tasks').each @addOne

		addOne: (task, key) =>
			@generateRange()
			view = new United.Views.Tasks.TaskElement
					model: task
					demo: true
			el = view.render().$el
			el.addClass 'demo'
			s = view.model.get('start_date').getTime()
			e = view.model.get('end_date').getTime()
			dx = 10 + (s - @start) * 910
			width = 10 + ((e - @start) / (@end - @start)) * 910
			el.css {
				left: dx
				width: width
			}
			@$el.append el

		generateRange: ->
			tasks = @model.get('project').get('tasks')
			if tasks.length
				start = tasks.first().get 'start_date'
				tasks.comparator = (task) -> task.get 'end_date'
				end = tasks.last().get 'end_date'
				@start = start.getTime()
				@end = end.getTime()
				@$el.css {
					height: tasks.length * 50 + ((tasks.length - 1) * 10)
				}
