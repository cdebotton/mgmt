// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'underscore', 'ns', 'views/tasks/user-timeline'], function(Backbone, _, ns) {
    ns('United.Views.Tasks.TaskTimeline');
    return United.Views.Tasks.TaskTimeline = (function(_super) {

      __extends(TaskTimeline, _super);

      function TaskTimeline() {
        this.addOne = __bind(this.addOne, this);
        return TaskTimeline.__super__.constructor.apply(this, arguments);
      }

      TaskTimeline.prototype.el = '#task-timeline-wrapper';

      TaskTimeline.prototype.views = [];

      TaskTimeline.prototype.initialize = function() {
        this.startListening();
        this.parent = this.$el.parent();
        this.model.on('add:user', this.addOne, this);
        this.model.on('reset:user', this.addAll, this);
        this.model.on('remove:user', this.addAll, this);
        return this.addAll();
      };

      TaskTimeline.prototype.startListening = function() {
        United.EventBus.on('set-filter', this.setFilter, this);
        return this.$el.parent().show();
      };

      TaskTimeline.prototype.stopListening = function() {
        United.EventBus.off('set-filter', this.setFilter, this);
        return this.$el.parent().hide();
      };

      TaskTimeline.prototype.addOne = function(user) {
        var el, view;
        view = new United.Views.Tasks.UserTimeline({
          model: user
        });
        this.views.push(view);
        el = view.render().$el;
        return this.$el.append(el);
      };

      TaskTimeline.prototype.addAll = function(users) {
        return this.model.get('users').each(this.addOne);
      };

      TaskTimeline.prototype.setFilter = function(type, filter) {
        var users;
        _.each(this.views, function(view) {
          return view.remove();
        });
        if (type === null) {
          return this.addAll();
        }
        users = this.model.get('users').filter(function(user) {
          var matches;
          matches = user.get(type).filter(function(item) {
            return +item.get('id') === +filter;
          });
          return matches.length > 0;
        });
        if (users.length > 0) {
          return _.each(users, this.addOne);
        }
      };

      return TaskTimeline;

    })(Backbone.View);
  });

}).call(this);
