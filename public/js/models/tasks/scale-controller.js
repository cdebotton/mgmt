// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns'], function(Backbone, ns) {
    ns('United.Models.Tasks.ScaleController');
    return United.Models.Tasks.ScaleController = (function(_super) {

      __extends(ScaleController, _super);

      function ScaleController() {
        return ScaleController.__super__.constructor.apply(this, arguments);
      }

      ScaleController.prototype.defaults = {
        zoom: 80
      };

      return ScaleController;

    })(Backbone.Model);
  });

}).call(this);