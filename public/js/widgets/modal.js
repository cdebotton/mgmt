// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'underscore', 'ns', 'jquery', 'jst', 'animate'], function(Backbone, _, ns, $) {
    ns('United.Widgets.Modal');
    return United.Widgets.Modal = (function(_super) {

      __extends(Modal, _super);

      function Modal() {
        this.printOptions = __bind(this.printOptions, this);

        this.printMsg = __bind(this.printMsg, this);

        this.animateCheechOut = __bind(this.animateCheechOut, this);
        return Modal.__super__.constructor.apply(this, arguments);
      }

      Modal.prototype.tagName = 'section';

      Modal.prototype.className = 'striped-cheech';

      Modal.prototype.events = {
        'click .icon-remove': 'closeModal'
      };

      Modal.prototype.initialize = function() {
        United.JST.Hb.registerHelper('printMsg', this.printMsg);
        United.JST.Hb.registerHelper('printOptions', this.printOptions);
        this.body = $('body');
        this.$el.css({
          opacity: 0
        });
        return this.render();
      };

      Modal.prototype.render = function() {
        var ctx, html;
        ctx = this.model.toJSON();
        html = United.JST.OptionModal(ctx);
        this.$el.html(html);
        this.body.append(this.$el);
        this.modal = this.$('.edit-modal');
        return this.animateCheechIn();
      };

      Modal.prototype.animateCheechIn = function() {
        return this.$el.animate({
          opacity: 1
        }, 150, 'ease-in', this.animateModalIn());
      };

      Modal.prototype.animateModalIn = function() {
        this.modal.css({
          top: 0,
          marginLeft: -parseInt(this.modal.innerWidth() / 2),
          marginTop: -parseInt(this.modal.innerHeight() / 2)
        });
        return this.modal.animate({
          top: 75,
          opacity: 1
        });
      };

      Modal.prototype.closeModal = function() {
        return this.modal.animate({
          top: 0,
          opacity: 0
        }, 175, 'ease-out', this.animateCheechOut);
      };

      Modal.prototype.animateCheechOut = function() {
        var _this = this;
        return this.$el.animate({
          opacity: 0
        }, 175, 'ease-out', function() {
          return _this.remove();
        });
      };

      Modal.prototype.printMsg = function() {
        return new United.JST.Hb.SafeString(this.model.get('msg'));
      };

      Modal.prototype.printOptions = function(hash, opts) {
        var action, buffer, item, label;
        if (hash instanceof Object) {
          buffer = '';
          for (label in hash) {
            action = hash[label];
            item = {};
            item.label = label;
            item.className = label.replace(/\W/, '-').toLowerCase();
            this.events["click ." + item.className] = action;
            buffer += opts.fn(item);
          }
          this.undelegateEvents();
          this.delegateEvents();
          return buffer;
        } else {
          return opts.inverse();
        }
      };

      return Modal;

    })(Backbone.View);
  });

}).call(this);