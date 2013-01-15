define [
	'backbone'
	'ns'
	'jst'
	'animate'
], (Backbone, ns) ->

	ns 'United.Views.Requests.RequestOverviewItem'
	class United.Views.Requests.RequestOverviewItem extends Backbone.View
		tagName: 'article'

		className: 'request-overview-item'

		events:
			'click':					'setState'
			'click .accept-request':	'accept'
			'click .reject-request':	'reject'

		initialize: ->
			United.EventBus.on 'activating-request-item', @checkStatus, @

		checkStatus: (cid) ->
			if @$el.hasClass('active') and cid isnt @cid then @deactivate()

		render: ->
			ctx = @model.toJSON()
			html = United.JST.RequestOverviewItem ctx
			@$el.html html
			@

		setup: =>
			@secondary = @$ '.msg, .actions'
			@secondary.css 'display', 'block'
			@height = @secondary.outerHeight()
			@secondary.css 'display', 'none'

		setState: (e) =>
			e.stopPropagation()
			if @$el.hasClass 'active' then @deactivate()
			else @activate()

		activate: () =>
			United.EventBus.trigger 'activating-request-item', @cid
			@$el.addClass('active')
			@secondary.css {
				display: 'block'
				opacity: 0
				height: 0
			}
			@secondary.animate {
				opacity: 1
				height: @height
			}

		deactivate: () =>
			@$el.removeClass('active')
			@secondary.animate {
				opacity: 0
				height: 0
			}

		accept: (e) =>
			@model.set 'status', true
			@model.save {}, {
				wait: true
				success: @destroyView
			}
			e.preventDefault()
			e.stopPropagation()

		reject: (e) =>
			@model.destroy {
				wait: true
				success: @destroyView
			}
			e.preventDefault()
			e.stopPropagation()

		destroyView: =>
			@$el.animate {
				opacity: 0
				height: 0
				margin: 0
			}, 175, 'ease-out', () => @remove()
