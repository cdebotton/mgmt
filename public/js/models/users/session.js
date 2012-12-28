// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'underscore', 'ns', 'relational', 'models/users/role', 'collections/users/roles', 'models/users/discipline', 'collections/users/disciplines'], function(Backbone, _, ns, relational) {
    ns('United.Models.Users.Session');
    United.Models.Users.Session = (function(_super) {

      __extends(Session, _super);

      function Session() {
        return Session.__super__.constructor.apply(this, arguments);
      }

      Session.prototype.relations = [
        {
          type: Backbone.HasMany,
          key: 'roles',
          relatedModel: United.Models.Users.Role,
          collectionType: United.Collections.Users.Roles
        }, {
          type: Backbone.HasMany,
          key: 'disciplines',
          relatedModel: United.Models.Users.Role,
          collectionType: United.Collections.Users.Disciplines
        }
      ];

      Session.prototype.url = function() {
        return 'api/v1/session';
      };

      Session.prototype.isAdmin = function() {
        var roles;
        roles = this.get('roles').pluck('name');
        return _.indexOf(roles, 'Admin') > -1;
      };

      return Session;

    })(Backbone.RelationalModel);
    return United.Models.Users.Session.setup();
  });

}).call(this);
