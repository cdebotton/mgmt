define [
	'backbone',
	'ns',
	'relational',
	'models/role',
	'collections/roles',
	'models/task',
	'collections/tasks'
	], (Backbone, namespace) ->
		
	namespace 'BU.Model.User'
	class BU.Model.User extends Backbone.RelationalModel

		url: -> "/admin/api/v1/users" + if not @isNew() then "/update/#{@get 'id'}" else ''

		relations: [{
			type:				Backbone.HasMany
			key:				'roles'
			relatedModel:		BU.Model.Role
			collectionType:		BU.Collection.Roles
			reverseRelation:
				type:			Backbone.HasMany
				key: 			'user'
				keySource:		'user_id'
				includeInJSON:	'id'
		}, {
			type:				Backbone.HasMany
			key:				'tasks'
			relatedModel:		BU.Model.Task
			collectionType:		BU.Collection.Tasks
			reverseRelation:
				type:			Backbone.HasOne
				key:			'user'
				keySource:		'user_id'
				includeInJSON:	'id'
		}]

		defaults:
			first_name:	'New'
			last_name:	'User'
			photo: 'http://placehold.it/100x100'
		
		initialize: ->

	BU.Model.User.setup()