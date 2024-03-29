// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'views/tasks/user-calendar'], function(Backbone, ns) {
    ns('United.Views.Tasks.CalendarView');
    return United.Views.Tasks.CalendarView = (function(_super) {

      __extends(CalendarView, _super);

      function CalendarView() {
        this.addOne = __bind(this.addOne, this);
        return CalendarView.__super__.constructor.apply(this, arguments);
      }

      CalendarView.prototype.el = '#calendar-view';

      CalendarView.prototype.initialize = function() {
        this.container = $('.container');
        return this.startListening();
      };

      CalendarView.prototype.startListening = function() {
        this.model.on('add:users', this.addOne, this);
        return this.model.on('reset:users', this.addAll, this);
      };

      CalendarView.prototype.stopListening = function() {
        this.model.off('add:users', this.addOne, this);
        return this.model.off('reset:users', this.addAll, this);
      };

      CalendarView.prototype.addOne = function(user) {
        var html, view;
        view = new United.Views.Tasks.UserCalendar({
          model: user
        });
        html = view.render().$el;
        return this.container.append(html);
      };

      CalendarView.prototype.addAll = function(collection) {
        this.container.html('');
        return this.model.get('users').each(this.addOne);
      };

      return CalendarView;

    })(Backbone.View);
  });

}).call(this);
