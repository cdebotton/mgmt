<?php

use User\Pdo\Request as Request;

class Requests_Controller extends Base_Controller
{
	public function __construct()
	{
		parent::__construct();
		if (!Auth::user()->has_role('admin')) {
			return Redirect::to_action('');
		}
	}

	public function get_index()
	{
		$requests = Request::with('user')->get();
		return View::make('requests.index')
			->with('requests', eloquent_to_json($requests));
	}
}
