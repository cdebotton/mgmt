define [
	'backbone'
	'jquery'
	'ns'
	'jst'
	'animate'
	'views/projects/task-editor'
], (Backbone, $, ns) ->

	ns 'United.Views.Projects.ProjectModal'
	class United.Views.Projects.ProjectModal extends Backbone.View
		tagName:	'section'
		
		className:	'striped-cheech'
		
		events:
			'click .icon-remove':			'closeModal'
			'click button[type="submit"]':	'saveProject'

		render: ->
			@body = $ 'body'
			ctx = {}
			html = United.JST.EditProjectModal ctx
			@$el.html html
			@tasks = new United.Views.Projects.TaskEditor
				model: @model
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
			}, => @$el.animate { opacity: 0 }, =>
				@tasks.remove()
				@$el.remove()
			@body.unbind 'keyup', @bindEscape
			United.EventBus.trigger 'modal-closed'
			e.preventDefault()

		bindEscape: (e) => if e.keyCode is 27 then @closeModal e

		saveProject: (e) =>