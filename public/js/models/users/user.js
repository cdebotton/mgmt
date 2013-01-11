// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'relational', 'models/users/role', 'collections/users/roles', 'models/tasks/task', 'collections/tasks/tasks', 'models/users/discipline', 'collections/users/disciplines'], function(Backbone, ns) {
    ns('United.Models.Users.User');
    United.Models.Users.User = (function(_super) {

      __extends(User, _super);

      function User() {
        return User.__super__.constructor.apply(this, arguments);
      }

      User.prototype.url = function() {
        return "/api/v1/users" + (!this.isNew() ? "/update/" + (this.get('id')) : '');
      };

      User.prototype.relations = [
        {
          type: Backbone.HasMany,
          key: 'roles',
          relatedModel: United.Models.Users.Role,
          collectionType: United.Collections.Tasks.Roles
        }, {
          type: Backbone.HasMany,
          key: 'tasks',
          relatedModel: United.Models.Tasks.Task,
          collectionType: United.Collections.Tasks.Tasks,
          reverseRelation: {
            type: Backbone.HasOne,
            key: 'user',
            keySource: 'user_id',
            includeInJSON: 'id'
          }
        }, {
          type: Backbone.HasMany,
          key: 'disciplines',
          relatedModel: United.Models.Users.Discipline,
          collectionType: United.Collections.Tasks.Disciplines
        }
      ];

      User.prototype.defaults = {
        first_name: 'New',
        last_name: 'User',
        photo: 'http://placehold.it/100x100',
        hired_on: new Date()
      };

      User.prototype.parse = function(resp) {
        resp.hired_on = new Date(resp.hired_on);
        resp.last_login = new Date(resp.last_login);
        return resp;
      };

      User.prototype.initialize = function() {};

      return User;

    })(Backbone.RelationalModel);
    return United.Models.Users.User.setup();
  });

}).call(this);
