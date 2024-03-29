// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'underscore', 'ns', 'relational', 'models/widgets/livesearch-source', 'collections/widgets/livesearch-sources'], function(Backbone, _, ns) {
    ns('United.Models.Widgets.LiveSearch');
    United.Models.Widgets.LiveSearch = (function(_super) {

      __extends(LiveSearch, _super);

      function LiveSearch() {
        return LiveSearch.__super__.constructor.apply(this, arguments);
      }

      LiveSearch.prototype.relations = [
        {
          type: Backbone.HasMany,
          key: 'sources',
          relatedModel: United.Models.Widgets.LiveSearchSource,
          collectionType: United.Collections.Widgets.LiveSearchSources,
          reverseRelation: {
            type: Backbone.HasOne,
            key: 'search',
            includeInJSON: false
          }
        }
      ];

      LiveSearch.prototype.url = function() {
        if (this.has('queryUri')) {
          return this.get('queryUri');
        }
      };

      LiveSearch.prototype.initialize = function() {
        return this.on('change:currentIndex', this.controlCurrentIndex, this);
      };

      LiveSearch.prototype.controlCurrentIndex = function(model, index, status) {
        if (index !== void 0) {
          if (index < 0) {
            index = this.get('results').length - 1;
          } else if (index >= this.get('results').length) {
            index = 0;
          }
          this.attributes['currentIndex'] = index;
          return this.get('results').each(function(result, key) {
            result.unset('active');
            if (key === index) {
              return result.set('active', true);
            }
          });
        }
      };

      return LiveSearch;

    })(Backbone.RelationalModel);
    return United.Models.Widgets.LiveSearch.setup();
  });

}).call(this);
