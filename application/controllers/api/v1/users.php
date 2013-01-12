<?php

class Api_V1_Users_Controller extends Base_Controller
{
	public $restful = true;

	public function __construct()
	{
		parent::__construct();
		$this->filter('before', 'deny-non-async');
	}

	final public function get_update($id)
	{
		$today = date('Y-m-d');
		$user = User::with(array('roles', 'disciplines', 'tasks.project', 'tasks.project.client', 'tasks' => function($query) use($today)
			{
				$query->where('start_date', '<=', $today)
					->where('end_date', '>=', $today);
			}))->find($id);
		return eloquent_to_json($user);
	}

	final public function post_index()
	{
		$input = Input::json();
		$user = new User;
		$user->first_name = $input->first_name;
		$user->last_name = $input->last_name;
		$user->email = $input->email;
		$user->hired_on = $input->hired_on;
		$user->pdo_allotment = '20';
		$user->save();

		$today = date('Y-m-d');
		$resp = User::with(array('roles', 'disciplines', 'tasks.project', 'tasks.project.client', 'tasks' => function($query) use($today)
		{
			$query->where('start_date', '<=', $today)
				->where('end_date', '>=', $today);
		}))->first();

		return Response::json($resp->to_array());
	}

	final public function put_update($id)
	{
		$input = Input::json();
		$user = User::find($input->id);
		$user->first_name = $input->first_name;
		$user->last_name = $input->last_name;
		$user->email = $input->email;
		$user->hired_on = $input->hired_on;
		$user->pdo_allotment = $input->pdo_allotment;
		$user->save();

		$today = date('Y-m-d');
		$resp = User::with(array('roles', 'disciplines', 'tasks.project', 'tasks.project.client', 'tasks' => function($query) use($today)
		{
			$query->where('start_date', '<=', $today)
				->where('end_date', '>=', $today);
		}))->first();

		return Response::json($resp->to_array());
	}

	final public function delete_update($id)
	{
		User::find($id)->delete();
	}
}
