// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'jquery', 'underscore', 'ns', 'mousetrap', 'views/tasks/profile-palette', 'views/tasks/task-timeline', 'views/tasks/graph-timeline', 'views/tasks/date-guides', 'views/tasks/edit-task', 'models/tasks/task', 'views/tasks/scale-controller', 'models/tasks/scale-controller', 'views/tasks/graph-filters', 'models/tasks/graph-filters', 'views/tasks/view-selector', 'models/tasks/view-selector', 'views/tasks/calendar'], function(Backbone, $, _, ns, Mousetrap) {
    ns('United.Views.Tasks.ScheduleManager');
    return United.Views.Tasks.ScheduleManager = (function(_super) {
      var MODAL_OPEN;

      __extends(ScheduleManager, _super);

      function ScheduleManager() {
        this.openModal = __bind(this.openModal, this);

        this.createNewTask = __bind(this.createNewTask, this);

        this.adjust = __bind(this.adjust, this);

        this.affix = __bind(this.affix, this);
        return ScheduleManager.__super__.constructor.apply(this, arguments);
      }

      ScheduleManager.prototype.el = '#schedule-viewport';

      MODAL_OPEN = false;

      ScheduleManager.prototype.events = {
        'selectstart': 'disableSelection',
        'click #new-task-toggle': 'createNewTask'
      };

      ScheduleManager.prototype.initialize = function() {
        var _this = this;
        Mousetrap.bind(['ctrl+shift+n', 'ctrl+shift+alt+n'], function() {
          return _this.openModal();
        });
        United.EventBus.on('modal-closed', this.modalClosed, this);
        United.EventBus.on('open-modal', this.openModal, this);
        United.EventBus.on('set-view', this.setView, this);
        this.model.get('users').add({
          roles: [],
          disciplines: [],
          first_name: 'Unassigned',
          last_name: 'Tasks',
          unassigned: true,
          tasks: new United.Collections.Tasks.Tasks(window.unassignedTasks)
        });
        United.Models.Users.Session = this.model.get('session');
        this.window = $(window);
        this.header = this.$('.navbar');
        this.dy = this.$el.offset().top;
        this.window.on('scroll', this.affix);
        this.window.on('resize', this.adjust);
        this.sub_views = _.extend({}, {
          graphFilters: new United.Views.Tasks.GraphFilters({
            model: new United.Models.Tasks.GraphFilters
          }),
          viewSelector: new United.Views.Tasks.ViewSelector({
            model: new United.Models.Tasks.ViewSelector
          }),
          scaleController: new United.Views.Tasks.ScaleController({
            model: new United.Models.Tasks.ScaleController
          })
        });
        this.task_views = _.extend({}, {
          graphTimeline: new United.Views.Tasks.GraphTimeline({
            model: this.model
          }),
          profilePalette: new United.Views.Tasks.ProfilePalette({
            model: this.model
          }),
          taskTimeline: new United.Views.Tasks.TaskTimeline({
            model: this.model
          })
        });
        this.calendar_views = _.extend({}, {
          calendarView: new United.Views.Tasks.CalendarView({
            model: this.model
          })
        });
        this.adjust();
        return this.sub_views.viewSelector.model.set('currentView', 'task');
      };

      ScheduleManager.prototype.disableSelection = function(e) {
        return e.preventDefault();
      };

      ScheduleManager.prototype.affix = function(e) {
        var scrollTop;
        scrollTop = this.window.scrollTop();
        United.EventBus.trigger('on-scroll', scrollTop);
        if (scrollTop > this.dy) {
          this.header.addClass('affix');
          return United.EventBus.trigger('nav-affix', true);
        } else {
          this.header.removeClass('affix');
          return United.EventBus.trigger('nav-affix', false);
        }
      };

      ScheduleManager.prototype.adjust = function(e) {
        var h, w;
        w = this.window.width();
        h = this.window.height();
        return United.EventBus.trigger('adjust', w, h);
      };

      ScheduleManager.prototype.createNewTask = function(e) {
        this.openModal(new United.Models.Tasks.Task);
        return e.preventDefault();
      };

      ScheduleManager.prototype.openModal = function(task) {
        if (!United.Models.Users.Session.isAdmin()) {
          return false;
        }
        if (MODAL_OPEN) {
          return false;
        }
        MODAL_OPEN = true;
        this.modal = new United.Views.Tasks.EditTask({
          model: task
        });
        this.$el.append(this.modal.render().$el);
        this.modal.expose();
        return false;
      };

      ScheduleManager.prototype.modalClosed = function() {
        return MODAL_OPEN = false;
      };

      ScheduleManager.prototype.setView = function(type) {
        switch (type) {
          case 'task':
            _.each(this.task_views, function(view) {
              view.startListening();
              return view.$el.show();
            });
            return _.each(this.calendar_views, function(view) {
              view.stopListening();
              return view.$el.hide();
            });
          case 'calendar':
            _.each(this.task_views, function(view) {
              view.stopListening();
              return view.$el.hide();
            });
            _.each(this.calendar_views, function(view) {
              view.startListening();
              return view.$el.show();
            });
            return this.calendar_views.calendarView.addAll();
        }
      };

      return ScheduleManager;

    })(Backbone.View);
  });

}).call(this);
