define [
	'backbone'
	'ns'
	'relational'
	'models/users/user'
	'collections/users/users'
	'models/users/session'
], (Backbone, namespace) ->

	namespace 'United.Models.App'
	class United.Models.App extends Backbone.RelationalModel

		relations: [{
			type:				Backbone.HasMany
			key:				'users'
			relatedModel:		United.Models.Users.User
			collectionType:		United.Collections.Users.Users
			reverseRelation:
				type:			Backbone.HasOne
				key:			'app'
				includeInJson:	'id'
		}, {
			type:				Backbone.HasOne
			key:				'session'
			relatedModel:		United.Models.Users.Session
			reverseRelation:
				type:			Backbone.HasOne
				key:			'app'
				includeInJSON:	false
		}]

		initialize: ->
			@get('users').each @sanitizeUsers
			@set 'session', new United.Models.Users.Session

		sanitizeUsers: (user, key) =>
			user.get('tasks').each @sanitizeTasks

		sanitizeTasks: (task, key) =>
			task.attributes['percentage'] = task.get('pivot').percentage
			delete task.attributes['pivot']

	United.Models.App.setup()
