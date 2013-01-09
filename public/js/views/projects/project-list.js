// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'jquery', 'ns', 'animate', 'views/projects/project-edit', 'models/projects/project-edit', 'models/clients/client', 'views/projects/project-item'], function(Backbone, $, ns) {
    ns('United.Views.Projects.ProjectList');
    return United.Views.Projects.ProjectList = (function(_super) {
      var DRAWER_OPEN;

      __extends(ProjectList, _super);

      function ProjectList() {
        this.dropDrawer = __bind(this.dropDrawer, this);

        this.createNewProject = __bind(this.createNewProject, this);

        this.addAll = __bind(this.addAll, this);

        this.addOne = __bind(this.addOne, this);
        return ProjectList.__super__.constructor.apply(this, arguments);
      }

      DRAWER_OPEN = false;

      ProjectList.prototype.el = '#project-manager';

      ProjectList.prototype.events = {
        'click #new-project': 'createNewProject'
      };

      ProjectList.prototype.initialize = function() {
        United.EventBus.on('close-project-drawer', this.drawerClosed, this);
        United.Models.Users.Session = this.model.get('session');
        this.model.on('add:projects', this.addOne, this);
        this.model.on('reset:projects', this.addAll, this);
        this.projectList = this.$('#project-list');
        return this.addAll();
      };

      ProjectList.prototype.addOne = function(project) {
        var view;
        view = new United.Views.Projects.ProjectItem({
          model: project
        });
        return this.projectList.append(view.render().$el);
      };

      ProjectList.prototype.addAll = function(projects) {
        this.projectList.html('');
        return this.model.get('projects').each(this.addOne);
      };

      ProjectList.prototype.createNewProject = function(e) {
        var project;
        project = new United.Models.Projects.Project;
        this.model.get('projects').add(project);
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
        this.drawer = new United.Views.Projects.ProjectEdit({
          model: new United.Models.Projects.ProjectEdit(params)
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
