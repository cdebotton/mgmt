<?php

class Users_Controller extends Base_Controller {

	public $restful = true;

	public function get_index ()
	{
		$users = User::all();
		return View::make('users.index')
			->with('users', $users);
	}

}