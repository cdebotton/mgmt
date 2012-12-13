define ['backbone', 'underscore', 'ns', 'dropdown'], (Backbone, _, namespace) ->

	namespace 'BU.View.CreatePalette'

	class BU.View.CreatePalette extends Backbone.View
		el: '#task-create-palette'

		events:
			'click input':					'stopPropagation'
			'click button':					'stopPropagation'
			'click button[type="submit"]':	'createTask'
			'blur .day-field':				'checkDayRange'
			'blur .month-field':			'checkMonthRange'
			'blur .year-field':				'checkYearRange'

		initialize: ->

		createTask: (e) =>
			e.preventDefault()
			$author		= 	@$ '[name="author_id"]'
			$name		= 	@$ '[name="name"]'
			$client		= 	@$ '[name="client"]'
			$code		= 	@$ '[name="project_code"]'
			$smonth		= 	@$ '[name="start_month"]'
			$sday		= 	@$ '[name="start_day"]'
			$syear		= 	@$ '[name="start_year"]'
			$emonth		= 	@$ '[name="end_month"]'
			$eday		= 	@$ '[name="end_day"]'
			$eyear		= 	@$ '[name="end_year"]'
			$dev 		= 	@$ '[name="developer_id"]'
			$color		= 	@$ '[name="color"]'
			dev_id 		= 	$dev.val()	
			if (key = _.indexOf @model.get('users').pluck('id'), dev_id) > -1
				@model.get('users').at(key).get('tasks').create {
					author_id:		$author.val()
					name:			$name.val()
					client:			$client.val()
					project_code:	$code.val()
					start_date:		new Date $syear.val(), $smonth.val()-1, $sday.val()
					end_date:		new Date $eyear.val(), $emonth.val()-1, $eday.val()
					developer_id:	dev_id
					color:			$color.val()
				}
			e.preventDefault()

		checkDayRange: (e) ->
			int = parseInt e.currentTarget.value
			if int < 1 then int = 1
			else if int > 31 then int = 31
			else if isNaN int then int = (new Date()).getDate()
			e.currentTarget.value = int

		checkMonthRange: (e) ->
			int = parseInt e.currentTarget.value
			if int < 1 then int = 1
			else if int > 12 then int = 12
			else if isNaN int then int = (new Date()).getMonth() + 1
			e.currentTarget.value = int

		checkYearRange: (e) ->
			int = parseInt e.currentTarget.value
			currentYear = (new Date()).getFullYear()
			limYear = currentYear + 10
			minYear = currentYear - 10
			if int > limYear then int = limYear
			else if int < minYear then int = minYear
			else if isNaN int then int = currentYear
			e.currentTarget.value = int

		stopPropagation: (e) =>
			e.stopPropagation()