<?php

class Api_V1_Session_Controller extends Api_V1_Base_Controller
{
	public $restful = true;

	public final function get_index ()
	{
		$today = date('Y-m-d');

		$user = User::with(array('pdos', 'disciplines', 'roles', 'tasks' => function($query) use($today)
		{
			$query->where('start_date', '<=', $today)
				->where('end_date', '>=', $today);
		}, 'requests' => function($query)
		{
			$query->where_status(false);
		}))->where_id(Auth::user()->id)
			->first();

		return Response::json($user->to_array());
	}
}
