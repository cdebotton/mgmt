define [
	'backbone'
	'underscore'
	'ns'
	'relational'
	'models/widgets/livesearch-result'
	'collections/widgets/livesearch-results'
], (Backbone, _, ns) ->

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
		}, {
			type:				Backbone.HasMany
			key:				'source'
			relatedModel:		United.Models.Widgets.LiveSearchResult
			collectionType:		United.Collections.Widgets.LiveSearchResults
			reverseRelation:
				type:			Backbone.HasOne
				key:			'search'
				includeInJSON:	false
		}]

		query: (string) ->
			results = @get('source').filter (src, key) ->
				~src.get('name').toLowerCase().indexOf string.toLowerCase()
			for result, i in results
				console.log result.get 'name'
			console.log '----'
	United.Models.Widgets.LiveSearch.setup()

