define [
	'backbone'
	'ns'
	'models/discipline'
], (Backbone, ns) ->

	ns 'BU.Collections.Disciplines'
	class BU.Collections.Disciplines extends Backbone.Collection
		model: BU.Models.Discipline