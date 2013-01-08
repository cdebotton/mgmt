// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'views/widgets/livesearch-list'], function(Backbone, ns) {
    ns('United.Views.Widgets.LiveSearchInput');
    return United.Views.Widgets.LiveSearchInput = (function(_super) {
      var LIST_VISIBLE;

      __extends(LiveSearchInput, _super);

      function LiveSearchInput() {
        this.move = __bind(this.move, this);

        this.keyUp = __bind(this.keyUp, this);

        this.keyPress = __bind(this.keyPress, this);

        this.keyDown = __bind(this.keyDown, this);
        return LiveSearchInput.__super__.constructor.apply(this, arguments);
      }

      LIST_VISIBLE = false;

      LiveSearchInput.prototype.events = {
        'keydown': 'keyDown',
        'keypress': 'keyPress',
        'keyup': 'keyUp'
      };

      LiveSearchInput.prototype.initialize = function() {};

      LiveSearchInput.prototype.keyDown = function(e) {
        this.suppressKeyPressRepeat = _.indexOf([40, 38, 9, 13, 27], e.keyCode) > 0;
        return this.move(e);
      };

      LiveSearchInput.prototype.keyPress = function(e) {
        if (this.suppressKeyPressRepeat) {
          return;
        }
        return this.move(e);
      };

      LiveSearchInput.prototype.keyUp = function(e) {
        switch (e.keyCode) {
          case 40:
            break;
          case 38:
            break;
          case 16:
            break;
          case 17:
            break;
          case 18:
            break;
          case 9:
            if (!LIST_VISIBLE) {
              return;
            }
            this.select();
            break;
          case 13:
            if (!LIST_VISIBLE) {
              return;
            }
            this.select();
            break;
          case 27:
            if (!LIST_VISIBLE) {
              return;
            }
            this.hide();
            break;
          default:
            this.lookup();
        }
        e.stopPropagation();
        return e.preventDefault();
      };

      LiveSearchInput.prototype.select = function() {};

      LiveSearchInput.prototype.lookup = function() {};

      LiveSearchInput.prototype.hide = function() {};

      LiveSearchInput.prototype.move = function(e) {
        if (!LIST_VISIBLE) {
          return false;
        }
        switch (e.keyCode) {
          case 9:
            e.preventDefault();
            break;
          case 13:
            e.preventDefault();
            break;
          case 27:
            e.preventDefault();
            break;
          case 38:
            e.preventDefault();
            this.previous();
            break;
          case 40:
            e.preventDefault();
            this.next();
        }
        return e.stopPropagation();
      };

      LiveSearchInput.prototype.previous = function() {};

      LiveSearchInput.prototype.next = function() {};

      return LiveSearchInput;

    })(Backbone.View);
  });

}).call(this);