// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'jquery', 'ns', 'jst', 'animate', 'views/projects/project-drawer', 'models/projects/edit-drawer', 'models/projects/project', 'models/tasks/task'], function(Backbone, $, ns) {
    ns('United.Views.Projects.ProjectList');
    return United.Views.Projects.ProjectList = (function(_super) {
      var DRAWER_OPEN;

      __extends(ProjectList, _super);

      function ProjectList() {
        this.dropDrawer = __bind(this.dropDrawer, this);

        this.createNewProject = __bind(this.createNewProject, this);
        return ProjectList.__super__.constructor.apply(this, arguments);
      }

      DRAWER_OPEN = false;

      ProjectList.prototype.el = '#project-manager';

      ProjectList.prototype.events = {
        'click #new-project': 'createNewProject'
      };

      ProjectList.prototype.initialize = function() {
        United.EventBus.on('close-project-drawer', this.drawerClosed, this);
        return United.Models.Users.Session = this.model.get('session');
      };

      ProjectList.prototype.createNewProject = function(e) {
        var project;
        project = new United.Models.Projects.Project;
        this.dropDrawer(project);
        return e.preventDefault();
      };

      ProjectList.prototype.dropDrawer = function(project) {
        var params;
        if (project == null) {
          project = null;
        }
        if (DRAWER_OPEN || !United.Models.Users.Session.isAdmin()) {
          return false;
        }
        DRAWER_OPEN = true;
        params = {};
        params['users'] = this.model.get('users');
        if (project !== null) {
          params['project'] = project;
        }
        this.drawer = new United.Views.Projects.ProjectDrawer({
          model: new United.Models.Projects.EditDrawer(params)
        });
        this.$el.prepend(this.drawer.render().$el);
        return United.EventBus.trigger('animate-drawer-in');
      };

      ProjectList.prototype.drawerClosed = function() {
        return DRAWER_OPEN = false;
      };

      return ProjectList;

    })(Backbone.View);
  });

}).call(this);
