// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'relational'], function(Backbone, ns) {
    ns('United.Models.Projects.Project');
    United.Models.Projects.Project = (function(_super) {

      __extends(Project, _super);

      function Project() {
        return Project.__super__.constructor.apply(this, arguments);
      }

      Project.prototype.initialize = function() {};

      return Project;

    })(Backbone.RelationalModel);
    return United.Models.Projects.Project.setup();
  });

}).call(this);
