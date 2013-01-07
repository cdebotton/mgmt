define [
	'backbone'
	'ns'
	'relational'
	'models/projects/project'
], (Backbone, ns) ->

	ns 'United.Models.Projects.ProjectOverview'

	class United.Models.Projects.ProjectOverview extends Backbone.RelationalModel
		###
		relations: [{
			type:					Backbone.HasOne
			key:					'project'
			relatedModel:			United.Models.Projects.Project
			reverseRelation:
				key:				'overview'
				includeInJSON:		false
		}]
		###
	United.Models.Projects.ProjectOverview.setup()
