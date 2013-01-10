define [
	'backbone'
	'underscore'
	'ns'
	'views/widgets/livesearch-list'
	'lib/keycodes'
], (Backbone, _, ns) ->

	ns 'United.Views.Widgets.LiveSearchInput'
	class United.Views.Widgets.LiveSearchInput extends Backbone.View
			LIST_VISIBLE = false
			events:
				'keydown':		'keyDown'
				'keypress':		'keyPress'
				'keyup':		'keyUp'

			initialize: ->
				@list = new United.Views.Widgets.LiveSearchList
					listenTo: @cid
				@model.on 'change:results', @render, @
				@$el.wrap '<span class="live-search"></span>'
				@wrapper = @$el.parent '.live-search'
				@wrapper.append @list.$el
				@icons = $ '<span class="add-on"><i class="icon icon-search"></i><i class="icon icon-remove icon-white"></i></span>'
				@$el.after @icons

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

			lookup: ->
				@model.unset 'currentIndex'
				@model.unset 'results'
				@query = @$el.val()
				if @model.has('queryUri') then @model.fetch { success: @drawResults }
				else @drawResults()


			drawResults: =>
				results = @model.get('sources').filter (source, key) =>
						~source.get('name').toLowerCase().indexOf @query.toLowerCase()
					if results.length > 0 and @query isnt ''
						LIST_VISIBLE = true
						results = new Backbone.Collection @sorter results
						results.on 'selected', @itemSelected, @
						United.EventBus.trigger 'search-results-found', @query, results, @cid
						@model.set 'results', results
						@model.set 'currentIndex', 0
					else @hide()

			sorter: (results) =>
				beginsWith = []
				caseSensitive = []
				caseInsensitive = []
				while (item = results.shift())
					if not item.get('name').toLowerCase().indexOf @query.toLowerCase() then beginsWith.push item
					else if ~item.get('name').indexOf @query then caseSensitive.push item
					else caseInsensitive.push item
				beginsWith.concat caseSensitive, caseInsensitive

			hide: ->
				LIST_VISIBLE = false
				United.EventBus.trigger 'live-search-hide', @cid

			previous: -> @model.set 'currentIndex', @model.get('currentIndex') - 1

			next: -> @model.set 'currentIndex', @model.get('currentIndex') + 1

			select: (selection) ->
				if typeof selection is 'undefined'
					selection = @model.get('results').at @model.get 'currentIndex'
				@$el.val selection.get 'name'
				@$el.attr 'disabled', true
				@icons.on 'click', _.bind @deselect, @
				@model.set {
					result: selection
				}
				@hide()

			populate: (item, _idAttribute='id', _nameAttribute='name') ->
				@$el.val item.get _nameAttribute
				@$el.attr 'disabled', true
				@icons.on 'click', _.bind @deselect, @
				@model.set {
					result: item
				}
				@hide()

			deselect: (e) ->
				@icons.off 'click', _.bind @deselect, @
				@$el.removeAttr 'disabled'
				@$el.val ''
				@model.unset 'results'
				@model.unset 'currentIndex'
				@model.set 'value', null
				e.preventDefault()

			itemSelected: (model) =>
				@select model

			setValue: (property, value) ->
				target = @model.get('sources').find (src) ->
					src.get(property) is value
				@select target
