// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'relational', 'models/projects/project', 'collections/projects/projects'], function(Backbone, ns) {
    ns('United.Models.Clients.Client');
    United.Models.Clients.Client = (function(_super) {

      __extends(Client, _super);

      function Client() {
        return Client.__super__.constructor.apply(this, arguments);
      }

      Client.prototype.url = function() {
        return '/api/v1/clients' + (this.isNew() ? "/" + (this.model.get('id')) : '');
      };

      Client.prototype.relations = [
        {
          type: Backbone.HasMany,
          relatedModel: United.Models.Projects.Project,
          collectionType: United.Collections.Projects.Projects,
          key: 'projects',
          reverseRelation: {
            key: 'client',
            type: Backbone.HasOne,
            includeInJSON: 'id'
          }
        }
      ];

      return Client;

    })(Backbone.RelationalModel);
    return United.Models.Clients.Client.setup();
  });

}).call(this);
