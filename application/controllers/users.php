<?php

class Users_Controller extends Base_Controller {

	public $restful = true;

	public function get_index()
	{
		$today = date('Y-m-d');
		$users = User::with(array('roles', 'roles.rules', 'disciplines', 'tasks.project', 'tasks.project.client', 'tasks' => function($query) use($today)
		{
			$query->where('start_date', '<=', $today)
				->where('end_date', '>=', $today);
		}))->get();

		return View::make('users.index')
			->with('users', eloquent_to_json($users));
	}

	public function get_profile()
	{
		$user = User::with(array('tasks', 'roles', 'disciplines'))
			->find(Auth::user()->id);

		return View::make('users.profile')
			->with('user', $user);
	}
}
