define [
	'backbone'
	'ns'
], (Backbone, ns) ->

	ns 'United.Views.Projects.ProjectOverview'
	class United.Views.Projects.ProjectOverview extends Backbone.View
		el: '#project-overview'

		initialize: ->
			@model.get('project').get('tasks').on 'add', @updateTaskPreview, @
			@model.get('project').get('tasks').on 'add', @selectNewTask, @

		addAll: (tasks) =>

		addOne: (task) =>
