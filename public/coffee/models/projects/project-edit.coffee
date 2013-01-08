define [
	'backbone'
	'ns'
	'relational'
	'models/projects/project'
	'models/tasks/task'
], (Backbone, ns) ->

	ns 'United.Models.Projects.ProjectEdit'
	class United.Models.Projects.ProjectEdit extends Backbone.RelationalModel

	United.Models.Projects.ProjectEdit.setup()
