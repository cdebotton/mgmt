// Generated by CoffeeScript 1.4.0
(function() {
  var __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  define(['backbone', 'ns', 'morris'], function(Backbone, ns, Morris) {
    ns('United.Views.Dashboard.PdoGraph');
    return United.Views.Dashboard.PdoGraph = (function(_super) {

      __extends(PdoGraph, _super);

      function PdoGraph() {
        return PdoGraph.__super__.constructor.apply(this, arguments);
      }

      PdoGraph.prototype.el = '#pdo-graph';

      PdoGraph.prototype.initialize = function() {
        return this.render();
      };

      PdoGraph.prototype.render = function() {
        var data, date, json, pdos;
        json = window.jsonPdoGrid;
        data = [];
        for (date in json) {
          pdos = json[date];
          data.push({
            q: date,
            a: pdos.pdo_count,
            b: pdos.pdo_credit.toFixed(2)
          });
        }
        return Morris.Line({
          element: 'pdo-graph',
          data: data,
          xkey: 'q',
          ykeys: ['a', 'b'],
          labels: ['Accrued', 'Rate'],
          lineColors: ['#3a87ad', '#b4d5e6'],
          lineWidth: 2,
          dateFormat: function(x) {
            date = new Date(x);
            return "" + (date.getFullYear()) + "-" + (date.getMonth() + 1);
          },
          xLabels: 'month',
          smooth: false
        });
      };

      return PdoGraph;

    })(Backbone.View);
  });

}).call(this);
