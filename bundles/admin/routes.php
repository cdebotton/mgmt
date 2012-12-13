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
	Route::get('(:bundle)', 'admin::dashboard@index');
	Route::controller(Controller::detect('admin'));
});

/**
 * Route log-in and log-out actions.
 */
Route::get('(:bundle)/login', function ()
{
	if (!Auth::guest()) return Redirect::to_action('admin::dashboard@index');
	Section::inject('title', 'Login | BU Scheduling');
	return View::make('admin::dashboard.login');
});

Route::post('(:bundle)/login', function ()
{
	$data = array(
		'username' => Input::get('email'),
		'password' => Input::get('password')
	);
	if (Auth::attempt($data)) {
		return Redirect::to_action('admin::dashboard@index');
	}
	else {
		return Redirect::back()
			->with_input();
	}
});

Route::get('(:bundle)/logout', function ()
{
	Auth::logout();
	return Redirect::to('admin/login');
});

/**
 * Route filters.
 */
 
Route::filter('admin-auth', function ()
{
	if(Auth::guest()) return Redirect::to('admin/login');
});

Route::filter('page-title', function ()
{
	$uri = explode('/', URI::current());
	$len = count($uri);
	$title = 'Brooklyn United Schedule Management';
	if ($len === 2) {
		$title = ucwords($uri[1] . ' ' . Str::singular($uri[0])) . ' | ' . $title;
	}
	elseif ($len === 1) {
		$title = ucwords($uri[0]) . ' | ' . $title;
	}
	Section::inject('title', $title);
});

Route::filter('deny-non-async', function ()
{
	if (!Request::ajax()) {
		return Response::error('500');
	}
});