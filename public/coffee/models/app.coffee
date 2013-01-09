define [
	'backbone'
	'ns'
	'relational'
	'models/users/user'
	'collections/users/users'
	'models/users/session'
	'collections/projects/projects'
], (Backbone, ns) ->

	ns 'United.Models.App'
	class United.Models.App extends Backbone.RelationalModel

		relations: [{
			type:				Backbone.HasMany
			key:				'users'
			relatedModel:		United.Models.Users.User
			collectionType:		United.Collections.Users.Users
			reverseRelation:
				type:			Backbone.HasOne
				key:			'app'
				includeInJson:	false
		}, {
			type:				Backbone.HasMany
			key:				'projects'
			relatedModel:		United.Models.Projects.Project
			collectionType:		United.Collections.Projects.Projects
			reverseRelation:
				key:			'app'
				includeInJSON:	false
		}]

		initialize: ->
			@set 'session', new United.Models.Users.Session

	United.Models.App.setup()
