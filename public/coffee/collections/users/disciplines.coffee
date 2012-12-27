define [
	'backbone'
	'ns'
	'models/users/discipline'
], (Backbone, ns) ->

	ns 'United.Collections.Users.Disciplines'
	class United.Collections.Users.Disciplines extends Backbone.Collection
		model: United.Models.Users.Discipline