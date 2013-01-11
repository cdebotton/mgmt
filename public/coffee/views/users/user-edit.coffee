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

		updateHiredOnDay: (e) =>

		updateHiredOnYear: (e) =>

		updatePdo: (e) =>
			@model.set 'pdo_allotment', e.currentTarget.value

		updatePassword: (e) =>

		updateConfirmPassword: (e) =>

		updateTitle: (model, value, status) ->
			@title.html "#{@model.get 'first_name'} #{@model.get 'last_name'}"
			console.log @title.html()

		saveUser: (e) =>
			e.preventDefault()

		cancelUser: (e) =>
			e.preventDefault()

		render: ->
			ctx = @model.toJSON()
			hired = new Date ctx.hired_on
			ctx.hired_on_month = parseInt(hired.getMonth()) + 1
			ctx.hired_on_day = hired.getDate()
			ctx.hired_on_year = hired.getFullYear()
			html = United.JST.UserEdit ctx
			@$el.html html
			@title = @$ '#username'
			h = @$el.innerHeight() + 10
			@$el.css({
				marginTop: -h
				display: 'block'
			}).animate {
				marginTop: 0
			}, '175', 'ease-out'
			@

		printLogin: (login, name) ->
			d = new Date login
			if login.match /^0000/
				return "#{name} has never logged in."
			else
				h = d.getHours()
				if h < 10 then h = "0#{h}"
				m = d.getMinutes()
				if m < 10 then m = "0#{m}"
				return "<strong>Last seen</strong> #{MONTHS[d.getMonth()]} #{d.getDate()}, #{d.getFullYear()} at #{h}:#{m}"

