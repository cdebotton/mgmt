define [
	'backbone'
	'underscore'
	'ns'
	'relational'
	'collections/users/roles'
	'collections/users/disciplines'
	'collections/dashboard/pdo-requests'
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
			relatedModel:		United.Models.Users.Discipline
			collectionType:		United.Collections.Users.Disciplines
		}, {
			type:				Backbone.HasMany
			key:				'requests'
			relatedModel:		United.Models.Dashboard.PdoRequest
			collectionType:		United.Collections.Dashboard.PdoRequest
		}]

		url: -> 'api/v1/session'

		isAdmin: ->
			roles = @get('roles').pluck 'name'
			return _.indexOf(roles, 'Admin') > -1

	United.Models.Users.Session.setup()
