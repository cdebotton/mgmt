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
		Hb:					Handlebars
		UserBadge:			Handlebars.compile UserBadge
		UserTimeline:		Handlebars.compile UserTimeline
		GraphTimeline:		Handlebars.compile GraphTimeline
		TaskElement:		Handlebars.compile TaskElement
		EditModal:			Handlebars.compile EditModal
		ProjectDrawer:		Handlebars.compile ProjectDrawer
		Overage:			Handlebars.compile OverageTemplate
		UserCalendar:		Handlebars.compile UserCalendar
		ProjectTaskDrawer:	Handlebars.compile ProjectTaskDrawer