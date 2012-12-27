// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'underscore', 'jquery', 'ns', 'jst', 'views/tasks/task-element', 'views/tasks/overage'], function(Backbone, _, $, ns) {
    ns('United.Views.Tasks.UserTimeline');
    return United.Views.Tasks.UserTimeline = (function(_super) {
      var DRAGGING;

      __extends(UserTimeline, _super);

      function UserTimeline() {
        this.stopDrag = __bind(this.stopDrag, this);

        this.onDrag = __bind(this.onDrag, this);

        this.startDrag = __bind(this.startDrag, this);

        this.addOne = __bind(this.addOne, this);

        this.mouseout = __bind(this.mouseout, this);
        return UserTimeline.__super__.constructor.apply(this, arguments);
      }

      UserTimeline.prototype.tagName = 'article';

      UserTimeline.prototype.className = 'timeline-object';

      UserTimeline.prototype.overages = [];

      DRAGGING = false;

      UserTimeline.prototype.OFFSET = 0;

      UserTimeline.prototype.events = {
        'mousedown': 'startDrag'
      };

      UserTimeline.prototype.initialize = function() {
        this.body = $('body');
        return this.startListening();
      };

      UserTimeline.prototype.startListening = function() {
        if (United.Models.Users.Session.isAdmin()) {
          United.EventBus.on('percentage-points-calculated', this.drawRanges, this);
          United.EventBus.on('percentage-changed', this.calculateOverages, this);
          this.model.get('tasks').on('change:start_date change:end_date change:user change:percentage', this.calculateOverages, this);
          United.EventBus.on('zoom-grid-updated', this.calculateOverages, this);
        }
        document.addEventListener('mouseout', this.mouseout, false);
        United.EventBus.on('task-added', this.taskCreated, this);
        this.model.on('add:tasks', this.addOne, this);
        this.model.on('reset:tasks remove:tasks', this.addAll, this);
        return this.model.get('tasks').on('change:track', this.adjustHeight, this);
      };

      UserTimeline.prototype.stopListening = function() {
        if (United.Models.Users.Session.isAdmin()) {
          United.EventBus.off('percentage-points-calculated', this.drawRanges, this);
          United.EventBus.off('zoom-grid-updated', this.calculateOverages, this);
          United.EventBus.off('percentage-changed', this.calculateOverages, this);
          this.model.get('tasks').off('change:start_date change:end_date change:user change:percentage', this.calculateOverages, this);
        }
        document.removeEventListener('mouseout', this.mouseout, false);
        United.EventBus.off('task-added', this.taskCreated, this);
        this.model.off('add:tasks', this.addOne, this);
        this.model.off('reset:tasks remove:tasks', this.addAll, this);
        return this.model.get('tasks').off('change:track', this.adjustHeight, this);
      };

      UserTimeline.prototype.mouseout = function(e) {
        var from;
        if (DRAGGING) {
          from = e.relatedTarget || e.toElement;
          if (!from || from.nodeName === 'HTML') {
            return this.stopDrag(e);
          }
        }
      };

      UserTimeline.prototype.render = function() {
        var ctx, html;
        ctx = this.model.toJSON();
        html = United.JST['UserTimeline'](ctx);
        this.$el.html(html);
        this.addAll();
        this.adjustHeight();
        if (United.Models.Users.Session.isAdmin()) {
          this.calculateOverages();
        }
        return this;
      };

      UserTimeline.prototype.calculateOverages = function() {
        var date, dates, endpoint, ends, i, k, range, ranges, startpoint, starts, task, taskend, tasks, taskstart, totalPercentage, _i, _j, _k, _len, _len1, _ref;
        tasks = this.model.get('tasks');
        starts = tasks.pluck('start_date');
        ends = tasks.pluck('end_date');
        ranges = [];
        dates = _.uniq(starts.concat(ends).sort(function(a, b) {
          return a - b;
        }), true, function(date, index, array) {
          return date.getTime();
        });
        for (i = _i = 0, _len = dates.length; _i < _len; i = ++_i) {
          date = dates[i];
          if (i < dates.length - 1) {
            ranges.push([date, dates[i + 1]]);
          }
        }
        for (i = _j = 0, _len1 = ranges.length; _j < _len1; i = ++_j) {
          range = ranges[i];
          startpoint = range[0];
          endpoint = range[1];
          totalPercentage = 0;
          for (k = _k = 0, _ref = tasks.length; 0 <= _ref ? _k < _ref : _k > _ref; k = 0 <= _ref ? ++_k : --_k) {
            task = tasks.at(k);
            taskstart = task.get('start_date');
            taskend = task.get('end_date');
            if ((startpoint < taskend) && (endpoint > taskstart)) {
              totalPercentage += +task.get('percentage');
            }
          }
          range.push(totalPercentage);
        }
        return United.EventBus.trigger('plot-ranges', ranges, this.cid);
      };

      UserTimeline.prototype.drawRanges = function(response, caller) {
        var html, range, view, _i, _len, _results;
        if (caller !== this.cid) {
          return;
        }
        _.each(this.overages, function(range) {
          return range.clear();
        });
        this.overages = [];
        _results = [];
        for (_i = 0, _len = response.length; _i < _len; _i++) {
          range = response[_i];
          view = new United.Views.Tasks.Overage({
            model: new Backbone.Model(range)
          });
          html = view.render().$el;
          this.overages.push(view);
          _results.push(this.$el.append(html));
        }
        return _results;
      };

      UserTimeline.prototype.taskCreated = function(task, userId) {
        if (userId === this.model.get('id')) {
          return this.addOne(task);
        }
      };

      UserTimeline.prototype.addOne = function(task) {
        var html, view;
        view = new United.Views.Tasks.TaskElement({
          model: task
        });
        html = view.render().$el;
        return this.$el.append(html);
      };

      UserTimeline.prototype.addAll = function() {
        this.$el.html('');
        return this.model.get('tasks').each(this.addOne);
      };

      UserTimeline.prototype.adjustHeight = function(model, value, status) {
        var highest, _ref;
        highest = (_ref = this.model.get('tasks').max(function(task) {
          return +task.get('track');
        })) != null ? _ref.get('track') : void 0;
        if (highest > 2) {
          return this.$el.css('height', (highest * 60) + 65);
        } else {
          return this.$el.css('height', 185);
        }
      };

      UserTimeline.prototype.startDrag = function(e) {
        this.body.on('mousemove', this.onDrag);
        this.body.on('mouseup', this.stopDrag);
        this.XHOME = e.originalEvent.clientX;
        DRAGGING = true;
        e.stopPropagation();
        return e.preventDefault();
      };

      UserTimeline.prototype.onDrag = function(e) {
        var nextDx, values;
        if (!DRAGGING) {
          return false;
        }
        e.stopPropagation();
        nextDx = this.XHOME - e.originalEvent.clientX;
        this.OFFSET += parseInt(nextDx * 1.75);
        this.XHOME = e.originalEvent.clientX;
        values = ["" + this.OFFSET + "px", 0, 0].join(', ');
        United.EventBus.trigger('offset-timeline-from-user-timeline', values);
        return e.preventDefault();
      };

      UserTimeline.prototype.stopDrag = function(e) {
        this.body.off('mousemove', this.onDrag);
        this.body.off('mouseup', this.stopDrag);
        DRAGGING = false;
        this.XHOME = 0;
        return e.preventDefault();
      };

      return UserTimeline;

    })(Backbone.View);
  });

}).call(this);
