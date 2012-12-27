define [
	'backbone'
	'ns'
	'relational'
	'models/users/role'
	'collections/users/roles'
	'models/tasks/task'
	'collections/tasks/tasks'
	'models/users/discipline'
	'collections/users/disciplines'
	], (Backbone, namespace) ->
		
	namespace 'United.Models.Users.User'
	class United.Models.Users.User extends Backbone.RelationalModel

		url: -> "/api/v1/users" + if not @isNew() then "/update/#{@get 'id'}" else ''

		relations: [{
			type:				Backbone.HasMany
			key:				'roles'
			relatedModel:		United.Models.Users.Role
			collectionType:		United.Collections.Tasks.Roles
		}, {
			type:				Backbone.HasMany
			key:				'tasks'
			relatedModel:		United.Models.Tasks.Task
			collectionType:		United.Collections.Tasks.Tasks
			reverseRelation:
				type:			Backbone.HasOne
				key:			'user'
				keySource:		'user_id'
				includeInJSON:	'id'
		}, {
			type: 				Backbone.HasMany
			key:				'disciplines'
			relatedModel:		United.Models.Users.Discipline
			collectionType:		United.Collections.Tasks.Disciplines
		}]

		defaults:
			first_name:	'New'
			last_name:	'User'
			photo: 'http://placehold.it/100x100'
		
		initialize: ->

	United.Models.Users.User.setup()