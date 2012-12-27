define [
	'backbone'
	'ns'
	'jst'
], (Backbone, ns) ->

	ns 'United.Views.Tasks.Overage'
	class United.Views.Tasks.Overage extends Backbone.View
		
		tagName:	'div'
		
		className:	'overage'

		initialize: ->
			@startListening()
			@$el.css
				marginLeft: @model.get 'x'
				width: @model.get 'width'
			if parseInt(@model.get 'value') >= 100
				@$el.addClass 'danger'
			else if parseInt(@model.get 'value') is 0
				@$el.hide()

		startListening: ->
			BU.EventBus.on 'offset-timeline', @offsetTimeline, @

		stopListening: ->
			BU.EventBus.off 'offset-timeline', @offsetTimeline, @

		render: ->
			ctx = @model.toJSON()
			html = BU.JST.Overage ctx
			@$el.html html
			@

		clear: -> @$el.remove()

		offsetTimeline: (dx) ->
			@$el.css
				'-webkit-transform':	"translate3d(#{dx})"