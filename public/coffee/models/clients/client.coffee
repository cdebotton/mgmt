define [
	'backbone'
	'ns'
	'relational'
	'models/projects/project'
	'collections/projects/projects'
], (Backbone, ns) ->

	ns 'United.Models.Clients.Client'
	class United.Models.Clients.Client extends Backbone.RelationalModel
		relations: [{
			type:				Backbone.HasMany
			relatedModel: 		United.Models.Projects.Project
			collectionType:		United.Collections.Projects.Projects
			key:				'projects'
			reverseRelation:
				key:			'client'
				type:			Backbone.HasOne
				includeInJSON:	'id'
		}]
	United.Models.Clients.Client.setup()