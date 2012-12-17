define [
	'backbone'
	'ns'
	'relational'
	'models/task'
], (Backbone, ns) ->

	ns 'BU.Models.EditModal'
	class BU.Models.EditModal extends Backbone.RelationalModel
		relations: [{
			type:				Backbone.HasOne
			key:				'task'
			relatedModel:		BU.Models.Task
			reverseRelation:
				key:			'modal'
				includeInJSON:	false
		}]
	BU.Models.EditModal.setup()