define [
	'backbone',
	'ns',
	'relational',
	'models/user',
	'collections/users'
], (Backbone, namespace) ->

	namespace 'BU.Model.App'
	class BU.Model.App extends Backbone.RelationalModel

		relations: [{
			type:				Backbone.HasMany
			key:				'users'
			relatedModel:		BU.Model.User
			collectionType:		BU.Collection.Users
			reverseRelation:
				type:			Backbone.HasOne
				key:			'app'
				includeInJson:	'id'
		}]

		initialize: ->

	BU.Model.App.setup()
