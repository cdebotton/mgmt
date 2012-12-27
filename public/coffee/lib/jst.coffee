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
	'text!templates/edit-project-modal.html'
], (ns, Handlebars, _, UserBadge, UserTimeline, GraphTimeline, TaskElement, EditModal, OverageTemplate, UserCalendar, EditProjectModal) ->

	ns 'United.JST'
	United.JST =
		Hb:					Handlebars
		UserBadge:			Handlebars.compile UserBadge
		UserTimeline:		Handlebars.compile UserTimeline
		GraphTimeline:		Handlebars.compile GraphTimeline
		TaskElement:		Handlebars.compile TaskElement
		EditModal:			Handlebars.compile EditModal
		EditProjectModal:	Handlebars.compile	EditProjectModal
		Overage:			Handlebars.compile OverageTemplate
		UserCalendar:		Handlebars.compile UserCalendar