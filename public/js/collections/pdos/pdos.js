// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'models/pdos/pdo'], function(Backbone, ns) {
    ns('United.Collections.Pdos.Pdos');
    return United.Collections.Pdos.Pdos = (function(_super) {

      __extends(Pdos, _super);

      function Pdos() {
        return Pdos.__super__.constructor.apply(this, arguments);
      }

      Pdos.prototype.model = United.Models.Pdos.Pdo;

      return Pdos;

    })(Backbone.Collection);
  });

}).call(this);
