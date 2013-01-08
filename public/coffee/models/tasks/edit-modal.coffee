define [
	'backbone'
	'ns'
	'relational'
	'models/tasks/task'
], (Backbone, ns) ->

	ns 'United.Models.Tasks.EditModal'
	class United.Models.Tasks.EditModal extends Backbone.RelationalModel

	United.Models.Tasks.EditModal.setup()
