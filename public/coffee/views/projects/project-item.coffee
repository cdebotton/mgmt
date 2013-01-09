define [
	'backbone'
	'ns'
	'jst'
	'animate'
], (Backbone, ns) ->

	ns 'United.Views.Projects.ProjectItem'
	class United.Views.Projects.ProjectItem extends Backbone.View
		tagName: 	'article'

		className:	'project-item'

		events:
			'click':	'tileClicked'

		initialize: ->
			United.JST.Hb.registerHelper 'printClient', @printClient
			@model.on 'change', @render, @
			@model.on 'change:client', @render, @
			@model.on 'destroy', @destroy, @

		render: ->
			ctx = @model.toJSON()
			if @model.has('client')
				ctx.client = @model.get('client').toJSON()
			html = United.JST.ProjectItem ctx
			@$el.html html
			@

		tileClicked: (e) =>
			e.preventDefault()
			e.stopPropagation()
			United.EventBus.trigger 'open-project', @model

		destroy: (model) ->
			@$el.animate {
				opacity: 0
			}, 175, 'ease-out', => @remove()

		printClient: =>
			if @model.get('client') isnt null
				return new United.JST.Hb.SafeString "<h6>#{@model.get('client').get('name')}</h6>"
			else if @model.get('client_name') isnt null
				return new United.JST.Hb.SafeString "<h6>#{@model.get('client_name')}</h6>"
