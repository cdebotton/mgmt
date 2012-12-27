define [
	'backbone'
	'ns'
], (Backbone, ns) ->

	ns 'United.Views.Projects.ProjectTask'
	class United.Views.Projects.ProjectTask extends Backbone.View
		
		tagName: 'div'

		className: 'task-element'