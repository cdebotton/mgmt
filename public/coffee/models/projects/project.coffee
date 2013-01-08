define [
	'backbone'
	'ns'
	'relational'
	'models/tasks/task'
	'collections/tasks/tasks'
], (Backbone, ns) ->

	ns 'United.Models.Projects.Project'
	class United.Models.Projects.Project extends Backbone.RelationalModel

		url: -> "/api/v1/projects" + if not @isNew() then "/update/#{@get 'id'}" else ''

		relations: [{
			type:				Backbone.HasMany
			relatedModel:		United.Models.Tasks.Task
			collectionType:		United.Collections.Tasks.Tasks
			key:				'tasks'
			reverseRelation:
				type:			Backbone.HasOne
				key:			'project'
				keyDestination:	'project_id'
				keySource:		'project_id'
				includeInJSON:	true
		}]

		defaults:
			name: 'Unnamed Project'
			code: 'NEW'

		initialize: ->

		parse: ->
			@get('tasks').each (task, key) ->
				task.set 'start_date', new Date task.get 'start_date'
				task.set 'end_date', new Date task.get 'end_date'

	United.Models.Projects.Project.setup()
