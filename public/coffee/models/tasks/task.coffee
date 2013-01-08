define [
	'backbone'
	'underscore'
	'ns'
	'relational'
], (Backbone, _, ns) ->

	d = new Date()
	t = new Date d.getFullYear(), d.getMonth(), d.getDate(), 0, 0, 0
	n = new Date d.getFullYear(), d.getMonth(), d.getDate(), 0, 0, 0
	n.setDate n.getDate() + 14

	ns 'United.Models.Tasks.Task'
	class United.Models.Tasks.Task extends Backbone.RelationalModel
		defaults: {
			name:			'New Task'
			start_date:		t
			end_date:		n
			color:			null
			author_id:		window.author_id
			percentage:		0
		}

		url: -> "/api/v1/schedules" + if not @isNew() then "/update/#{@get 'id'}" else ''

		initialize: ->
			@on 'change:user', @locateTrack, @
			@locateTrack() unless not @isNew()

		findConflicts: (attrs, status) ->
			conflicts = @get?('user')?.get?('tasks')?.filter (task) =>
				startpoint = attrs.start_date
				endpoint = attrs.end_date
				taskstart = task.get 'start_date'
				taskend = task.get 'end_date'
				foreign = task.cid isnt @cid
				adjacent = +task.get('track') is +attrs.track
				crash = (startpoint < taskend) and (endpoint > taskstart)
				foreign and adjacent and crash

		validate: (attrs, status) ->
			if status?.silent isnt true
				conflicts = @findConflicts attrs, status
				if conflicts?.length > 0 then return 'Collision conflict.'
				if attrs.track < 0 then return 'Track error.'

		parse: =>
			@attributes?['start_date'] = new Date @attributes?['start_date']
			@attributes?['start_date'].setHours 0
			@attributes?['start_date'].setMinutes 0
			@attributes?['start_date'].setSeconds 0
			@attributes?['end_date'] = new Date @attributes?['end_date']
			@attributes?['end_date'].setHours 0
			@attributes?['end_date'].setMinutes 0
			@attributes?['end_date'].setSeconds 0
			@attributes?['track'] = parseInt @attributes['track']

		locateTrack: ->
			track = 0
			conflicts = true
			while conflicts is true and track < 1000
				fakeAttrs = _.extend {}, @attributes, { track: track }
				if (conflicts = @findConflicts(fakeAttrs)?.length > 0)
					track++
			@set 'track', track
			@

		comparator: (task) -> task.get('start_date')

	United.Models.Tasks.Task.setup()
