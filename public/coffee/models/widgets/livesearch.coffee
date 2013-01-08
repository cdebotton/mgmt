define [
	'backbone'
	'underscore'
	'ns'
	'relational'
	'models/widgets/livesearch-source'
	'collections/widgets/livesearch-sources'
], (Backbone, _, ns) ->

	ns 'United.Models.Widgets.LiveSearch'
	class United.Models.Widgets.LiveSearch extends Backbone.RelationalModel
		relations: [{
			type:				Backbone.HasMany
			key:				'sources'
			relatedModel:		United.Models.Widgets.LiveSearchSource
			collectionType:		United.Collections.Widgets.LiveSearchSources
			reverseRelation:
				type:			Backbone.HasOne
				key:			'search'
				includeInJSON:	false
		}]

	United.Models.Widgets.LiveSearch.setup()

