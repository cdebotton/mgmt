<?php

use Client\Project\Task as Task;
use Client\Project as Project;

class Api_V1_Projects_Controller extends Controller
{
	public $restful = true;

	public function get_index()
	{
		$projects = Project::all();

		return eloquent_to_json($projects);
	}

	public function post_index()
	{
		$input = Input::json();
		$project = new Project;
		$project->name = $input->name;
		$project->code = $input->code;
		$project->save();
		$input->id = $project->id;
		return json_encode($input);
	}
}