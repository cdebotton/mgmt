define [
	'backbone',
	'ns',
	'relational',
	'models/user',
	'collections/users'
], (Backbone, namespace) ->

	namespace 'BU.Models.App'
	class BU.Models.App extends Backbone.RelationalModel

		relations: [{
			type:				Backbone.HasMany
			key:				'users'
			relatedModel:		BU.Models.User
			collectionType:		BU.Collections.Users
			reverseRelation:
				type:			Backbone.HasOne
				key:			'app'
				includeInJson:	'id'
		}]

		initialize: ->
			@get('users').each @sanitizeUsers

		sanitizeUsers: (user, key) =>
			user.get('tasks').each @sanitizeTasks

		sanitizeTasks: (task, key) =>
			task.attributes['percentage'] = task.get('pivot').percentage
			delete task.attributes['pivot']

	BU.Models.App.setup()
