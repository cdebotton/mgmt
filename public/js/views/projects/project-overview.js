// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'views/tasks/task-element'], function(Backbone, ns) {
    ns('United.Views.Projects.ProjectOverview');
    return United.Views.Projects.ProjectOverview = (function(_super) {

      __extends(ProjectOverview, _super);

      function ProjectOverview() {
        this.addOne = __bind(this.addOne, this);

        this.addAll = __bind(this.addAll, this);
        return ProjectOverview.__super__.constructor.apply(this, arguments);
      }

      ProjectOverview.prototype.el = '#project-overview';

      ProjectOverview.prototype.initialize = function() {
        this.model.get('project').get('tasks').on('add', this.addOne, this);
        return this.addAll();
      };

      ProjectOverview.prototype.addAll = function() {
        this.$el.html('');
        return this.model.get('project').get('tasks').each(this.addOne);
      };

      ProjectOverview.prototype.addOne = function(task, key) {
        var dx, e, el, s, view, width;
        this.generateRange();
        view = new United.Views.Tasks.TaskElement({
          model: task,
          demo: true
        });
        el = view.render().$el;
        el.addClass('demo');
        s = view.model.get('start_date').getTime();
        e = view.model.get('end_date').getTime();
        dx = 10 + (s - this.start) * 910;
        width = 10 + ((e - this.start) / (this.end - this.start)) * 910;
        el.css({
          left: dx,
          width: width
        });
        return this.$el.append(el);
      };

      ProjectOverview.prototype.generateRange = function() {
        var end, start, tasks;
        tasks = this.model.get('project').get('tasks');
        if (tasks.length) {
          start = tasks.first().get('start_date');
          tasks.comparator = function(task) {
            return task.get('end_date');
          };
          end = tasks.last().get('end_date');
          this.start = start.getTime();
          this.end = end.getTime();
          return this.$el.css({
            height: tasks.length * 50 + ((tasks.length - 1) * 10)
          });
        }
      };

      return ProjectOverview;

    })(Backbone.View);
  });

}).call(this);
