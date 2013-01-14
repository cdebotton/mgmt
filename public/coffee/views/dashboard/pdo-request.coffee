define [
	'backbone'
	'ns'
	'animate'
	'jst'
], (Backbone, ns) ->

	ns 'United.Views.Dashboard.PdoRequest'
	class United.Views.Dashboard.PdoRequest extends Backbone.View
		el: '#pdo-request'

		events:
			'click #make-request':		'makeRequest'
			'click .icon-remove':		'cancelRequest'
			'click #cancel-request':	'cancelRequest'

		initialize: ->
			@model.on 'destroy', @destroyed, @
			@render()

		render: ->
			ctx = @model.toJSON()
			html = United.JST.PdoRequest ctx
			@$el.html html
			if @options.open is false
				@$el.css {
					opacity: 0
					display: 'block'
				}
				h = @$el.outerHeight()
				@$el.css {
					marginTop: -(h + 10)
					opacity: 1
				}
				@$el.animate {
					marginTop: 0
				}, 175, 'ease-out'

		makeRequest: (e) ->

		cancelRequest: (e) =>
			e.preventDefault()
			@model.destroy()

		destroyed: (model) ->
			United.EventBus.trigger 'request-closed'
			h = @$el.innerHeight()
			@$el.animate {
				marginTop: -(h+10)
			}, 175, 'ease-int', () =>
				@$el.html ''
				@undelegateEvents()
