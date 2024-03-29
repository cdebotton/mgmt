// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'jst'], function(Backbone, ns) {
    ns('United.Views.Tasks.TaskElement');
    return United.Views.Tasks.TaskElement = (function(_super) {
      var DAY_TO_MILLISECONDS, PX_PER_DAY;

      __extends(TaskElement, _super);

      function TaskElement() {
        this.updateColor = __bind(this.updateColor, this);

        this.editModal = __bind(this.editModal, this);

        this.scrubStop = __bind(this.scrubStop, this);

        this.scrubMove = __bind(this.scrubMove, this);

        this.scrubStart = __bind(this.scrubStart, this);

        this.render = __bind(this.render, this);

        this.selectTask = __bind(this.selectTask, this);
        return TaskElement.__super__.constructor.apply(this, arguments);
      }

      DAY_TO_MILLISECONDS = 86400000;

      PX_PER_DAY = 41;

      TaskElement.prototype.tagName = 'div';

      TaskElement.prototype.className = 'task-element';

      TaskElement.prototype.events = {
        'mousedown .grip': 'scrubStart',
        'mousedown': 'scrubStart',
        'click .icon-edit': 'editModal'
      };

      TaskElement.prototype.initialize = function() {
        var _ref, _ref1, _ref2;
        this.body = $('body');
        United.JST.Hb.registerHelper('formatDate', this.formatDate);
        United.JST.Hb.registerHelper('clientName', this.clientName);
        this.start = this.model.get('start_date');
        this.end = this.model.get('end_date');
        this.model.on('change:color', this.updateColor, this);
        this.model.on('change:name change:percentage', this.render, this);
        if (United.Models.Users.Session.isAdmin() && (this.options.demo != null) !== true) {
          United.EventBus.on('start-drag', this.setOpacity, this);
          United.EventBus.on('stop-drag', this.unsetOpacity, this);
          United.JST.Hb.registerHelper('projectCode', this.projectCode);
          this.body.on('mousemove', this.scrubMove);
          this.body.on('mouseup', this.scrubStop);
          this.model.on('change:end_date', this.updatePositions, this);
          this.model.on('change:start_date', this.updatePositions, this);
          this.model.on('change:track', this.updatePositions, this);
          if ((_ref = this.model.get('project')) != null) {
            _ref.on('change:code', this.render, this);
          }
          if ((_ref1 = this.model.get('project')) != null) {
            if ((_ref2 = _ref1.get('client')) != null) {
              _ref2.on('change:name', this.render, this);
            }
          }
        } else if ((this.options.demo != null) === true) {
          this.$el.addClass('selectable');
          this.$el.on('click', this.selectTask);
          United.EventBus.on('edit-project-task', this.taskSelected, this);
        } else {
          this.$el.addClass('no-drag');
        }
        United.EventBus.on('zoom-grid-updated', this.updateZoom, this);
        United.EventBus.on('offset-timeline', this.offsetTimeline, this);
        if (this.model.get('color') !== null) {
          this.$el.addClass(this.model.get('color'));
        }
        return United.EventBus.on('gridpoint-dispatch', this.gridPointsReceived, this);
      };

      TaskElement.prototype.selectTask = function(e) {
        United.EventBus.trigger('edit-task-element', this.cid);
        United.EventBus.trigger('load-task-in-editor', this.model);
        return e.preventDefault();
      };

      TaskElement.prototype.taskSelected = function(cid) {
        if (cid === this.cid) {
          return this.$el.addClass('selected');
        } else {
          return this.$el.removeClass('selected');
        }
      };

      TaskElement.prototype.render = function() {
        var ctx, html, _ref, _ref1;
        United.EventBus.trigger('where-am-i', this.cid, this.start, this.end);
        United.EventBus.trigger('percentage-changed');
        ctx = this.model.toJSON();
        if ((ctx.project = (_ref = this.model.get('project')) != null ? _ref.toJSON() : void 0)) {
          if (this.model.get('project').get('client')) {
            ctx.project.client = this.model.get('project').get('client').toJSON();
          }
        }
        ctx.demo = ((_ref1 = this.options) != null ? _ref1.demo : void 0) === true;
        ctx.isAdmin = United.Models.Users.Session.isAdmin();
        html = United.JST['TaskElement'](ctx);
        this.$el.html(html);
        return this;
      };

      TaskElement.prototype.updatePositions = function(model) {
        this.start = this.model.get('start_date');
        this.end = this.model.get('end_date');
        United.EventBus.trigger('where-am-i', this.cid, this.start, this.end);
        return this.render();
      };

      TaskElement.prototype.gridPointsReceived = function(cid, p1, p2, offset) {
        var dx, width;
        if (cid !== this.cid) {
          return false;
        }
        dx = p1;
        width = p2 - p1;
        return this.$el.css({
          marginLeft: dx,
          width: width,
          marginTop: 10 + this.model.get('track') * 60,
          '-webkit-transform': "translate3d(" + offset + "px, 0, 0)"
        });
      };

      TaskElement.prototype.scrubStart = function(e) {
        var obj;
        if (!United.Models.Users.Session.isAdmin()) {
          return false;
        }
        if (e.which !== 1) {
          return false;
        }
        United.EventBus.trigger('start-drag', this.model.get('id'));
        this.dragging = true;
        obj = $(e.currentTarget);
        this.property = (function() {
          switch (1 === 1) {
            case obj.hasClass('left'):
              return ['start_date'];
            case obj.hasClass('right'):
              return ['end_date'];
            default:
              return ['start_date', 'end_date'];
          }
        })();
        this.initX = e.pageX;
        e.stopImmediatePropagation();
        return e.preventDefault();
      };

      TaskElement.prototype.scrubMove = function(e) {
        var date, days, dx, epoch, key, left, property, right, targetTrack, units, updateObject, _i, _len, _ref;
        if (!United.Models.Users.Session.isAdmin()) {
          return false;
        }
        if (!this.dragging) {
          return false;
        }
        updateObject = {
          start_date: this.model.get('start_date'),
          end_date: this.model.get('end_date'),
          track: this.model.get('track')
        };
        if (this.property.length > 1) {
          targetTrack = Math.floor((e.pageY - this.$el.parent().offset().top) / 48);
          if (targetTrack !== updateObject.track) {
            updateObject.track = targetTrack;
          }
        }
        dx = e.pageX - this.initX;
        if (Math.abs(dx) > PX_PER_DAY) {
          units = Math.round(dx / PX_PER_DAY);
          days = DAY_TO_MILLISECONDS * units;
          this.initX = e.pageX;
          _ref = this.property;
          for (key = _i = 0, _len = _ref.length; _i < _len; key = ++_i) {
            property = _ref[key];
            date = this.model.get(property);
            epoch = date.getTime();
            epoch += days;
            date = new Date(epoch);
            if (updateObject[property] !== date) {
              updateObject[property] = date;
            }
          }
        }
        this.model.set(updateObject);
        left = this.$el.offset().left;
        right = left + this.$el.outerWidth();
        return United.EventBus.trigger('update-timeline-transform', e.pageX, left, right, dx);
      };

      TaskElement.prototype.scrubStop = function(e) {
        if (!United.Models.Users.Session.isAdmin()) {
          return false;
        }
        if (this.dragging) {
          United.EventBus.trigger('stop-drag', this.model.get('id'));
          this.dragging = false;
          this.property = void 0;
          this.initX = 0;
          return this.model.save();
        }
      };

      TaskElement.prototype.setOpacity = function(id) {
        if (id !== this.model.get('id')) {
          return this.$el.css('opacity', 0.35);
        }
      };

      TaskElement.prototype.unsetOpacity = function(id) {
        if (id !== this.model.get('id')) {
          return this.$el.css('opacity', 1);
        }
      };

      TaskElement.prototype.formatDate = function(date) {
        var months;
        months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
        return new Handlebars.SafeString("" + months[date.getMonth()] + ". " + (date.getDate()) + ", " + (date.getFullYear()));
      };

      TaskElement.prototype.offsetTimeline = function(dx) {
        return this.$el.css({
          '-webkit-transform': "translate3d(" + dx + ")"
        });
      };

      TaskElement.prototype.editModal = function(e) {
        if (!United.Models.Users.Session.isAdmin()) {
          return false;
        }
        United.EventBus.trigger('open-modal', this.model);
        return e.preventDefault();
      };

      TaskElement.prototype.updateColor = function() {
        if (!United.Models.Users.Session.isAdmin()) {
          return false;
        }
        return this.$el[0].className = "task-element " + (this.model.get('color'));
      };

      TaskElement.prototype.updateZoom = function(zoom) {
        return United.EventBus.trigger('where-am-i', this.cid, this.model.get('start_date'), this.model.get('end_date'));
      };

      return TaskElement;

    })(Backbone.View);
  });

}).call(this);
