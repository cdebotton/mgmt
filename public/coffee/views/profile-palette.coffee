define [
	'backbone'
	'underscore'
	'ns'
	'views/user-badge'
], (Backbone, _, namespace) ->

	namespace 'BU.Views.ProfilePalette'
	class BU.Views.ProfilePalette extends Backbone.View

		el: '#profile-palette'

		initialize: ->
			BU.EventBus.on 'set-filter', @setFilter, @
			BU.EventBus.on 'nav-affix', @affix, @
			BU.EventBus.on 'nav-affix', @affix, @
			@model.on 'add:user', @addOne, @
			@model.on 'reset:user', @addAll, @
			@addAll()

		addOne: (user) =>
			view = new BU.Views.UserBadge
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