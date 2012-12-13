define [
	'backbone'
	'ns'
	'jquery'
	'jst'
	'animate'
], (Backbone, ns, $) ->

	ns 'BU.View.EditModal'
	class BU.View.EditModal extends Backbone.View
		tagName:	'section'
		
		className:	'striped-cheech'
		
		events:
			'click .icon-remove':			'closeModal'
			'click button[type="submit"]':	'saveTask'

		initialize: ->
			BU.JST.Hb.registerHelper 'printUsers', @printUsers
			BU.JST.Hb.registerHelper 'printColors', @printColors

		render: ->
			ctx = @model.toJSON()
			ctx.user_list = window.users
			ctx.start_month = @model.get('start_date').getMonth() + 1
			ctx.start_day = @model.get('start_date').getDate()
			ctx.start_year = @model.get('start_date').getFullYear()
			ctx.end_month = @model.get('end_date').getMonth() + 1
			ctx.end_day = @model.get('end_date').getDate()
			ctx.end_year = @model.get('end_date').getFullYear()
			html = BU.JST.EditModal ctx
			@$el.html html
			@expose()
			@

		expose: () ->
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
			e.preventDefault()

		saveTask: (e) =>
			@model.set
				'author_id':		window.author_id
				'name':				@$('[name="name"]').val()
				'project_code':		@$('[name="project_code"]').val()
				'client':			@$('[name="client"]').val()
				'start_date':		new Date @$('[name="start_year"]').val(), parseInt(@$('[name="start_month"]').val()) - 1, @$('[name="start_day"]').val()
				'end_date':			new Date @$('[name="end_year"]').val(), parseInt(@$('[name="end_month"]').val()) - 1, @$('[name="end_day"]').val()
				'developer_id':		@$('[name="developer_id"]').val()
				'color':			@$('[name="color"]').val()
			
			@model.get('pivot').set 'percentage', $('[name="percentage"]').val()
			@model.save()
			@closeModal e

		printUsers: (array, opts) =>
			if array?.length
				buffer = ''
				for user, key in array
					item = {
						id: user.id
						email: user.email
						selected: if @model.has('user') and +user.id is +@model.get('user').get('id') then ' SELECTED' else ''
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
					selected: if @model.get('color') is id then ' SELECTED' else ''
				}
			return buffer
