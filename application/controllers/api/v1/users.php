<?php

use User\Pdo\Adjustment as Adjustment;

class Api_V1_Users_Controller extends Api_V1_Base_Controller
{
	public $restful = true;

	final public function get_index($id = null)
	{
		if ($id === null and Auth::user()->has_role('admin')) {
			$users = User::all();
			return eloquent_to_json($users);
		}
		else {
			$today = date('Y-m-d');
			$user = User::with(array('roles', 'disciplines', 'tasks.project', 'tasks.project.client', 'tasks' => function($query) use($today)
				{
					$query->where('start_date', '<=', $today)
						->where('end_date', '>=', $today);
				}))->find($id);
			return Response::json($user->to_array());
		}
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

	final public function put_index($id)
	{
		$input = Input::json();
		$user = User::find($input->id);
		$user->first_name = $input->first_name;
		$user->last_name = $input->last_name;
		$user->email = $input->email;
		$user->hired_on = $input->hired_on;
		if($user->pdo_allotment === 0) {
			$user->pdo_allotment = $input->pdo_allotment;
		}
		else {
			$adjustment = new Adjustment;
			$adjustment->user_id = $user->id;
			$adjustment->authorized_by = Auth::user()->id;
			$adjustment->effective_date = date(static::$DATE_FORMAT);
			$adjustment->pdo_allotment = $input->pdo_allotment;
			$adjustment->save();
		}
		$user->save();

		$today = date('Y-m-d');
		$resp = User::with(array('roles', 'disciplines', 'tasks.project', 'tasks.project.client', 'tasks' => function($query) use($today)
		{
			$query->where('start_date', '<=', $today)
				->where('end_date', '>=', $today);
		}))->first();

		return Response::json($resp->to_array());
	}

	final public function delete_index($id)
	{
		User::find($id)->delete();
	}
}
