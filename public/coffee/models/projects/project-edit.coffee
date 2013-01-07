define [
	'backbone'
	'ns'
	'relational'
	'models/projects/project'
	'models/tasks/task'
], (Backbone, ns) ->

	ns 'United.Models.Projects.ProjectEdit'
	class United.Models.Projects.ProjectEdit extends Backbone.RelationalModel
		###
		relations: [{
			type:				Backbone.HasOne
			relatedModel:		United.Models.Projects.Project
			key:				'project'
			reverseRelation:
				type:			Backbone.HasOne
				key:			'drawer'
				includeInJSON:	false
		}]
		###
	United.Models.Projects.ProjectEdit.setup()
