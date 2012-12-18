// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'jst'], function(Backbone, namespace) {
    namespace('BU.Views.GraphTimeline');
    return BU.Views.GraphTimeline = (function(_super) {
      var DAY_TO_MILLISECONDS, DRAGGING, PX_PER_DAY, RANGE;

      __extends(GraphTimeline, _super);

      function GraphTimeline() {
        this.stopDrag = __bind(this.stopDrag, this);

        this.onDrag = __bind(this.onDrag, this);

        this.startDrag = __bind(this.startDrag, this);
        return GraphTimeline.__super__.constructor.apply(this, arguments);
      }

      GraphTimeline.prototype.el = '#graph-timeline-wrapper';

      DAY_TO_MILLISECONDS = 86400000;

      GraphTimeline.prototype.months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec'];

      GraphTimeline.prototype.days = ['Mon', 'Tues', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun'];

      GraphTimeline.prototype.today = new Date();

      GraphTimeline.prototype.currentTime = null;

      GraphTimeline.prototype.ticks = {
        dates: []
      };

      GraphTimeline.prototype.grid = {};

      RANGE = 504;

      GraphTimeline.prototype.XHOME = 0;

      GraphTimeline.prototype.OFFSET = 0;

      DRAGGING = false;

      PX_PER_DAY = 41;

      GraphTimeline.prototype.events = {
        'mousedown': 'startDrag'
      };

      GraphTimeline.prototype.initialize = function() {
        var end, start, today;
        BU.EventBus.on('on-scroll', this.affix, this);
        BU.EventBus.on('adjust', this.adjust, this);
        BU.EventBus.on('update-timeline-transform', this.updateTransform, this);
        BU.EventBus.on('plot-ranges', this.plotRanges, this);
        BU.JST.Hb.registerHelper('outputGraph', this.outputGraph);
        this.body = $('body');
        this.body.on('mousemove', this.onDrag);
        this.body.on('mouseup', this.stopDrag);
        this.parent = this.$el.parent();
        this.dy = this.$el.offset().top;
        today = new Date();
        today.setHours(0);
        today.setMinutes(0);
        today.setSeconds(0);
        today.setMilliseconds(0);
        this.currentTime = today.getTime();
        start = new Date(this.currentTime - this.countMilli(RANGE / 2));
        start.setHours(0);
        start.setMinutes(0);
        start.setSeconds(0);
        start.setMilliseconds(0);
        end = new Date(this.currentTime + this.countMilli(RANGE / 2));
        end.setHours(0);
        end.setMinutes(0);
        end.setSeconds(0);
        end.setMilliseconds(0);
        this.drawTicks(start, end);
        BU.EventBus.on('where-am-i', this.locateTimelineObject, this);
        return this.render(start, today);
      };

      GraphTimeline.prototype.drawTicks = function(start, end) {
        var c, d, dx, epoch, _results;
        this.ticks = {
          dates: []
        };
        dx = 0;
        c = 0;
        d = start;
        _results = [];
        while (d <= end) {
          epoch = d.getTime();
          this.grid[epoch] = dx;
          dx += PX_PER_DAY;
          if (c % 7 === 0) {
            this.ticks.dates.push({
              dx: dx,
              epoch: epoch,
              readable: this.readableDate(d)
            });
          }
          c++;
          _results.push(d.setDate(d.getDate() + 1));
        }
        return _results;
      };

      GraphTimeline.prototype.locateTimelineObject = function(cid, start_date, end_date) {
        var dx, dx2, p1, p2, x;
        p1 = (new Date(start_date)).getTime();
        p2 = (new Date(end_date)).getTime();
        x = this.grid[this.currentTime];
        dx = this.grid[p1] - x + 50;
        dx2 = this.grid[p2] - x + 50;
        return BU.EventBus.trigger('gridpoint-dispatch', cid, dx, dx2, this.OFFSET);
      };

      GraphTimeline.prototype.render = function(start, target) {
        var ctx, dx, html;
        ctx = this.ticks;
        html = BU.JST['GraphTimeline'](ctx);
        this.$el.html(html);
        dx = -this.calculateOffset(start, target);
        this.$el.css({
          width: 4 * Math.abs(dx),
          left: dx
        });
        return this;
      };

      GraphTimeline.prototype.startDrag = function(e) {
        this.XHOME = e.originalEvent.clientX;
        DRAGGING = true;
        return e.preventDefault();
      };

      GraphTimeline.prototype.onDrag = function(e) {
        var nextDx, values;
        if (!DRAGGING) {
          return false;
        }
        nextDx = this.XHOME - e.originalEvent.clientX;
        this.OFFSET += parseInt(nextDx * 1.75);
        this.XHOME = e.originalEvent.clientX;
        values = ["" + this.OFFSET + "px", 0, 0].join(', ');
        this.$el.css({
          '-webkit-transform': "translate3d(" + values + ")"
        });
        BU.EventBus.trigger('offset-timeline', values);
        return e.preventDefault();
      };

      GraphTimeline.prototype.stopDrag = function(e) {
        DRAGGING = false;
        this.XHOME = 0;
        return e.preventDefault();
      };

      GraphTimeline.prototype.affix = function(scrollTop) {
        scrollTop += 42;
        if (scrollTop > this.dy) {
          return this.parent.addClass('affix');
        } else {
          return this.parent.removeClass('affix');
        }
      };

      GraphTimeline.prototype.outputGraph = function(array, options) {
        var buffer, i, item, _i, _j, _len;
        if ((array != null ? array.length : void 0) > 0) {
          buffer = '';
          for (i = _i = 0, _len = array.length; _i < _len; i = ++_i) {
            item = array[i];
            item.ticks = [];
            for (i = _j = 0; _j < 6; i = ++_j) {
              item.ticks.push(i);
            }
            buffer += options.fn(item);
          }
          return buffer;
        } else {
          return options.elseFn();
        }
      };

      GraphTimeline.prototype.calculateDayOffset = function(start, target) {
        return (target.getTime() - start.getTime()) / DAY_TO_MILLISECONDS;
      };

      GraphTimeline.prototype.calculateOffset = function(start, target) {
        var epochDiff, px;
        epochDiff = this.calculateDayOffset(start, target);
        px = -(PX_PER_DAY * epochDiff) - 75;
        return px;
      };

      GraphTimeline.prototype.getMonth = function(date) {
        return this.months[date.getMonth()];
      };

      GraphTimeline.prototype.getYear = function(date) {
        return date.getFullYear();
      };

      GraphTimeline.prototype.getDate = function(date) {
        return date.getDate();
      };

      GraphTimeline.prototype.getDay = function(date) {
        var dayVal;
        dayVal = date.getDay() - 1;
        if (dayVal < 0) {
          dayVal = 6;
        }
        return this.days[dayVal];
      };

      GraphTimeline.prototype.countMilli = function(days) {
        return DAY_TO_MILLISECONDS * days;
      };

      GraphTimeline.prototype.readableDate = function(date) {
        return "" + (this.getDay(date)) + " " + (this.getMonth(date)) + " " + (this.getDate(date)) + " " + (this.getYear(date));
      };

      GraphTimeline.prototype.adjust = function(ww, wh) {
        this.ww = ww;
        this.wh = wh;
      };

      GraphTimeline.prototype.updateTransform = function(x, left, right, dx) {
        var values;
        if (dx > 0 && right > (this.ww - 175)) {
          this.OFFSET += -(right - this.ww) - 175;
        } else if (dx < 0 && left < 250) {
          this.OFFSET -= -(left + 50);
        }
        values = ["" + this.OFFSET + "px", 0, 0].join(', ');
        this.$el.css({
          '-webkit-transform': "translate3d(" + values + ")"
        });
        return BU.EventBus.trigger('offset-timeline', values);
      };

      GraphTimeline.prototype.plotRanges = function(ranges, caller) {
        var r, range, response, width, x, _i, _len;
        response = [];
        for (r = _i = 0, _len = ranges.length; _i < _len; r = ++_i) {
          range = ranges[r];
          x = this.grid[range[0].getTime()] - this.grid[this.currentTime] + 50;
          width = this.grid[range[1].getTime()] - this.grid[this.currentTime] - x + 50;
          response.push({
            x: x,
            width: width,
            value: range[2]
          });
        }
        return BU.EventBus.trigger('percentage-points-calculated', response, caller);
      };

      return GraphTimeline;

    })(Backbone.View);
  });

}).call(this);
