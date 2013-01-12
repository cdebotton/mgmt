define [
	'backbone'
	'ns'
	'jst'
], (Backbone, ns) ->

	ns 'United.Views.Users.UserItem'
	class United.Views.Users.UserItem extends Backbone.View
		tagName: 'article'

		className: 'user-item'

		events:
			'click':				'editUser'
			'click .icon-remove':	'deleteUser'

		initialize: ->
			United.JST.Hb.registerHelper 'printDates', @printDates
			@model.on 'change', @render, @
			@model.on 'destroy', @remove, @

		render: ->
			ctx = @model.toJSON()
			if ctx.tasks
				for task, i in ctx.tasks
					if task.project_id isnt null
						task.project = @model.get('tasks').at(i).get('project').toJSON()
						task.project.client = @model.get('tasks').at(i).get('project').get('client').toJSON()
			html = United.JST.UserItem ctx
			@$el.html html
			@

		editUser: (e) =>
			e.preventDefault()
			e.stopPropagation()
			United.EventBus.trigger 'edit-user', @model

		deleteUser: (e) =>
			e.preventDefault()
			e.stopPropagation()
			@model.destroy()

		printDates: (start, end) ->
			"#{parseInt(start.getMonth())+1}.#{start.getDate()}.#{start.getFullYear()} &mdash; #{parseInt(end.getMonth())+1}.#{end.getDate()}.#{end.getFullYear()} "
