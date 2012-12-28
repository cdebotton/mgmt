define [
	'backbone',
	'ns',
	'models/tasks/task'
], (Backbone, ns) ->

	ns 'United.Collections.Tasks.Tasks'
	class United.Collections.Tasks.Tasks extends Backbone.Collection
		model: United.Models.Tasks.Task

		comparator: (task) -> task.get 'start_date'