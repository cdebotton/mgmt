define [
	'backbone',
	'ns',
	'models/task'
], (Backbone, namespace) ->

	namespace 'BU.Collections.Tasks'
	class BU.Collections.Tasks extends Backbone.Collection

		model: BU.Models.Task