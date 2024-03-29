// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'models/projects/project'], function(Backbone, ns) {
    ns('United.Collections.Projects.Projects');
    return United.Collections.Projects.Projects = (function(_super) {

      __extends(Projects, _super);

      function Projects() {
        return Projects.__super__.constructor.apply(this, arguments);
      }

      Projects.prototype.model = United.Models.Projects.Project;

      Projects.prototype.comparator = function(project) {
        return new Date(project.get('created_at')).getTime();
      };

      return Projects;

    })(Backbone.Collection);
  });

}).call(this);
