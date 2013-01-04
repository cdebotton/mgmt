define [
	'backbone'
	'ns'
	'relational'
	'models/projects/project'
	'models/tasks/task'
], (Backbone, ns) ->

	ns 'United.Models.Projects.EditDrawer'
	class United.Models.Projects.EditDrawer extends Backbone.RelationalModel
	
		relations: [{
			type:				Backbone.HasOne
			relatedModel:		United.Models.Projects.Project
			key:				'project'
			reverseRelation:
				type:			Backbone.HasOne
				key:			'drawer'
				includeInJSON:	false
		}, {
			type:				Backbone.HasOne
			relatedModel:		United.Models.Tasks.Task
			key:				'activeTask'
			reverseRelation:
				type:			Backbone.HasOne
				key:			'drawer'
				includeInJSON:	false
		}]

	United.Models.Projects.EditDrawer.setup()