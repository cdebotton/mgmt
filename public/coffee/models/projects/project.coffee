define [
	'backbone'
	'underscore'
	'ns'
	'relational'
	'models/tasks/task'
	'collections/tasks/tasks'
], (Backbone, _, ns) ->

	ns 'United.Models.Projects.Project'
	class United.Models.Projects.Project extends Backbone.RelationalModel

		url: -> "/api/v1/projects" + if not @isNew() then "/#{@get 'id'}" else ''

		relations: [{
			type:				Backbone.HasMany
			relatedModel:		United.Models.Tasks.Task
			collectionType:		United.Collections.Tasks.Tasks
			key:				'tasks'
			reverseRelation:
				key:			'project'
				includeInJSON:	'id'
		}]

		defaults:
			name: 			'Unnamed Project'
			code: 			'NEW'
			client_id:		null
			client_name:	null

		initialize: ->

	United.Models.Projects.Project.setup()
