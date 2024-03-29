<?php

use User\Pdo\Request as Request;
use User\Pdo as Pdo;

class Api_V1_Requests_Controller extends Api_V1_Base_Controller
{
	public $restful = true;

	public function get_index($id = null)
	{
		if ($id === null) {
			$requests = Request::with('user')->get();
			return eloquent_to_json($requests);
		}
		else {
			$request = Request::with('user')->where_id($id)->first();
			return Response::json($request->to_array());
		}
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

	final public function put_index($id)
	{
		$input = Input::json();
		$request = Request::with('user')
			->where_id($id)
			->first();
		$request->status = $input->status;
		$request->save();

		$pdo = new Pdo;
		$pdo->user_id = $request->user_id;
		$pdo->start_date = $request->start_date;
		$pdo->end_date = $request->end_date;
		$pdo->save();

		return Response::json($request->to_array());
	}

	final public function delete_index($id)
	{
		$request = Request::find($id);
		$request->delete();
		return Response::json(array());
	}
}
