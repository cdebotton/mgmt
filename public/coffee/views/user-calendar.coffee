define [
	'backbone'
	'ns'
	'jst'
], (Backbone, ns) ->

	class BU.Views.UserCalendar extends Backbone.View

		tagName: 'article'

		className: 'user-calendar-item'

		render: ->
			ctx = @model.toJSON()
			html = BU.JST.UserCalendar ctx
			@$el.html html
			@