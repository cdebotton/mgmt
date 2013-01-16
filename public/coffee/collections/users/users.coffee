define (require, exports, module) ->

	ns			= require 'ns'
	Backbone 	= require 'backbone'
	UserModel	= require 'models/users/user'

	ns 'United.Collections.Users.Users'
	class United.Collections.Users.Users extends Backbone.Collection

		model: UserModel

		initialize: ->
