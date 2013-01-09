// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'jst', 'animate'], function(Backbone, ns) {
    ns('United.Views.Projects.ProjectItem');
    return United.Views.Projects.ProjectItem = (function(_super) {

      __extends(ProjectItem, _super);

      function ProjectItem() {
        this.printClient = __bind(this.printClient, this);

        this.tileClicked = __bind(this.tileClicked, this);
        return ProjectItem.__super__.constructor.apply(this, arguments);
      }

      ProjectItem.prototype.tagName = 'article';

      ProjectItem.prototype.className = 'project-item';

      ProjectItem.prototype.events = {
        'click': 'tileClicked'
      };

      ProjectItem.prototype.initialize = function() {
        United.JST.Hb.registerHelper('printClient', this.printClient);
        this.model.on('change', this.render, this);
        this.model.on('change:client', this.render, this);
        return this.model.on('destroy', this.destroy, this);
      };

      ProjectItem.prototype.render = function() {
        var ctx, html;
        ctx = this.model.toJSON();
        if (this.model.has('client')) {
          ctx.client = this.model.get('client').toJSON();
        }
        html = United.JST.ProjectItem(ctx);
        this.$el.html(html);
        return this;
      };

      ProjectItem.prototype.tileClicked = function(e) {
        e.preventDefault();
        e.stopPropagation();
        return United.EventBus.trigger('open-project', this.model);
      };

      ProjectItem.prototype.destroy = function(model) {
        var _this = this;
        return this.$el.animate({
          opacity: 0
        }, 175, 'ease-out', function() {
          return _this.remove();
        });
      };

      ProjectItem.prototype.printClient = function() {
        if (this.model.get('client') !== null) {
          return new United.JST.Hb.SafeString("<h6>" + (this.model.get('client').get('name')) + "</h6>");
        } else if (this.model.get('client_name') !== null) {
          return new United.JST.Hb.SafeString("<h6>" + (this.model.get('client_name')) + "</h6>");
        }
      };

      return ProjectItem;

    })(Backbone.View);
  });

}).call(this);