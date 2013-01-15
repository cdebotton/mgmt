define [
	'backbone'
	'ns'
	'jst'
	'views/dashboard/pdo-request-item'
], (Backbone, ns) ->

	ns 'United.Views.Dashboard.PdoList'
	class United.Views.Dashboard.PdoList extends Backbone.View
		el: '#pdo-list'

		events:
			'click #close-pdo-list':	'close'
			'click .cancel-request':	'deletePdo'

		initialize: ->
			@list = @$ '#pdo-list-ul'
			@addAll()
			@render()

		addAll: (items) =>
			@model.get('requests').each @addOne

		addOne: (item) =>
			view = new United.Views.Dashboard.PdoRequestItem
				model: item
			@list.append view.render().$el

		render: ->
			@$el.css {
				display: 'block'
				opacity: 0
			}
			@$el.animate {
				opacity: 1
			}, 175, 'ease-in'
			@

		deletePdo: (e) =>
			e.preventDefault()
			id = $(e.currentTarget).data 'id'
			pdo = @model.get('requests').find id
			console.log pdo

		close: (e) =>
			e.preventDefault()
			@$el.animate {
				opacity: 0
			}, 175, 'ease-out', () =>
				@$el.html ''
				@$el.css 'display', 'none'
				@undelegateEvents()
				United.EventBus.trigger 'pdo-list-closed'
