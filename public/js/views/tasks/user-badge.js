// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'jst'], function(Backbone, ns) {
    ns('United.Views.Tasks.UserBadge');
    return United.Views.Tasks.UserBadge = (function(_super) {

      __extends(UserBadge, _super);

      function UserBadge() {
        return UserBadge.__super__.constructor.apply(this, arguments);
      }

      UserBadge.prototype.tagName = 'article';

      UserBadge.prototype.className = 'user-object';

      UserBadge.prototype.initialize = function() {
        return this.model.get('tasks').on('change:track', this.adjustHeight, this);
      };

      UserBadge.prototype.render = function() {
        var ctx, html;
        ctx = this.model.toJSON();
        html = United.JST['UserBadge'](ctx);
        this.$el.html(html);
        this.adjustHeight();
        return this;
      };

      UserBadge.prototype.adjustHeight = function(model, value, status) {
        var highest, _ref;
        highest = (_ref = this.model.get('tasks').max(function(task) {
          return +task.get('track');
        })) != null ? _ref.get('track') : void 0;
        if (highest > 2) {
          return this.$el.css('height', (highest * 60) + 70);
        } else {
          return this.$el.css('height', 184);
        }
      };

      return UserBadge;

    })(Backbone.View);
  });

}).call(this);
