<?php

class Api_V1_Base_Controller extends Base_Controller
{
	public function __construct()
	{
		parent::__construct();
		$this->filter('before', 'api');
	}
}
