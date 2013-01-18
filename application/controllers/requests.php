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
		$requests = Request::with('user')
			->where_status(false)
			->get();

		$request_array = array_map(function($request)
		{
			$object = $request->to_array();
			$object['duration'] = $request->duration();
			$user = User::with('pdos')->find($request->user_id);
			$pdoGraph = $user->buildPdoGrid();
			$pdoKeys = array_keys($pdoGraph);
			$lastKey = $pdoKeys[count($pdoKeys) - 1];
			$object['user']['available_pdos'] = $pdoGraph[$lastKey]['pdo_count'];
			$object['className'] = $request->duration() > $object['user']['available_pdos'] ? ' overage' : '';
			return $object;
		}, $requests);

		return View::make('requests.index')
			->with('requests', json_encode($request_array));
	}
}
