define (require, exports, module) ->

	ns			= require 'ns'
	handlebars	= require 'handlebars'
	_ 			= require 'underscore'

	ns 'United.JST'
	United.JST =
		### Modules ###
		Hb:						Handlebars

		### Widgets ###
		OptionModal:			Handlebars.compile require 'text!templates/option-modal.html'

		### Schedule Timeline ###
		UserBadge:				Handlebars.compile require 'text!templates/user-badge.html'
		UserTimeline:			Handlebars.compile require 'text!templates/user-timeline.html'
		GraphTimeline:			Handlebars.compile require 'text!templates/graph-timeline.html'
		TaskElement:			Handlebars.compile require 'text!templates/task-element.html'
		EditModal:				Handlebars.compile require 'text!templates/edit-modal.html'
		Overage:				Handlebars.compile require 'text!templates/overage.html'

		### Project Management ###
		ProjectDrawer:			Handlebars.compile require 'text!templates/edit-project-drawer.html'
		ProjectTaskDrawer:		Handlebars.compile require 'text!templates/edit-project-task-drawer.html'
		ProjectItem:			Handlebars.compile require 'text!templates/project-item.html'

		### Dashboard ###
		UserCalendar:			Handlebars.compile require 'text!templates/user-calendar.html'

		### Paid Day Off Management ###
		PdoRequest:				Handlebars.compile require 'text!templates/pdo-request.html'
		PdoRequestListItem:		Handlebars.compile require 'text!templates/pdo-request-list-item.html'
		RequestOverviewItem:	Handlebars.compile require 'text!templates/request-overview-item.html'
		PdoElement:				Handlebars.compile require 'text!templates/pdo-element.html'

		### User Management ###
		UserItem:				Handlebars.compile require 'text!templates/user-item.html'
		UserEdit:				Handlebars.compile require 'text!templates/user-edit.html'
