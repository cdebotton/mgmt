define [
	'backbone'
	'ns'
	'relational'
	'models/tasks/task'
	'collections/tasks/tasks'
], (Backbone, ns) ->

	ns 'United.Models.Projects.Project'
	class United.Models.Projects.Project extends Backbone.RelationalModel

		relations: [{
			type:				Backbone.HasMany
			relatedModel:		United.Models.Tasks.Task
			collectionType:		United.Collections.Tasks.Tasks
			key:				'tasks'
			reverseRelation:
				type:			Backbone.HasOne
				key:			'project'
				includeInJSON:	true
		}]

		defaults:
			name: 'Unnamed Project'
			code: 'NEW'

		initialize: ->

	United.Models.Projects.Project.setup()