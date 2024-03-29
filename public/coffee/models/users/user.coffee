define [
	'backbone'
	'ns'
	'relational'
	'collections/users/roles'
	'collections/tasks/tasks'
	'collections/users/disciplines'
	'collections/pdos/pdos'
	], (Backbone, ns) ->

	ns 'United.Models.Users.User'
	class United.Models.Users.User extends Backbone.RelationalModel
		url: -> "/api/v1/users" + if not @isNew() then "/#{@get 'id'}" else ''

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
		}, {
			type:				Backbone.HasMany
			key:				'pdos'
			relatedModel:		United.Models.Pdos.Pdo
			collectionType:		United.Collections.Pdos.Pdos
			reverseRelation:
				type:			Backbone.HasOne
				key:			'user'
				keySource:		'user_id'
				includeInJSON:	'id'
		}]

		defaults: {
			first_name:	'New'
			last_name:	'User'
			photo: 'http://placehold.it/100x100'
			pdo_allotment: 15
			hired_on: new Date()
		}

		parse: (resp) ->
			if resp.hired_on? and resp.hired_on not instanceof Date
				resp.hired_on = new Date resp.hired_on
			if resp.last_login? and resp.last_login not instanceof Date
				resp.last_login = new Date resp.last_login
			resp

		initialize: ->

	United.Models.Users.User.setup()
