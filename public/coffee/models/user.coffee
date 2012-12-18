define [
	'backbone'
	'ns'
	'relational'
	'models/role'
	'collections/roles'
	'models/task'
	'collections/tasks'
	'models/discipline'
	'collections/disciplines'
	], (Backbone, namespace) ->
		
	namespace 'BU.Models.User'
	class BU.Models.User extends Backbone.RelationalModel

		url: -> "/admin/api/v1/users" + if not @isNew() then "/update/#{@get 'id'}" else ''

		relations: [{
			type:				Backbone.HasMany
			key:				'roles'
			relatedModel:		BU.Models.Role
			collectionType:		BU.Collections.Roles
		}, {
			type:				Backbone.HasMany
			key:				'tasks'
			relatedModel:		BU.Models.Task
			collectionType:		BU.Collections.Tasks
			reverseRelation:
				type:			Backbone.HasOne
				key:			'user'
				keySource:		'user_id'
				includeInJSON:	'id'
		}, {
			type: 				Backbone.HasMany
			key:				'disciplines'
			relatedModel:		BU.Models.Discipline
			collectionType:		BU.Collections.Disciplines
		}]

		defaults:
			first_name:	'New'
			last_name:	'User'
			photo: 'http://placehold.it/100x100'
		
		initialize: ->

	BU.Models.User.setup()