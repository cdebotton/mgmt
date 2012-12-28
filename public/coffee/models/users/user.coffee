define [
	'backbone'
	'ns'
	'relational'
	'models/tasks/task'
	'models/users/role'
	'collections/users/roles'
	'models/users/discipline'
	'collections/users/disciplines'
	], (Backbone, ns) ->
		
	ns 'United.Models.Users.User'
	class United.Models.Users.User extends Backbone.RelationalModel

		url: -> "/api/v1/users" + if not @isNew() then "/update/#{@get 'id'}" else ''

		relations: [{
			type:				Backbone.HasMany
			key:				'roles'
			relatedModel:		United.Models.Users.Role
			collectionType:		United.Collections.Users.Roles
		}, {
			type: 				Backbone.HasMany
			key:				'disciplines'
			relatedModel:		United.Models.Users.Discipline
			collectionType:		United.Collections.Users.Disciplines
		}, {
			type:				Backbone.HasMany
			key:				'tasks'
			relatedModel:		United.Models.Pivots.TaskUser
			reverseRelaton:
				key:			'user'
		}]

		defaults:
			first_name:	'New'
			last_name:	'User'
			photo: 'http://placehold.it/100x100'
		
		initialize: ->

	United.Models.Users.User.setup()