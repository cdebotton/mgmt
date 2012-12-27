define [
	'backbone'
	'ns'
], (Backbone, ns) ->

	class United.Models.Tasks.ViewSelector extends Backbone.Model

		defaults:
			currentView: 'task'

		initialize: ->  @on 'change:currentView', @announce, @

		announce: (model, view) -> BU.EventBus.trigger 'set-view',view