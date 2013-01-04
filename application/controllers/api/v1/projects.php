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
		$project 		= new Project;
		$project->name 	= $input->name;
		$project->code 	= $input->code;
		$project->save();
		$input->id = $project->id;
		
		if (!empty($input->tasks)) {
			foreach ($input->tasks as $i => $obj) {
				$task = new Task;
				$task->author_id	= $obj->author_id;
				$task->end_date		= $obj->end_date;
				$task->start_date	= $obj->start_date;
				$task->name			= $obj->name;
				$task->color 		= $obj->color;
				$task->user_id 		= $obj->user_id;
				$task->percentage 	= $obj->percentage;
				$task->track 		= $obj->track;
				$task->project_id 	= $project->id;
				$task->save();
				$input->tasks[$i] 	= $task->to_array();
			}
		}
		return Response::json($input);
	}
}