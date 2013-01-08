define [
	'backbone'
	'ns'
	'relational'
], (Backbone, ns) ->

	ns 'United.Models.Projects.ProjectTaskEdit'
	class United.Models.Projects.ProjectTaskEdit extends Backbone.RelationalModel

	United.Models.Projects.ProjectTaskEdit.setup()
