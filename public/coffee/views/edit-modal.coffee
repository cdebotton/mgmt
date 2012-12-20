define [
	'backbone'
	'underscore'
	'ns'
	'jquery'
	'jst'
	'animate'
	'models/task'
], (Backbone, _, ns, $) ->

	ns 'BU.Views.EditModal'
	class BU.Views.EditModal extends Backbone.View
		tagName:	'section'
		
		className:	'striped-cheech'
		
		events:
			'click .icon-remove':			'closeModal'
			'click button[type="submit"]':	'saveTask'

		initialize: ->
			BU.JST.Hb.registerHelper 'printUsers', @printUsers
			BU.JST.Hb.registerHelper 'printColors', @printColors

		render: ->
			@body = $ 'body'
			if @model.has('task')
				task = @model.get 'task'
				ctx = @model.get('task').toJSON()
				ctx.user_list = window.users
				ctx.start_month = task.get('start_date').getMonth() + 1
				ctx.start_day = task.get('start_date').getDate()
				ctx.start_year = task.get('start_date').getFullYear()
				ctx.end_month = task.get('end_date').getMonth() + 1
				ctx.end_day = task.get('end_date').getDate()
				ctx.end_year = task.get('end_date').getFullYear()
			else
				today = new Date
				ctx = {
					start_month: today.getMonth() + 1
					start_day: today.getDate()
					start_year: today.getFullYear()
					end_month: today.getMonth() + 1
					end_day: today.getDate()
					end_year: today.getFullYear()
					user_list: window.users
				}
			html = BU.JST.EditModal ctx
			@$el.html html
			@expose()
			@

		expose: () ->
			@body.bind 'keyup', @bindEscape
			@$el.css('opacity', 0).animate {
				opacity: 1
			}, 150, 'ease-in', @dropModal

		dropModal: =>
			@$('.edit-modal').delay(150).css({
				top: '50%'
				opacity: 1
				marginTop: -($(window).height()+250)
			}).animate {
				marginTop: -250
			}

		closeModal: (e) =>
			@$('.edit-modal').animate {
				marginTop: -($(window).height()+250)
			}, => @$el.animate { opacity: 0 }, => @$el.remove()
			@body.unbind 'keyup', @bindEscape
			BU.EventBus.trigger 'modal-closed'
			e.preventDefault()

		bindEscape: (e) => if e.keyCode is 27 then @closeModal e

		saveTask: (e) =>
			attrs = {
				'author_id':		window.author_id
				'name':				@$('[name="name"]').val()
				'project_code':		@$('[name="project_code"]').val()
				'client':			@$('[name="client"]').val()
				'start_date':		new Date @$('[name="start_year"]').val(), parseInt(@$('[name="start_month"]').val()) - 1, @$('[name="start_day"]').val()
				'end_date':			new Date @$('[name="end_year"]').val(), parseInt(@$('[name="end_month"]').val()) - 1, @$('[name="end_day"]').val()
				'color':			@$('[name="color"]').val()
				'track':			0
				'percentage':		$('[name="percentage"]').val()
				'user':				{ 'id': parseInt @$('[name="developer_id"]').val() }
			}

			if @model.has 'task'
				for attr, key of attrs
					@model.get('task').set attr, key
				@model.get('task').save()
			else
				task = new BU.Models.Task attrs
				task.save null, {
					wait: true
					success: (task, attrs, status) -> task.set 'id', attrs.id
				}

			@closeModal e

		printUsers: (array, opts) =>
			if array?.length
				buffer = ''
				for user, key in array
					item = {
						id: user.id
						email: user.email
						selected: if @model.get('task')?.has('user') and +user.id is +@model.get('task').get('user').get('id') then ' SELECTED' else ''
					}
					buffer += opts.fn item
				return buffer
			else return opts.elseFn

		printColors: (opts) =>
			colors = { blue: 'Blue', red: 'Red', green: 'Green', yellow: 'Yellow' }
			buffer = ''
			for id, color of colors
				buffer += opts.fn {
					id: id
					color: color
					selected: if @model.get('task')?.get('color') is id then ' SELECTED' else ''
				}
			return buffer
