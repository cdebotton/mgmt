define [
	'backbone',
	'ns',
	'models/users/user'
], (Backbone, namespace) ->

	namespace 'United.Collections.Users.Users'
	class United.Collections.Users.Users extends Backbone.Collection

		model: United.Models.Users.User

		initialize: ->