define [
	'backbone'
	'underscore'
	'ns'
	'relational',
	'models/pivot'
], (Backbone, _, namespace) ->
	
	namespace 'BU.Model.Task'

	class BU.Model.Task extends Backbone.RelationalModel
		relations: [{
			type:				Backbone.HasOne
			relatedModel:		BU.Model.Pivot
			key:				'pivot'
			reverseRelation:
				includeInJSON:	'id'
				key:			'task'
		}]
		defaults:
			start_date: new Date
			end_date: new Date
			color: 'blue'

		initialize: ->
			@on 'change:start_date', @adjustDate, @
			@on 'change:end_date', @adjustDate, @
			@on 'change:track', @fixTrack, @
			@on 'change:developer_id', @locateTrack, @
			@fixTrack()

		findConflicts: (attrs, status) ->
			conflicts = @get('user')?.get('tasks').filter (task) ->
				task.get('id') isnt attrs.id and
				task.get('track') is attrs.track and
				((task.get('start_date') < attrs.start_date < task.get('end_date')) or
					(task.get('start_date') < attrs.end_date < task.get('end_date') or
					(attrs.start_date < task.get('start_date') < attrs.end_date) or
					(attrs.start_date < task.get('end_date') < attrs.end_date) or
					task.get('start_date').toString() is attrs.start_date.toString()) or
					task.get('end_date').toString() is attrs.end_date.toString())

		validate: (attrs, status) ->
			conflicts = @findConflicts attrs, status
			if conflicts?.length > 0 then return 'Collision conflict.'
			if attrs.track < 0 then return 'Track error.'

		adjustDate: (model, value, status) ->
			for key, changed of status.changes
				if changed is true
					date = @get key
					if date instanceof Date
						date.setHours '00'
						date.setMinutes '00'
						@attributes[key] = date

		fixTrack: -> @set 'track', parseInt @get 'track'

		url: -> "/admin/api/v1/tasks" + if not @isNew() then "/update/#{@get 'id'}" else ''

		parse: =>
			@attributes?['start_date'] = new Date @attributes?['start_date']
			@attributes?['start_date'].setHours 0
			@attributes?['start_date'].setMinutes 0
			@attributes?['start_date'].setSeconds 0
			@attributes?['end_date'] = new Date @attributes?['end_date']
			@attributes?['end_date'].setHours 0
			@attributes?['end_date'].setMinutes 0
			@attributes?['end_date'].setSeconds 0

		locateTrack: () ->
			#developer = @get('user').get('app').get('users').where({ id: @get 'developer_id' })[0]
			@set 'user', @get 'developer_id'
			track = 0
			conflicts = true
			while conflicts is true and track < 10
				fakeAttrs = _.extend {}, @attributes, { track: track }
				if (conflicts = @findConflicts(fakeAttrs)?.length > 0)
					track++
			@set 'track', track

	BU.Model.Task.setup()