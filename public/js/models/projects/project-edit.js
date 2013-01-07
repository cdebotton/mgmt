// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'relational', 'models/projects/project', 'models/tasks/task'], function(Backbone, ns) {
    ns('United.Models.Projects.ProjectEdit');
    United.Models.Projects.ProjectEdit = (function(_super) {

      __extends(ProjectEdit, _super);

      /*
      		relations: [{
      			type:				Backbone.HasOne
      			relatedModel:		United.Models.Projects.Project
      			key:				'project'
      			reverseRelation:
      				type:			Backbone.HasOne
      				key:			'drawer'
      				includeInJSON:	false
      		}]
      */


      function ProjectEdit() {
        return ProjectEdit.__super__.constructor.apply(this, arguments);
      }

      return ProjectEdit;

    })(Backbone.RelationalModel);
    return United.Models.Projects.ProjectEdit.setup();
  });

}).call(this);
