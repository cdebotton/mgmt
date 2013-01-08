define [
	'backbone'
	'ns'
	'views/widgets/livesearch-list'
], (Backbone, ns) ->

	ns 'United.Views.Widgets.LiveSearchInput'
	class United.Views.Widgets.LiveSearchInput extends Backbone.View
			LIST_VISIBLE = false
			events:
				'keydown':		'keyDown'
				'keypress':		'keyPress'
				'keyup':		'keyUp'

			initialize: ->

			keyDown: (e) =>
				@suppressKeyPressRepeat = _.indexOf([40,38,9,13,27], e.keyCode) > 0
				@move e

			keyPress: (e) =>
				if @suppressKeyPressRepeat then return
				@move e

			keyUp: (e) =>
				switch(e.keyCode)
					when 40 then break					# down arrow
					when 38 then break					# up arrow
					when 16 then break					# shift
					when 17 then break					# ctrl
					when 18 then break					# alt
					when 9								# tab
						if not LIST_VISIBLE then return
						@select()
					when 13								#enter
						if not LIST_VISIBLE then return
						@select()						# enter
					when 27								# escape
						if not LIST_VISIBLE then return
						@hide()
					else @lookup()
				e.stopPropagation()
				e.preventDefault()

			select: ->

			lookup: ->

			hide: ->

			move: (e) =>
				if not LIST_VISIBLE then return false
				switch e.keyCode
					when 9 then e.preventDefault()		#tab
					when 13 then e.preventDefault()		#enter
					when 27 then e.preventDefault()		#escape
					when 38								#up
						e.preventDefault()
						@previous()
					when 40
						e.preventDefault()
						@next()
				e.stopPropagation()

			previous: ->

			next: ->
