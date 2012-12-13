<?php

class Admin_Users_Controller extends Admin_Base_Controller {

	public $restful = true;

	public function get_index ()
	{
		$users = User::all();
		return View::make('admin::users.index')
			->with('users', $users);
	}

}