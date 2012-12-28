define [
	'backbone'
	'underscore'
	'ns'
	'relational'
	'models/users/role'
	'collections/users/roles'
	'models/users/discipline'
	'collections/users/disciplines'
], (Backbone, _, ns, relational) ->

	ns 'United.Models.Users.Session'
	class United.Models.Users.Session extends Backbone.RelationalModel

		relations: [{
			type:				Backbone.HasMany
			key:				'roles'
			relatedModel:		United.Models.Users.Role
			collectionType:		United.Collections.Users.Roles
		}, {
			type:				Backbone.HasMany
			key:				'disciplines'
			relatedModel:		United.Models.Users.Role
			collectionType:		United.Collections.Users.Disciplines
		}]

		url: -> 'api/v1/session'

		isAdmin: ->
			roles = @get('roles').pluck 'name'
			return _.indexOf(roles, 'Admin') > -1

	United.Models.Users.Session.setup()