define [
	'backbone',
	'ns',
	'models/users/role'
], (Backbone, namespace) ->

	namespace 'United.Collections.Users.Roles'
	class United.Collections.Users.Roles extends Backbone.Collection

		model: United.Models.Users.Role