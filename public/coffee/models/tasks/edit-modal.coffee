define [
	'backbone'
	'ns'
	'relational'
	'models/tasks/task'
], (Backbone, ns) ->

	ns 'United.Models.Tasks.EditModal'
	class United.Models.Tasks.EditModal extends Backbone.RelationalModel

		relations: [{
			type:				Backbone.HasOne
			key:				'task'
			relatedModel:		United.Models.Tasks.Task
			reverseRelation:
				key:			'modal'
				includeInJSON:	false
		}]
		
	United.Models.Tasks.EditModal.setup()