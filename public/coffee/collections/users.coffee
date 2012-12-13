define [
	'backbone',
	'ns',
	'models/user'
], (Backbone, namespace) ->

	namespace 'BU.Collection.Users'
	class BU.Collection.Users extends Backbone.Collection

		model: BU.Model.User

		initialize: ->