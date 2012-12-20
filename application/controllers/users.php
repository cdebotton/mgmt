<?php

class Users_Controller extends Base_Controller {

	public $restful = true;

	public function get_index()
	{
		$users = User::all();
		return View::make('users.index')
			->with('users', $users);
	}

	public function get_profile()
	{
		$user = User::with(array('tasks', 'roles', 'disciplines'))
			->find(Auth::user()->id);

		return View::make('users.profile')
			->with('user', $user);
	}
}