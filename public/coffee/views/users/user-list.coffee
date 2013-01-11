define [
	'backbone'
	'ns'
	'animate'
	'models/users/user'
	'views/users/user-item'
	'views/users/user-edit'
], (Backbone, ns) ->

	ns 'United.Views.Users.UserList'
	class United.Views.Users.UserList extends Backbone.View
		el: '#user-manager'

		events:
			'click #new-user':		'newUser'

		initialize: ->
			United.EventBus.on 'edit-user', @editUser, @
			@userList = @$ '#user-list'
			@addAll()

		addOne: (user) =>
			view = new United.Views.Users.UserItem
				model: user
			@userList.append view.render().$el

		addAll: (users) =>
			@model.get('users').each @addOne

		editUser: (user) ->
			@editor = new United.Views.Users.UserEdit
				model: user
			@editor.render()

		newUser: (user) =>
			@editor = new United.Views.Users.UserEdit
				model: new United.Models.Users.User
			@editor.render()
