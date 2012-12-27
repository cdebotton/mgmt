define [
	'backbone'
	'ns'
	'models/projects/project'
], (Backbone, ns) ->

	ns 'United.Collections.Projects.Projects'
	class United.Collections.Projects.Projects extends Backbone.Collection
		model: United.Models.Projects.Project