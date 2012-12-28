define [
	'backbone'
	'ns'
	'views/tasks/task-element'
], (Backbone, ns) ->
	ns 'United.Views.Projects.TaskEditor'
	class United.Views.Projects.TaskEditor extends Backbone.View
		el: '#project-editing-viewport'

		tasks: []

		initialize: ->
			@model.get('project').on 'change:name', @render, @
			@model.get('project').get('tasks').on 'change:start_date change:end_date change:name', @render, @
			@render()

		render: ->
			for task in @tasks
				task.remove()
			first = @model.get('project').get('tasks').first()
			last = @model.get('project').get('tasks').last()
			start = first.get('start_date').getTime()
			end = last.get('end_date').getTime()
			duration = end - start

			@model.get('project').get('tasks').each (task) =>
				view = new United.Views.Tasks.TaskElement
					model: task
					demo: true
				@tasks.push view
				el = view.render().$el

				@$el.append el