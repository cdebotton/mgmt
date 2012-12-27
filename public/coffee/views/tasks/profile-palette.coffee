define [
	'backbone'
	'underscore'
	'ns'
	'views/tasks/user-badge'
], (Backbone, _, ns) ->

	ns 'United.Views.Tasks.ProfilePalette'
	class United.Views.Tasks.ProfilePalette extends Backbone.View

		el: '#profile-palette'

		initialize: ->
			@startListening()
			@addAll()

		startListening: ->
			United.EventBus.on 'set-filter', @setFilter, @
			United.EventBus.on 'nav-affix', @affix, @
			United.EventBus.on 'nav-affix', @affix, @
			@model.on 'add:user', @addOne, @
			@model.on 'reset:user', @addAll, @

		stopLisening: ->
			United.EventBus.off 'set-filter', @setFilter, @
			United.EventBus.off 'nav-affix', @affix, @
			United.EventBus.off 'nav-affix', @affix, @
			@model.off 'add:user', @addOne, @
			@model.off 'reset:user', @addAll, @

		addOne: (user) =>
			view = new United.Views.Tasks.UserBadge
				model: user
			el = view.render().$el
			@$el.append el

		addAll: (users) ->
			@model.get('users').each @addOne

		affix: (toggle) ->
			if toggle is true then @$el.addClass 'affix'
			else @$el.removeClass 'affix'

		setFilter: (type, filter) ->
			@$el.html ''
			if type is null then return @addAll()
			users = @model.get('users').filter (user) ->
				matches = user.get(type).filter (item) ->
					+item.get('id') is +filter
				matches.length > 0
			
			if users.length > 0 then _.each users, @addOne