// Generated by CoffeeScript 1.4.0
(function() {

  requirejs.config({
    locale: 'en-us',
    urlArgs: "xcache=" + ((new Date()).getTime()),
    baseUrl: '/js',
    paths: {
      'jquery': 'vendors/jquery/jquery',
      'backbone': 'vendors/backbone/backbone',
      'relational': 'vendors/backbone/backbone.relational',
      'underscore': 'vendors/underscore/underscore',
      'handlebars': 'vendors/handlebars/handlebars',
      'modernizr': 'vendors/modernizr/modernizr',
      'text': 'vendors/requirejs/text',
      'templates': '../handlebars',
      'ns': 'lib/ns',
      'jst': 'lib/jst',
      'animate': 'vendors/jquery/jquery.animate-enhanced',
      'affix': 'vendors/bootstrap/bootstrap-affix',
      'alert': 'vendors/bootstrap/bootstrap-alert',
      'button': 'vendors/bootstrap/bootstrap-button',
      'carousel': 'vendors/bootstrap/bootstrap-carousel',
      'dropdown': 'vendors/bootstrap/bootstrap-dropdown',
      'modal': 'vendors/bootstrap/bootstrap-modal',
      'popover': 'vendors/bootstrap/bootstrap-popover',
      'scrollspy': 'vendors/bootstrap/bootstrap-scrollspy',
      'tab': 'vendors/bootstrap/bootstrap-tab',
      'tooltip': 'vendors/bootstrap/bootstrap-tooltip',
      'transition': 'vendors/bootstrap/bootstrap-transition',
      'typeahead': 'vendors/bootstrap/bootstrap-typeahead'
    },
    shim: {
      'backbone': {
        deps: ['jquery', 'underscore'],
        exports: 'Backbone',
        init: function() {
          return Backbone.noConflict();
        }
      },
      'relational': {
        deps: ['backbone'],
        exports: 'Backbone.RelationalModel',
        init: function(Backbone) {
          return Backbone.noConflict();
        }
      },
      'jquery': {
        exports: '$',
        init: function() {
          return $.noConflict();
        }
      },
      'underscore': {
        exports: '_',
        init: function() {
          return _.noConflict();
        }
      },
      'handlebars': {
        exports: 'Handlebars'
      },
      'animate': {
        deps: ['jquery'],
        exports: '$.fn.animate'
      },
      'affix': {
        deps: ['jquery']
      },
      'alert': {
        deps: ['jquery']
      },
      'button': {
        deps: ['jquery']
      },
      'carousel': {
        deps: ['jquery']
      },
      'dropdown': {
        deps: ['jquery']
      },
      'modal': {
        deps: ['jquery']
      },
      'popover': {
        deps: ['jquery']
      },
      'scrollspy': {
        deps: ['jquery']
      },
      'tab': {
        deps: ['jquery']
      },
      'tooltip': {
        deps: ['jquery']
      },
      'transition': {
        deps: ['jquery']
      },
      'typeahead': {
        deps: ['jquery']
      }
    }
  });

  require(['views/app', 'models/app'], function() {
    var key, key2, task, user, _ref, _ref1;
    _ref = window.users;
    for (key in _ref) {
      user = _ref[key];
      _ref1 = user.tasks;
      for (key2 in _ref1) {
        task = _ref1[key2];
        task.start_date = new Date(task.start_date);
        task.start_date.setHours(0, 0, 0, 0);
        task.end_date = new Date(task.end_date);
        task.end_date.setHours(0, 0, 0, 0);
      }
    }
    return window.BUScheduler = new BU.View.App({
      model: new BU.Model.App({
        users: window.users
      })
    });
  });

}).call(this);
