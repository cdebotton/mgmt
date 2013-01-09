// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'jquery', 'ns', 'jst', 'animate', 'views/projects/project-task-edit', 'models/projects/project-task-edit', 'views/projects/project-overview', 'models/projects/project-overview', 'views/widgets/livesearch-input', 'models/widgets/livesearch'], function(Backbone, $, ns) {
    ns('United.Views.Projects.ProjectEdit');
    return United.Views.Projects.ProjectEdit = (function(_super) {

      __extends(ProjectEdit, _super);

      function ProjectEdit() {
        this.saveProject = __bind(this.saveProject, this);

        this.setClientId = __bind(this.setClientId, this);

        this.setClientId = __bind(this.setClientId, this);

        this.bindEscape = __bind(this.bindEscape, this);

        this.closeDrawer = __bind(this.closeDrawer, this);

        this.newTask = __bind(this.newTask, this);

        this.setClient = __bind(this.setClient, this);

        this.setCode = __bind(this.setCode, this);

        this.setName = __bind(this.setName, this);
        return ProjectEdit.__super__.constructor.apply(this, arguments);
      }

      ProjectEdit.prototype.tagName = 'section';

      ProjectEdit.prototype.className = 'project-drawer';

      ProjectEdit.prototype.events = {
        'click button[type="submit"]': 'saveProject',
        'click .add-task-to-project': 'newTask',
        'click #close-project-drawer': 'closeDrawer',
        'keyup input[name="project-name"]': 'setName',
        'keyup input[name="code"]': 'setCode',
        'keyup input[name="client"]': 'setClient'
      };

      ProjectEdit.prototype.initialize = function() {
        United.EventBus.on('animate-drawer-in', this.animateIn, this);
        United.EventBus.on('load-task-in-editor', this.editTask, this);
        return this.model.get('project').get('tasks').on('add', this.editTask, this);
      };

      ProjectEdit.prototype.render = function() {
        var ctx, html;
        this.body = $('body');
        ctx = this.model.get('project').toJSON();
        html = United.JST.ProjectDrawer(ctx);
        this.$el.html(html);
        this.taskHolder = this.$('#project-task-holder');
        return this;
      };

      ProjectEdit.prototype.setName = function(e) {
        return this.model.get('project').set('name', e.currentTarget.value);
      };

      ProjectEdit.prototype.setCode = function(e) {
        return this.model.get('project').set('code', e.currentTarget.value);
      };

      ProjectEdit.prototype.setClient = function(e) {
        return this.model.get('project').set('client_name', e.currentTarget.value);
      };

      ProjectEdit.prototype.editTask = function(task) {
        this.taskEditor = new United.Views.Projects.ProjectTaskEdit({
          model: new United.Models.Projects.ProjectTaskEdit({
            task: task
          })
        });
        return this.taskHolder.html(this.taskEditor.render().$el);
      };

      ProjectEdit.prototype.newTask = function(e) {
        this.model.get('project').get('tasks').add({});
        return e.preventDefault();
      };

      ProjectEdit.prototype.setup = function() {
        this.overview = new United.Views.Projects.ProjectOverview({
          model: new United.Models.Projects.ProjectOverview({
            project: this.model.get('project')
          })
        });
        return this.liveSearch = new United.Views.Widgets.LiveSearchInput({
          el: '#client-search',
          model: new United.Models.Widgets.LiveSearch({
            sources: window.clients
          })
        });
      };

      ProjectEdit.prototype.animateIn = function() {
        this.liveSearch.$el.on('keyup', this.setClient);
        this.liveSearch.model.on('change:value', this.setClientId, this);
        this.liveSearch.model.on('change:client_name', this.setClientName, this);
        this.$el.css('margin-top', -this.$el.innerHeight());
        this.$el.animate({
          'margin-top': 0
        }, 175, 'ease-in');
        return this.body.bind('keyup', this.bindEscape);
      };

      ProjectEdit.prototype.closeDrawer = function(e) {
        var _this = this;
        if (this.model.get('project').isNew()) {
          this.model.get('project').destroy();
        }
        this.$el.animate({
          'margin-top': -this.$el.innerHeight()
        }, 175, 'ease-out', function() {
          _this.taskHolder.remove();
          _this.liveSearch.remove();
          _this.remove();
          return United.EventBus.trigger('close-project-drawer');
        });
        return e.preventDefault();
      };

      ProjectEdit.prototype.bindEscape = function(e) {
        if (e.keyCode === 27) {
          return this.closeDrawer(e);
        }
      };

      ProjectEdit.prototype.setClientId = function(model, value) {
        return this.model.get('project').set('client_id', value);
      };

      ProjectEdit.prototype.setClientId = function(model, value) {
        return this.model.get('project').set('client_name', name);
      };

      ProjectEdit.prototype.saveProject = function(e) {};

      return ProjectEdit;

    })(Backbone.View);
  });

}).call(this);
