define [
	'backbone'
	'underscore'
	'ns'
	'views/widgets/livesearch-list'
	'lib/keycodes'
	'jst'
], (Backbone, _, ns) ->

	ns 'United.Views.Widgets.LiveSearchInput'
	class United.Views.Widgets.LiveSearchInput extends Backbone.View
			LIST_VISIBLE = false
			events:
				'keydown':		'keyDown'
				'keypress':		'keyPress'
				'keyup':		'keyUp'

			initialize: ->
				United.JST.Hb.registerHelper 'printResults', @printResults
				@list = new United.Views.Widgets.LiveSearchList
				@model.on 'change:results', @render, @

			keyDown: (e) =>
				@suppressKeyPressRepeat = _.indexOf([40,38,9,13,27], e.keyCode) > 0
				@move e

			keyPress: (e) =>
				if @suppressKeyPressRepeat then return
				@move e

			keyUp: (e) =>
				switch(e.keyCode)
					when United.Keyboard.DOWN then break
					when United.Keyboard.UP then break
					when United.Keyboard.SHIFT then break
					when United.Keyboard.CTRL then break
					when United.Keyboard.ALT then break
					when United.Keyboard.TAB
						if not LIST_VISIBLE then return
						@select()
					when United.Keyboard.ENTER
						if not LIST_VISIBLE then return
						@select()
					when United.Keyboard.ESC
						if not LIST_VISIBLE then return
						@hide()
					else @lookup()
				e.stopPropagation()
				e.preventDefault()

			select: ->

			lookup: ->
				string = @$el.val()
				results = @model.get('sources').filter (source, key) ->
					~source.get('name').toLowerCase().indexOf string.toLowerCase()
				@model.set {
					string: string
					results: new Backbone.Collection results
				}


			render: ->
				if @model.get('results').length > 0
					return
				else
					return

			hide: ->

			move: (e) =>
				if not LIST_VISIBLE then return
				switch e.keyCode
					when United.Keyboard.TAB then e.preventDefault()
					when United.Keyboard.ENTER then e.preventDefault()
					when United.Keyboard.ESC then e.preventDefault()
					when United.Keyboard.UP
						e.preventDefault()
						@previous()
					when United.Keyboard.DOWN
						e.preventDefault()
						@next()
				e.stopPropagation()

			previous: ->

			next: ->
