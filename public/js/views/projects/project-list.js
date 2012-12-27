// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'jquery', 'ns', 'jst', 'animate', 'views/projects/project-modal', 'models/projects/edit-modal'], function(Backbone, $, ns) {
    ns('United.Views.Projects.ProjectList');
    return United.Views.Projects.ProjectList = (function(_super) {
      var MODAL_OPEN;

      __extends(ProjectList, _super);

      function ProjectList() {
        this.openModal = __bind(this.openModal, this);
        return ProjectList.__super__.constructor.apply(this, arguments);
      }

      MODAL_OPEN = false;

      ProjectList.prototype.el = '#project-manager';

      ProjectList.prototype.events = {
        'click #new-project': 'openModal'
      };

      ProjectList.prototype.initialize = function() {
        United.EventBus.on('modal-closed', this.modalClosed, this);
        return United.Models.Users.Session = this.model.get('session');
      };

      ProjectList.prototype.openModal = function(project) {
        var params;
        if (project == null) {
          project = null;
        }
        if (MODAL_OPEN || !United.Models.Users.Session.isAdmin()) {
          return false;
        }
        MODAL_OPEN = true;
        params = {};
        params['users'] = this.model.get('users');
        if (project !== null) {
          params['project'] = project;
        }
        this.modal = new United.Views.Projects.ProjectModal({
          model: new United.Models.Projects.EditModal(params)
        });
        this.$el.append(this.modal.render().$el);
        return false;
      };

      ProjectList.prototype.modelClosed = function() {
        return MODAL_OPEN = false;
      };

      return ProjectList;

    })(Backbone.View);
  });

}).call(this);