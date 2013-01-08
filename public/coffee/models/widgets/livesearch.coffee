define [
	'backbone'
	'ns'
	'relational'
	'models/widgets/livesearch-result'
	'collections/widgets/livesearch-results'
], (Backbone, ns) ->

	ns 'United.Models.Widgets.LiveSearch'
	class United.Models.Widgets.LiveSearch extends Backbone.RelationalModel
		relations: [{
			type:				Backbone.HasMany
			key:				'results'
			relatedModel:		United.Models.Widgets.LiveSearchResult
			collectionType:		United.Collections.Widgets.LiveSearchResults
			reverseRelation:
				type:			Backbone.HasOne
				key:			'search'
				includeInJSON:	false
		}]
	United.Models.Widgets.LiveSearch.setup()

