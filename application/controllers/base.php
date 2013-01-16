<?php

use User\Pdo\Request as Request;

class Base_Controller extends Controller {

	/**
	 * Catch-all method for requests that can't be matched.
	 *
	 * @param  string    $method
	 * @param  array     $parameters
	 * @return Response
	 */
	static $DATE_FORMAT = 'Y-m-d';

	public $restful = true;

	public function __call($method, $parameters)
	{
		return Response::error('404');
	}


	public function __construct()
	{
		parent::__construct();
		if (Auth::user()->has_role('admin')) {
			$requests = Request::where_status(false)->count();
			Section::inject('RequestCount', $requests);
		}
	}
}
