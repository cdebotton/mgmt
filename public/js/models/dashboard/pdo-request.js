// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'relational'], function(Backbone, ns) {
    ns('United.Models.Dashboard.PdoRequest');
    United.Models.Dashboard.PdoRequest = (function(_super) {

      __extends(PdoRequest, _super);

      function PdoRequest() {
        return PdoRequest.__super__.constructor.apply(this, arguments);
      }

      return PdoRequest;

    })(Backbone.RelationalModel);
    return United.Models.Dashboard.PdoRequest.setup();
  });

}).call(this);
