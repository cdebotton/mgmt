<?php

class Api_V1_Session_Controller extends Base_Controller
{
	public $restful = true;

	public final function get_index ()
	{
		if (Auth::guest()) {
			return Response::json('failed', 500);
		}

		$uid = Auth::user()->id;

		$user = User::with(array('roles'))
			->find($uid);

		return Response::json($user->to_array());
	}
}