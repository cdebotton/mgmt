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
		if ($input->client_id != null) {
			$project->client_id = $input->client_id;
		}
		elseif ($input->client_name != null) {
			$client = new Client;
			$client->name = $input->client_name;
			$client->save();
			$project->client_id = $client->id;
		}
		$project->save();
		if (isset($input->tasks)) {
			foreach ($input->tasks as $object) {
				$task = new Task;
				$task->name = $object->name;
				$task->color = $object->color;
				$task->user_id = $object->user_id;
				$task->author_id = $object->author_id;
				$task->start_date = $object->start_date;
				$task->end_date = $object->end_date;
				$task->project_id = $project->id;
				$task->save();
			}
		}

		$project = Project::with(array('tasks'))
			->where_id($project->id)
			->first();

		return Response::json($project->to_array());
	}

	public function put_update($id = null)
	{
		$input = Input::json();
		$project 		= Project::find($id);
		$project->name 	= $input->name;
		$project->code 	= $input->code;
		if ($input->client_id != null) {
			$project->client_id = $input->client_id;
		}
		elseif ($input->client_name != null) {
			$client = new Client;
			$client->name = $input->client_name;
			$client->save();
			$project->client_id = $client->id;
		}
		$project->save();
		if (isset($input->tasks)) {
			foreach ($input->tasks as $object) {
				$task = isset($object->id) ? Task::find($object->id) : new Task;
				$task->name = $object->name;
				$task->color = $object->color;
				$task->user_id = $object->user_id;
				$task->author_id = $object->author_id;
				$task->start_date = $object->start_date;
				$task->end_date = $object->end_date;
				$task->project_id = $project->id;
				$task->save();
			}
		}

		$project = Project::with(array('tasks', 'client'))
			->where_id($project->id)
			->first();
		return Response::json($project->to_array());
	}
}
