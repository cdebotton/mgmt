// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'models/clients/client'], function(Backbone, ns) {
    ns('United.Collections.Clients.Clients');
    return United.Collections.Clients.Clients = (function(_super) {

      __extends(Clients, _super);

      function Clients() {
        return Clients.__super__.constructor.apply(this, arguments);
      }

      Clients.prototype.model = United.Models.Clients.Client;

      return Clients;

    })(Backbone.Collection);
  });

}).call(this);