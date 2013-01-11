define [
	'backbone'
	'ns'
	'jst'
], (Backbone, ns) ->

	ns 'United.Views.Users.UserItem'
	class United.Views.Users.UserItem extends Backbone.View
		tagName: 'article'

		className: 'user-item'

		events:
			'click':		'editUser'

		initialize: ->

		render: ->
			ctx = @model.toJSON()
			html = United.JST.UserItem ctx
			@$el.html html
			@

		editUser: (e) =>
			e.preventDefault()
			e.stopPropagation()
			United.EventBus.trigger 'edit-user', @model
