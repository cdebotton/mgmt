<?php

use Client\Project as Project;
use Client\Project\Task as Task;

class Projects_Controller extends Base_Controller
{
	public $restful = true;

	public function get_index()
	{
		return View::make('projects.index');
	}
}