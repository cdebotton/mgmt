define [
	'backbone',
	'ns',
	'views/user-badge'
], (Backbone, namespace) ->

	namespace 'BU.View.ProfilePalette'
	class BU.View.ProfilePalette extends Backbone.View

		el: '#profile-palette'

		initialize: ->
			BU.EventBus.on 'nav-affix', @affix, @
			BU.EventBus.on 'nav-affix', @affix, @
			@model.on 'add:user', @addOne, @
			@model.on 'reset:user', @addAll, @
			@addAll()

		addOne: (user) =>
			view = new BU.View.UserBadge
				model: user
			el = view.render().$el
			@$el.append el

		addAll: (users) ->
			@model.get('users').each @addOne

		affix: (toggle) ->
			if toggle is true then @$el.addClass 'affix'
			else @$el.removeClass 'affix'