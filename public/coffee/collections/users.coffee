define [
	'backbone',
	'ns',
	'models/user'
], (Backbone, namespace) ->

	namespace 'BU.Collections.Users'
	class BU.Collections.Users extends Backbone.Collection

		model: BU.Models.User

		initialize: ->