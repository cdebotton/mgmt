// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'relational'], function(Backbone, ns) {
    ns('United.Models.Widgets.LiveSearchResult');
    United.Models.Widgets.LiveSearchResult = (function(_super) {

      __extends(LiveSearchResult, _super);

      function LiveSearchResult() {
        return LiveSearchResult.__super__.constructor.apply(this, arguments);
      }

      return LiveSearchResult;

    })(Backbone.RelationalModel);
    return United.Models.Widgets.LiveSearchResult.setup();
  });

}).call(this);