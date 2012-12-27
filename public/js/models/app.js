// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'relational', 'models/users/user', 'collections/users/users', 'models/users/session'], function(Backbone, namespace) {
    namespace('United.Models.App');
    United.Models.App = (function(_super) {

      __extends(App, _super);

      function App() {
        this.sanitizeTasks = __bind(this.sanitizeTasks, this);

        this.sanitizeUsers = __bind(this.sanitizeUsers, this);
        return App.__super__.constructor.apply(this, arguments);
      }

      App.prototype.relations = [
        {
          type: Backbone.HasMany,
          key: 'users',
          relatedModel: United.Models.Users.User,
          collectionType: United.Collections.Users.Users,
          reverseRelation: {
            type: Backbone.HasOne,
            key: 'app',
            includeInJson: 'id'
          }
        }, {
          type: Backbone.HasOne,
          key: 'session',
          relatedModel: United.Models.Users.Session,
          reverseRelation: {
            type: Backbone.HasOne,
            key: 'app',
            includeInJSON: false
          }
        }
      ];

      App.prototype.initialize = function() {
        this.get('users').each(this.sanitizeUsers);
        return this.set('session', new United.Models.Users.Session);
      };

      App.prototype.sanitizeUsers = function(user, key) {
        return user.get('tasks').each(this.sanitizeTasks);
      };

      App.prototype.sanitizeTasks = function(task, key) {
        task.attributes['percentage'] = task.get('pivot').percentage;
        return delete task.attributes['pivot'];
      };

      return App;

    })(Backbone.RelationalModel);
    return United.Models.App.setup();
  });

}).call(this);
