// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'relational'], function(Backbone, ns) {
    ns('BU.Model.Pivot');
    return BU.Model.Pivot = (function(_super) {

      __extends(Pivot, _super);

      function Pivot() {
        return Pivot.__super__.constructor.apply(this, arguments);
      }

      return Pivot;

    })(Backbone.RelationalModel);
  });

}).call(this);
