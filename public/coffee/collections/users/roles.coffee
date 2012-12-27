define [
	'backbone',
	'ns',
	'models/users/role'
], (Backbone, ns) ->

	ns 'United.Collections.Users.Roles'
	class United.Collections.Users.Roles extends Backbone.Collection

		model: United.Models.Users.Role