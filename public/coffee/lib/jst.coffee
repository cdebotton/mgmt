define [
	'ns'
	'handlebars'
	'underscore'
	'text!templates/user-badge.html'
	'text!templates/user-timeline.html'
	'text!templates/graph-timeline.html'
	'text!templates/task-element.html'
	'text!templates/edit-modal.html'
	'text!templates/overage.html'
	'text!templates/user-calendar.html'
	'text!templates/edit-project-drawer.html'
	'text!templates/edit-project-task-drawer.html'
], (ns, Handlebars, _, UserBadge, UserTimeline, GraphTimeline, TaskElement, EditModal, OverageTemplate, UserCalendar, ProjectDrawer, ProjectTaskDrawer) ->

	ns 'United.JST'
	United.JST =
		### Modules ###
		Hb:					Handlebars

		### Schedule Timeline ###
		UserBadge:			Handlebars.compile UserBadge
		UserTimeline:		Handlebars.compile UserTimeline
		GraphTimeline:		Handlebars.compile GraphTimeline
		TaskElement:		Handlebars.compile TaskElement
		EditModal:			Handlebars.compile EditModal
		Overage:			Handlebars.compile OverageTemplate

		### Project Management ###
		ProjectDrawer:		Handlebars.compile ProjectDrawer
		ProjectTaskDrawer:	Handlebars.compile ProjectTaskDrawer

		### Dashboard ###
		UserCalendar:		Handlebars.compile UserCalendar

		### Paid Day Off Management ###
		### User Management ###