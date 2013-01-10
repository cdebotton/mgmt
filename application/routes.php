<?php

/**
 * Add assets to containers.
 */
Asset::add('styles', 'css/bu.sched.css');

/**
 * Handle all non-standard routes once logged in.
 */
Route::group(array('before' => 'admin-auth|page-title'), function ()
{
	Route::controller(Controller::detect());
	Route::get('/', 'dashboard@index');
	Route::get('profile', 'users@profile');
});

/**
 * Route log-in and log-out actions.
 */
Route::get('login', function ()
{
	if (!Auth::guest()) return Redirect::to_action('dashboard@index');
	Section::inject('title', 'Login | BU Scheduling');
	return View::make('dashboard.login');
});

Route::post('login', function ()
{
	$data = array(
		'username' => Input::get('email'),
		'password' => Input::get('password')
	);
	if (Auth::attempt($data)) {
		$user = Auth::user();
		$user->last_login = date('Y-m-d h:m:g');
		$user->save();
		return Redirect::to_action('dashboard@index');
	}
	else {
		return Redirect::back()
			->with_input();
	}
});

Route::get('logout', function ()
{
	Auth::logout();
	return Redirect::to('login');
});

/**
 * Route filters.
 */

Route::filter('admin-auth', function ()
{
	if(Auth::guest()) return Redirect::to('login');
});

Route::filter('page-title', function ()
{
	$uri = explode('/', URI::current());
	$len = count($uri);
	$title = 'Brooklyn United Management';
	if ($len === 2) {
		$title = ucwords($uri[1] . ' ' . Str::singular($uri[0])) . ' | ' . $title;
	}
	elseif ($len === 1) {
		$title = ucwords($uri[0]) . ' | ' . $title;
	}
	Section::inject('currentController', $uri[0]);
	Section::inject('title', $title);
});

Route::filter('deny-non-async', function ()
{
	#if (!Request::ajax() || Auth::guest() || !Auth::user()->has_role('admin')) {
	#	return Response::error('500');
	#}
});

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Simply tell Laravel the HTTP verbs and URIs it should respond to. It is a
| breeze to setup your application using Laravel's RESTful routing and it
| is perfectly suited for building large applications and simple APIs.
|
| Let's respond to a simple GET request to http://example.com/hello:
|
|		Route::get('hello', function()
|		{
|			return 'Hello World!';
|		});
|
| You can even respond to more than one URI:
|
|		Route::post(array('hello', 'world'), function()
|		{
|			return 'Hello World!';
|		});
|
| It's easy to allow URI wildcards using (:num) or (:any):
|
|		Route::put('hello/(:any)', function($name)
|		{
|			return "Welcome, $name.";
|		});
|
*/

Event::listen('404', function()
{
	return Response::error('404');
});

Event::listen('500', function()
{
	return Response::error('500');
});

Route::filter('before', function()
{
	// Do stuff before every request to your application...
});

Route::filter('after', function($response)
{
	// Do stuff after every request to your application...
});

Route::filter('csrf', function()
{
	if (Request::forged()) return Response::error('500');
});

Route::filter('auth', function()
{
	if (Auth::guest()) return Redirect::to('login');
});
