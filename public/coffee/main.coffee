requirejs.config
	locale: 'en-us'
	urlArgs: "xcache=#{(new Date()).getTime()}"
	baseUrl: '/js'
	paths:
		jquery:		'vendors/jquery/jquery'
		backbone:		'vendors/backbone/backbone'
		relational:	'vendors/backbone/backbone.relational'
		underscore:	'vendors/underscore/underscore'
		handlebars:	'vendors/handlebars/handlebars'
		modernizr:	'vendors/modernizr/modernizr'
		mousetrap:	'vendors/mousetrap/mousetrap'
		text:			'vendors/requirejs/text'
		raphael:		'vendors/raphael/raphael'
		morris:		'vendors/morris/morris'
		templates:	'../handlebars'
		ns:			'lib/ns'
		jst:			'lib/jst'
		animate:		'vendors/jquery/jquery.animate-enhanced'
		affix:		'vendors/bootstrap/bootstrap-affix'
		alert:		'vendors/bootstrap/bootstrap-alert'
		button:		'vendors/bootstrap/bootstrap-button'
		carousel:		'vendors/bootstrap/bootstrap-carousel'
		dropdown:		'vendors/bootstrap/bootstrap-dropdown'
		modal:		'vendors/bootstrap/bootstrap-modal'
		popover:		'vendors/bootstrap/bootstrap-popover'
		scrollspy:	'vendors/bootstrap/bootstrap-scrollspy'
		tab:			'vendors/bootstrap/bootstrap-tab'
		tooltip:		'vendors/bootstrap/bootstrap-tooltip'
		transition:	'vendors/bootstrap/bootstrap-transition'
		typeahead:	'vendors/bootstrap/bootstrap-typeahead'
		mousetrap:	'vendors/mousetrap/mousetrap'
	shim:
		backbone:
			deps: ['jquery', 'underscore']
			exports: 'Backbone'
			init: -> Backbone.noConflict()
		relational:
			deps: ['backbone']
			exports: 'Backbone.RelationalModel'
			init: (Backbone) -> Backbone.noConflict()
		jquery:
			exports: '$'
			init: -> $.noConflict()
		underscore:
			exports: '_'
			init: -> _.noConflict()
		handlebars:
			exports: 'Handlebars'
		animate:
			deps: ['jquery']
			exports: '$.fn.animate'
		mousetrap:
			exports: 'Mousetrap'
		raphael:
			exports: 'Raphael'
		morris:
			deps: ['raphael', 'jquery']
			exports: 'Morris'
		affix:
			deps: ['jquery']
		alert:
			deps: ['jquery']
		button:
			deps: ['jquery']
		carousel:
			deps: ['jquery']
		dropdown:
			deps: ['jquery']
		modal:
			deps: ['jquery']
		popover:
			deps: ['jquery']
		scrollspy:
			deps: ['jquery']
		tab:
			deps: ['jquery']
		tooltip:
			deps: ['jquery']
		transition:
			deps: ['jquery']
		typeahead:
			deps: ['jquery']

require ['views/app', 'models/app'], ->
	for key, user of window.users
		for key2, task of user.tasks
			task.start_date = new Date task.start_date
			task.start_date.setHours 0, 0, 0, 0
			task.end_date = new Date task.end_date
			task.end_date.setHours 0, 0, 0, 0
			task.track = task.pivot.track
			task.percentage = task.pivot.percentage
			delete task.pivot

	window.BUScheduler = new United.Views.App
		model: new United.Models.App
			users: window.users
			controller: window.controller