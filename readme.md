# ヾ(＠⌒ー⌒＠)ノ ella
Management software for Brooklyn United by [Christian de Botton](mailto:debotton@brooklynunited.com).

## admin

### features
As of right now, e has three core functions: scheduling, project management, and control/reviewing of paid days off.

#### project management
Projects can be created, and within each project, specific tasks/jobs can be created. Clients are assigned in this panel. While typing the name of a client, a context menu will appear with possible suggestions (based on existing clients). If you choose an existing client, no new client entry will be created. If you choose to not use a suggested option, a new client entry will be created and added to the pool of potential clients.

#### scheduling
Within schedules, you can manage the specific timelines of any staff. Within the navigation, you can create new tasks, and edit within the modal. These tasks can be assigned, revised, and destroyed.

#### paid days off
From the users tab, paid days off can be adjusted. Vacation days used can also be tracked.

## user access

Users have a *dashboard* and access to their own *profile* and *schedule*. All previously mentioned functionality is not visible to non-administrative users.

## about the software
For anyone who may potentially modify this software, here is some information about how it was built.

### php
- Laravel 3.2
	- Authorized Zend Acl Bundle
	- Anbu for diagnostics
	- Swiftmailer for notifications
	- Debug, a custom bundle for debugging objects/arrays.

### javascript
- RequireJS for async loading and compilation
	- text! plugin
	- almond.js for minification AMD library.
- jQuery to power backbone.
	- jQuery.animation for CSS3 animations.
	- jQuery.cookie for storing user tokens.
	- Mousetrap for complex keypress events.
- Raphael.js
	-Morris.js for graphing
- Backbone 0.9.9
	- BackboneRelational 0.7.0 (Custom AMD Fork)
- CoffeeScript
- Handlebars.js for templating
- Underscore.js to power backbone, heavily used within modules
The JavaScript framework makes use of the `JST` and `namespace` patterns. All modules are globally namespaced in a structure that mirrors the folder structure, all templates are compiled in one AMD Module.

### sass
- 960grid.sass for grids
- Twitter Bootstrap used for badges, navbar, labels, and buttons.
Styling done in *.sass, NOT *.scss

### in the future
1. Move the application to work on a router.
2. Change schedule view to work on a three tabbed scale instead of a fluid slider (week-month-year views).
3. Custom dropdowns with sorting/filtering functionality instead of HTML5 dropdowns.
4. Tie schedule/task editor to the user-row within the GUI.