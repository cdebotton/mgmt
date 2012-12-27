define [
	'backbone'
	'ns'
	'views/projects/project-task'
], (Backbone, ns) ->

	ns 'United.Views.Projects.TaskEditor'
	class United.Views.Projects.TaskEditor extends Backbone.View
		el: '#project-editing-viewport'

		initialize: ->
			@addAll()

		addOne: (task) =>
			console.log task

		addAll: (tasks) ->
			if @model.get('project').get('tasks').length is 0
				@model.get('project').get('tasks').add()
			@model.get('project').get('tasks').each @addOne