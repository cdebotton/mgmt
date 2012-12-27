define [
	'backbone',
	'ns',
	'models/tasks/task'
], (Backbone, namespace) ->

	namespace 'United.Collections.Tasks.Tasks'
	class United.Collections.Tasks.Tasks extends Backbone.Collection

		model: United.Models.Tasks.Task