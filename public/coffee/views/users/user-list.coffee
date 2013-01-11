define [
	'backbone'
	'ns'
	'animate'
	'views/users/user-item'
], (Backbone, ns) ->

	ns 'United.Views.Users.UserList'
	class United.Views.Users.UserList extends Backbone.View
		el: '#user-manager'

		initialize: ->
			@userList = @$ '#user-list'
			@addAll()

		addOne: (user) =>
			view = new United.Views.Users.UserItem
				model: user
			@userList.append view.render().$el

		addAll: (users) =>
			@model.get('users').each @addOne
