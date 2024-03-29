// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'animate', 'models/users/user', 'views/users/user-item', 'views/users/user-edit'], function(Backbone, ns) {
    ns('United.Views.Users.UserList');
    return United.Views.Users.UserList = (function(_super) {
      var EDIT_OPEN;

      __extends(UserList, _super);

      function UserList() {
        this.newUser = __bind(this.newUser, this);

        this.addAll = __bind(this.addAll, this);

        this.addOne = __bind(this.addOne, this);
        return UserList.__super__.constructor.apply(this, arguments);
      }

      UserList.prototype.el = '#user-manager';

      EDIT_OPEN = false;

      UserList.prototype.events = {
        'click #new-user': 'newUser'
      };

      UserList.prototype.initialize = function() {
        United.EventBus.on('edit-user', this.editUser, this);
        United.EventBus.on('user-edit-closed', function() {
          return EDIT_OPEN = false;
        });
        this.model.on('add:users', this.editUser, this);
        this.model.on('add:users', this.addOne, this);
        this.userList = this.$('#user-list');
        return this.addAll();
      };

      UserList.prototype.addOne = function(user) {
        var view;
        view = new United.Views.Users.UserItem({
          model: user
        });
        return this.userList.append(view.render().$el);
      };

      UserList.prototype.addAll = function(users) {
        return this.model.get('users').each(this.addOne);
      };

      UserList.prototype.editUser = function(user) {
        var _ref;
        if ((_ref = this.editor) != null) {
          _ref.undelegateEvents();
        }
        this.editor = new United.Views.Users.UserEdit({
          model: user,
          open: EDIT_OPEN
        });
        EDIT_OPEN = true;
        return this.editor.render();
      };

      UserList.prototype.newUser = function(user) {
        this.model.get('users').add({});
        return this.editor.render();
      };

      return UserList;

    })(Backbone.View);
  });

}).call(this);
