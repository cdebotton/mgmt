define [
	'backbone'
	'ns'
	'relational'
	'collections/users/users'
	'models/users/user'
], (Backbone, ns) ->

	ns 'United.Models.Users.Role'
	class United.Models.Users.Role extends Backbone.RelationalModel

	United.Models.Users.Role.setup()