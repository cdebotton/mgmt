define [
	'backbone',
	'ns',
	'models/role'
], (Backbone, namespace) ->

	namespace 'BU.Collection.Roles'
	class BU.Collection.Roles extends Backbone.Collection

		model: BU.Model.Role