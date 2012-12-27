// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'models/users/role'], function(Backbone, ns) {
    ns('United.Collections.Users.Roles');
    return United.Collections.Users.Roles = (function(_super) {

      __extends(Roles, _super);

      function Roles() {
        return Roles.__super__.constructor.apply(this, arguments);
      }

      Roles.prototype.model = United.Models.Users.Role;

      return Roles;

    })(Backbone.Collection);
  });

}).call(this);