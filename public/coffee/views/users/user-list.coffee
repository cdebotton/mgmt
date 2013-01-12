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

		EDIT_OPEN = false

		events:
			'click #new-user':		'newUser'

		initialize: ->
			United.EventBus.on 'edit-user', @editUser, @
			United.EventBus.on 'user-edit-closed', () -> EDIT_OPEN = false
			@model.on 'add:users', @editUser, @
			@userList = @$ '#user-list'
			@addAll()

		addOne: (user) =>
			view = new United.Views.Users.UserItem
				model: user
			@userList.append view.render().$el

		addAll: (users) =>
			@model.get('users').each @addOne

		editUser: (user) ->
			if user.isNew() then @addOne user
			@editor?.undelegateEvents()
			@editor = new United.Views.Users.UserEdit
				model: user
				open: EDIT_OPEN
			EDIT_OPEN = true
			@editor.render()

		newUser: (user) =>
			@model.get('users').add {}

			@editor.render()
