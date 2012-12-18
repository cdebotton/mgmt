({
	baseUrl: '.',
	name: 'main',
	out: 'min.js',
	preserveLicenseComments: false,
	include: 'almond',
	paths: {
		"jquery": "vendors/jquery/jquery",
		"backbone": "vendors/backbone/backbone",
		"relational": "vendors/backbone/backbone.relational",
		"underscore": "vendors/underscore/underscore",
		"handlebars": "vendors/handlebars/handlebars",
		"modernizr": "vendors/modernizr/modernizr",
		"text": "vendors/requirejs/text",
		"templates": "../handlebars",
		"ns": "lib/ns",
		"jst": "lib/jst",
		"animate": "vendors/jquery/jquery.animate-enhanced",
		"affix": "vendors/bootstrap/bootstrap-affix",
		"alert": "vendors/bootstrap/bootstrap-alert",
		"button": "vendors/bootstrap/bootstrap-button",
		"carousel": "vendors/bootstrap/bootstrap-carousel",
		"dropdown": "vendors/bootstrap/bootstrap-dropdown",
		"modal": "vendors/bootstrap/bootstrap-modal",
		"popover": "vendors/bootstrap/bootstrap-popover",
		"scrollspy": "vendors/bootstrap/bootstrap-scrollspy",
		"tab": "vendors/bootstrap/bootstrap-tab",
		"tooltip": "vendors/bootstrap/bootstrap-tooltip",
		"transition": "vendors/bootstrap/bootstrap-transition",
		"typeahead": "vendors/bootstrap/bootstrap-typeahead",
		"almond": "vendors/requirejs/almond"
	},
	shim: {
		"backbone": {
			deps: ["jquery", "underscore"],
			exports: "Backbone",
			init: function() {
				return Backbone.noConflict();
			}
		},
		"relational": {
			deps: ["backbone"],
			exports: "Backbone.RelationalModel",
			init: function(Backbone) {
				return Backbone.noConflict();
			}
		},
		"jquery": {
			exports: "$",
			init: function() {
				return $.noConflict();
			}
		},
		"underscore": {
			exports: "_",
			init: function() {
				return _.noConflict();
			}
		},
		"handlebars": {
			exports: "Handlebars"
		},
		"animate": {
			deps: ["jquery"],
			exports: "$.fn.animate"
		},
		"affix": {
			deps: ["jquery"]
		},
		"alert": {
			deps: ["jquery"]
		},
		"button": {
			deps: ["jquery"]
		},
		"carousel": {
			deps: ["jquery"]
		},
		"dropdown": {
			deps: ["jquery"]
		},
		"modal": {
			deps: ["jquery"]
		},
		"popover": {
			deps: ["jquery"]
		},
		"scrollspy": {
			deps: ["jquery"]
		},
		"tab": {
			deps: ["jquery"]
		},
		"tooltip": {
			deps: ["jquery"]
		},
		"transition": {
			deps: ["jquery"]
		},
		"typeahead": {
			deps: ["jquery"]
		}
	}
})