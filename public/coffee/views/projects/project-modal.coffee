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
			'click .icon-remove':				'closeModal'
			'click button[type="submit"]':		'saveProject'
			'keyup input[name="name"]':			'setName'
			'keyup input[name="code"]':			'setCode'
			'keyup input[name="client"]':		'setClient'

		render: ->
			@body = $ 'body'
			ctx = @model.get('project').toJSON()
			html = United.JST.EditProjectModal ctx
			@$el.html html
			@expose()
			@

		setName: (e) =>
			@model.get('project').set 'name', e.currentTarget.value

		setCode: (e) =>
			@model.get('project').set 'code', e.currentTarget.value
			console.log @model.toJSON()

		setClient: (e) =>
			@model.get('project').set 'name', e.currentTarget.value

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
			@tasks = new United.Views.Projects.TaskEditor
				model: @model

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