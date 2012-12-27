// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'relational', 'models/projects/project'], function(Backbone, ns) {
    ns('United.Models.Projects.EditModal');
    return United.Models.Projects.EditModal = (function(_super) {

      __extends(EditModal, _super);

      function EditModal() {
        return EditModal.__super__.constructor.apply(this, arguments);
      }

      EditModal.prototype.relations = [
        {
          type: Backbone.HasOne,
          relatedModel: United.Models.Projects.Project,
          key: 'project',
          reverseRelation: {
            type: Backbone.HasOne,
            key: 'modal',
            includeInJSON: false
          }
        }
      ];

      return EditModal;

    })(Backbone.RelationalModel);
  });

}).call(this);