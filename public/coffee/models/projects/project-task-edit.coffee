define [
	'backbone'
	'ns'
	'relational'
], (Backbone, ns) ->

	ns 'United.Models.Projects.ProjectTaskEdit'
	class United.Models.Projects.ProjectTaskEdit extends Backbone.RelationalModel

		relations: [{
			type:				Backbone.HasOne
			relatedModel:		United.Models.Tasks.Task
			key:				'task'
			reverseRelation:
				type:			Backbone.HasOne
				key:			'drawer'
				includeInJSON:	true
		}]

	United.Models.Projects.ProjectTaskEdit.setup()
