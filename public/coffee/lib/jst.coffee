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
], (namespace, Handlebars, _, UserBadge, UserTimeline, GraphTimeline, TaskElement, EditModal, OverageTemplate) ->

	namespace 'BU.JST'
	BU.JST =
		Hb:				Handlebars
		UserBadge:		Handlebars.compile UserBadge
		UserTimeline:	Handlebars.compile UserTimeline
		GraphTimeline:	Handlebars.compile GraphTimeline
		TaskElement:	Handlebars.compile TaskElement
		EditModal:		Handlebars.compile EditModal
		Overage:		Handlebars.compile OverageTemplate