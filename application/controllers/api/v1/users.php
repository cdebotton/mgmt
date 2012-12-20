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
		$user = User::with(array('tasks', 'roles'))->find($id);
		return eloquent_to_json($user);		
	}
}