define [
	'backbone',
	'ns',
	'models/task'
], (Backbone, namespace) ->

	namespace 'BU.Collection.Tasks'
	class BU.Collection.Tasks extends Backbone.Collection

		model: BU.Model.Task