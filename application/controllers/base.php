<?php

class Base_Controller extends Controller {
	
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

	/**
	 * Catch-all method for requests that can't be matched.
	 *
	 * @param  string    $method
	 * @param  array     $parameters
	 * @return Response
	 */
	public function __call($method, $parameters)
	{
		return Response::error('404');
	}

}