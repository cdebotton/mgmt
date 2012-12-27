define [
	'backbone'
	'ns'
	'views/projects/project-task'
], (Backbone, ns) ->

	ns 'United.Views.Projects.TaskEditor'
	class United.Views.Projects.TaskEditor extends Backbone.View
		el: '#project-editing-viewport'

		initialize: ->
