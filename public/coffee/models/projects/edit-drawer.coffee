define [
	'backbone'
	'ns'
	'relational'
	'models/projects/project'
], (Backbone, ns) ->

	ns 'United.Models.Projects.EditDrawer'
	class United.Models.Projects.EditDrawer extends Backbone.RelationalModel
	
		relations: [{
			type:				Backbone.HasOne
			relatedModel:		United.Models.Projects.Project
			key:				'project'
			reverseRelation:
				type:			Backbone.HasOne
				key:			'modal'
				includeInJSON:	false
		}]

	United.Models.Projects.EditDrawer.setup()