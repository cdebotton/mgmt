// Generated by CoffeeScript 1.4.0
(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'views/dashboard/pdo-request'], function(Backbone, ns) {
    ns('United.Views.Dashboard.Dashboard');
    return United.Views.Dashboard.Dashboard = (function(_super) {
      var LIST_OPEN, REQUEST_OPEN;

      __extends(Dashboard, _super);

      function Dashboard() {
        this.showRequests = __bind(this.showRequests, this);

        this.createNewPdo = __bind(this.createNewPdo, this);
        return Dashboard.__super__.constructor.apply(this, arguments);
      }

      REQUEST_OPEN = false;

      LIST_OPEN = false;

      Dashboard.prototype.el = '#dashboard-container';

      Dashboard.prototype.events = {
        'click #request-time-off': 'createNewPdo',
        'click #request-counter': 'showRequests'
      };

      Dashboard.prototype.initialize = function() {
        this.model.get('session').on('add:requests', this.updateRequests, this);
        this.model.get('session').on('remove:requests', this.updateRequests, this);
        United.JST.Hb.registerHelper('getYear', this.getYear);
        United.JST.Hb.registerHelper('getMonth', this.getMonth);
        United.JST.Hb.registerHelper('getDate', this.getDate);
        return United.EventBus.on('request-closed', this.requestClosed, this);
      };

      Dashboard.prototype.createNewPdo = function(e) {
        this.model.get('session').get('requests').add({});
        this.requestView = new United.Views.Dashboard.PdoRequest({
          model: this.model.get('session').get('requests').last(),
          open: REQUEST_OPEN
        });
        REQUEST_OPEN = true;
        return e.preventDefault();
      };

      Dashboard.prototype.updateRequests = function(model) {
        return this.$('#request-counter .badge').html(this.model.get('session').get('requests').length);
      };

      Dashboard.prototype.getYear = function(date) {
        return date.getFullYear();
      };

      Dashboard.prototype.getMonth = function(date) {
        return parseInt(date.getMonth()) + 1;
      };

      Dashboard.prototype.getDate = function(date) {
        return date.getDate();
      };

      Dashboard.prototype.requestClosed = function() {
        return REQUEST_OPEN = false;
      };

      Dashboard.prototype.showRequests = function(e) {
        var view;
        view = new United.Views.Dashboard.RequestList({
          model: this.model.get('session'),
          open: LIST_OPEN
        });
        LIST_OPEN = true;
        return e.preventDefault();
      };

      return Dashboard;

    })(Backbone.View);
  });

}).call(this);
