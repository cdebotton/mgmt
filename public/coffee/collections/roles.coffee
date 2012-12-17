define [
	'backbone',
	'ns',
	'models/role'
], (Backbone, namespace) ->

	namespace 'BU.Collections.Roles'
	class BU.Collections.Roles extends Backbone.Collection

		model: BU.Models.Role