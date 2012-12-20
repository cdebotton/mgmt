define [
	'backbone'
	'underscore'
	'ns'
	'relational'
	'models/role'
	'collections/roles'
	'models/discipline'
	'collections/disciplines'
], (Backbone, _, ns, relational) ->

	ns 'BU.Models.Session'
	class BU.Models.Session extends Backbone.RelationalModel

		relations: [{
			type:				Backbone.HasMany
			key:				'roles'
			relatedModel:		BU.Models.Role
			collectionType:		BU.Collections.Roles
		}, {
			type:				Backbone.HasMany
			key:				'disciplines'
			relatedModel:		BU.Models.Role
			collectionType:		BU.Collections.Disciplines
		}]

		url: -> 'api/v1/session'

		isAdmin: ->
			roles = @get('roles').pluck 'name'
			return _.indexOf(roles, 'Admin') > -1

	BU.Models.Session.setup()