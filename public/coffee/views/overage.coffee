define [
	'backbone'
	'ns'
	'jst'
], (Backbone, ns) ->

	ns 'BU.View.Overage'
	class BU.View.Overage extends Backbone.View
		
		tagName:	'div'
		
		className:	'overage'

		initialize: ->
			BU.EventBus.on 'offset-timeline', @offsetTimeline, @
			@$el.css
				marginLeft: @model.get 'x'
				width: @model.get 'width'
			if parseInt(@model.get 'value') >= 100
				@$el.addClass 'danger'
			else if parseInt(@model.get 'value') is 0
				@$el.hide()

		render: ->
			ctx = @model.toJSON()
			html = BU.JST.Overage ctx
			@$el.html html
			@

		clear: -> @$el.remove()

		offsetTimeline: (dx) ->
			@$el.css
				'-webkit-transform':	"translate3d(#{dx})"