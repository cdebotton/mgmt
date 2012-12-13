// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'views/user-badge'], function(Backbone, namespace) {
    namespace('BU.View.ProfilePalette');
    return BU.View.ProfilePalette = (function(_super) {

      __extends(ProfilePalette, _super);

      function ProfilePalette() {
        this.addOne = __bind(this.addOne, this);
        return ProfilePalette.__super__.constructor.apply(this, arguments);
      }

      ProfilePalette.prototype.el = '#profile-palette';

      ProfilePalette.prototype.initialize = function() {
        BU.EventBus.on('nav-affix', this.affix, this);
        BU.EventBus.on('nav-affix', this.affix, this);
        this.model.on('add:user', this.addOne, this);
        this.model.on('reset:user', this.addAll, this);
        return this.addAll();
      };

      ProfilePalette.prototype.addOne = function(user) {
        var el, view;
        view = new BU.View.UserBadge({
          model: user
        });
        el = view.render().$el;
        return this.$el.append(el);
      };

      ProfilePalette.prototype.addAll = function(users) {
        return this.model.get('users').each(this.addOne);
      };

      ProfilePalette.prototype.affix = function(toggle) {
        if (toggle === true) {
          return this.$el.addClass('affix');
        } else {
          return this.$el.removeClass('affix');
        }
      };

      return ProfilePalette;

    })(Backbone.View);
  });

}).call(this);
