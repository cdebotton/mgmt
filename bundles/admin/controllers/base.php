<?php

class Admin_Base_Controller extends Base_Controller {
	public $navigation = array(
		'Dashboard' => array(
			'icon' => 'icon-home',
			'action' => 'admin::dashboard'
			),
		'Tasks' => array(
			'icon' => 'icon-wrench',
			'action' => 'admin::tasks'
			),
		'Users' => array(
			'icon' => 'icon-user',
			'action' => 'admin::users'
			)
		);

	public function __construct ()
	{
		parent::__construct();
	}
}