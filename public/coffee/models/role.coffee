define [
	'backbone'
	'ns'
	'relational'
	'collections/users'
	'models/user'
], (Backbone, namespace) ->

	namespace 'BU.Model.Role'
	class BU.Model.Role extends Backbone.RelationalModel

	BU.Model.Role.setup()