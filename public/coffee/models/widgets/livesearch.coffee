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

		url: ->
			if @model.has 'queryUri'
				@model.get 'queryUri'

		initialize: ->
			@on 'change:currentIndex', @controlCurrentIndex, @

		controlCurrentIndex: (model, index, status) ->
			if index isnt undefined
				if index < 0 then index = @get('results').length - 1
				else if index >= @get('results').length
					index = 0
				@attributes['currentIndex'] = index
				@get('results').each (result, key) ->
					result.unset 'active'
					if key is index then result.set 'active', true

	United.Models.Widgets.LiveSearch.setup()

