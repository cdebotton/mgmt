define [
	'backbone'
	'ns'
	'jst'
	'animate'
], (Backbone, ns) ->

	ns 'United.Views.Users.UserEdit'
	class United.Views.Users.UserEdit extends Backbone.View
		el: '#user-drawer'

		MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']

		events:
			'keyup [name="first-name"]':		'updateFirstName'
			'keyup [name="last-name"]':			'updateLastName'
			'keyup [name="email"]':				'updateEmail'
			'keyup [name="hired-on-month"]':	'updateHiredOnMonth'
			'keyup [name="hired-on-day"]':		'updateHiredOnDay'
			'keyup [name="hired-on-year"]':		'updateHiredOnYear'
			'keyup [name="pdo"]':				'updatePdo'
			'keyup [name="password"]':			'updatePassword'
			'keyup [name="confrim-password"]':	'updateConfirmPassword'
			'click #save-user':					'saveUser'
			'click #cancel-user':				'cancelUser'
			'click .icon-remove':				'close'

		initialize: ->
			United.JST.Hb.registerHelper 'printLogin', @printLogin
			@model.on 'change:first_name change:last_name', @updateTitle, @

		updateFirstName: (e) =>
			@model.set 'first_name', e.currentTarget.value

		updateLastName: (e) =>
			@model.set 'last_name', e.currentTarget.value

		updateEmail: (e) =>
			@model.set 'email', e.currentTarget.value

		updateHiredOnMonth: (e) =>
			v = parseInt e.currentTarget.value
			if 0 < v < 13
				d = new Date @model.get 'hired_on'
				d.setMonth v - 1
				@model.set 'hired_on', d

		updateHiredOnDay: (e) =>
			v = parseInt e.currentTarget.value
			if 0 < v < 32
				d = new Date @model.get 'hired_on'
				d.setDate v
				@model.set 'hired_on', d

		updateHiredOnYear: (e) =>
			v = e.currentTarget.value
			if v.match /^\d{4}$/
				v = parseInt v
				d = new Date @model.get 'hired_on'
				d.setYear parseInt e.currentTarget.value
				@model.set 'hired_on', d

		updatePdo: (e) =>
			@model.set 'pdo_allotment', e.currentTarget.value

		updatePassword: (e) =>

		updateConfirmPassword: (e) =>

		updateTitle: (model, value, status) ->
			@title.html "#{@model.get 'first_name'} #{@model.get 'last_name'}"

		saveUser: (e) =>
			e.preventDefault()

		cancelUser: (e) =>
			@model.fetch
				wait: true
				success: () => @close e
			e.preventDefault()

		render: ->
			ctx = @model.toJSON()
			ctx.hired_on_month = parseInt(ctx.hired_on.getMonth()) + 1
			ctx.hired_on_day = ctx.hired_on.getDate()
			ctx.hired_on_year = ctx.hired_on.getFullYear()
			html = United.JST.UserEdit ctx
			@$el.html html
			@title = @$ '#username'
			if @options.open is false
				h = @$el.innerHeight() + 10
				@$el.css({
					marginTop: -h
					display: 'block'
				}).animate {
					marginTop: 0
				}, '175', 'ease-out'
			@

		close: (e) =>
			h = @$el.innerHeight() + 10
			@$el.animate {
				marginTop: -h
			}, '175', 'ease-in', () =>
				United.EventBus.trigger 'user-edit-closed'
				@$el.html ''
				@$el.css {
					marginTop: 0
					display: 'none'
				}
			e.preventDefault()

		printLogin: (d, name) ->
			if isNaN d.getTime()
				return "#{name} has never logged in."
			else
				h = d.getHours()
				if h < 10 then h = "0#{h}"
				m = d.getMinutes()
				if m < 10 then m = "0#{m}"
				return "<strong>Last seen</strong> #{MONTHS[d.getMonth()]} #{d.getDate()}, #{d.getFullYear()} at #{h}:#{m}"

