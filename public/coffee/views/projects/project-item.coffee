define [
	'backbone'
	'ns'
	'jst'
], (Backbone, ns) ->

	ns 'United.Views.Projects.ProjectItem'
	class United.Views.Projects.ProjectItem extends Backbone.View
		tagName: 	'article'

		className:	'project-item'

		initialize: ->
			@model.on 'change', @render, @

		render: ->
			ctx = @model.toJSON()
			html = United.JST.ProjectItem ctx
			@$el.html html
			@
