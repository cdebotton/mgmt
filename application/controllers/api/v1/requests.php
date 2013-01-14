<?php

use User\Pdo\Request as Request;

class Api_V1_Requests_Controller extends Api_V1_Base_Controller
{
	public $restful = true;

	public function __construct()
	{
		parent::__construct();
		$this->filter('before', 'deny-non-async');
	}

	final public function post_index()
	{
		$input = Input::json();
		$request = new Request;
		$request->user_id = Auth::user()->id;
		$request->start_date = $input->start_date;
		$request->end_date = $input->end_date;
		$request->type = $input->type;
		$request->message = $input->message;
		$request->save();

		return Response::json($request->to_array());
	}
}
