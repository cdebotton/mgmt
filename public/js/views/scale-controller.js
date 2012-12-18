// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns'], function(Backbone, ns) {
    ns('BU.Views.ScaleController');
    return BU.Views.ScaleController = (function(_super) {

      __extends(ScaleController, _super);

      function ScaleController() {
        this.stopDrag = __bind(this.stopDrag, this);

        this.onDrag = __bind(this.onDrag, this);

        this.startDrag = __bind(this.startDrag, this);
        return ScaleController.__super__.constructor.apply(this, arguments);
      }

      ScaleController.prototype.el = '#timescale-wrapper';

      ScaleController.prototype.events = {
        'mousedown #timescale-knob': 'startDrag'
      };

      ScaleController.prototype.initX = 0;

      ScaleController.prototype.offset = 0;

      ScaleController.prototype.initialize = function() {
        this.slider = this.$('#timescale-slider');
        this.knob = this.$('#timescale-knob');
        this.body = $('body');
        return this.total = this.slider.width() - 20;
      };

      ScaleController.prototype.startDrag = function(e) {
        this.initX = e.pageX;
        this.body.on('mousemove', this.onDrag);
        return this.body.on('mouseup', this.stopDrag);
      };

      ScaleController.prototype.onDrag = function(e) {
        var dx, percentage;
        dx = e.pageX - this.initX;
        this.offset += dx;
        if (this.offset < 0) {
          this.offset = 0;
        } else if (this.offset > 180) {
          this.offset = 180;
        }
        this.knob.css('left', this.offset);
        this.initX = e.pageX;
        percentage = Math.ceil(100 * (this.offset / this.total));
        return console.log(percentage);
      };

      ScaleController.prototype.stopDrag = function(e) {
        this.body.off('mousemove', this.onDrag);
        return this.body.off('mouseup', this.stopDrag);
      };

      return ScaleController;

    })(Backbone.View);
  });

}).call(this);
