define [
	'backbone'
	'ns'
	'relational'
	'collections/users'
	'models/user'
], (Backbone, namespace) ->

	namespace 'BU.Models.Role'
	class BU.Models.Role extends Backbone.RelationalModel

	BU.Models.Role.setup()