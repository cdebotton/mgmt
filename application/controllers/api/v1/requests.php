<?php

class Api_V1_Requests_Controller extends Base_Controller
{
	public $restful = true;

	public function __construct()
	{
		parent::__construct();
		$this->filter('before', 'deny-non-async');
	}

	final public function post_index()
	{

	}
}
