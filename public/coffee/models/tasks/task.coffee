define [
	'backbone'
	'underscore'
	'ns'
	'relational'
	'models/projects/project'
], (Backbone, _, ns) ->
	
	ns 'United.Models.Tasks.Task'

	class United.Models.Tasks.Task extends Backbone.RelationalModel
		relations: [{
			type:				Backbone.HasOne
			relatedModel:		United.Models.Projects.Project
			key:				'project'
			reverseRelation:
				type:			Backbone.HasMany
				key:			'task'
				includeInJSON:	'id'
		}]

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