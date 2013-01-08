define [
	'backbone'
	'underscore'
	'ns'
	'jquery'
	'jst'
	'animate'
], (Backbone, _, ns, $) ->

	ns 'United.Views.Widgets.Modal'
	class United.Views.Widgets.Modal extends Backbone.View
		tagName: 	'section'

		className:	'striped-cheech'

		events:
			'click .icon-remove':		'closeModal'

		initialize: ->
			United.JST.Hb.registerHelper 'printMsg', @printMsg
			United.JST.Hb.registerHelper 'printOptions', @printOptions
			@body = $ 'body'
			@$el.css {
				opacity: 0
			}
			@render()

		render: ->
			ctx = @model.toJSON()
			html = United.JST.OptionModal ctx
			@$el.html html
			@body.append @$el
			@modal = @$ '.edit-modal'
			@animateCheechIn()

		animateCheechIn: () ->
			@$el.animate { opacity: 1 }, 150, 'ease-in', @animateModalIn()

		animateModalIn: () ->
			@modal.css {
				top: 0
				marginLeft: - parseInt @modal.innerWidth() / 2
				marginTop: - parseInt @modal.innerHeight() / 2
			}

			@modal.animate {
				top: 75
				opacity: 1
			}

		closeModal: ->
			@modal.animate {
				top: 0
				opacity: 0
			}, 175, 'ease-out', @animateCheechOut

		animateCheechOut: =>
			@$el.animate {
				opacity: 0
			}, 175, 'ease-out', => @remove()

		printMsg: => new United.JST.Hb.SafeString @model.get 'msg'

		printOptions: (hash, opts) =>
			if hash instanceof Object
				buffer = ''
				for label, action of hash
					item = {}
					item.label = label
					item.className = label.replace(/\W/, '-').toLowerCase()
					@events["click .#{item.className}"] = action
					buffer += opts.fn item
				@undelegateEvents()
				@delegateEvents()
				return buffer
			else return opts.inverse()
