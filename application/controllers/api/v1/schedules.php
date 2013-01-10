<?php

use Client\Project as Project;
use Client\Project\Task as Task;

class Api_V1_Schedules_Controller extends Controller {
	public $restful = true;

	public function __construct()
	{
		parent::__construct();
		$this->filter('before', 'deny-non-async');
	}

	final public function get_index()
	{
		$tasks = Task::with('users')->get();
		return eloquent_to_json($tasks);
	}

	final public function post_index()
	{
		$json = Input::json();
		$input = get_object_vars($json);
		Input::replace($input);

		if (!($errors = Task::is_valid($input))) {
			return Response::json($errors);
		}

		$task = new Task();

		$task->author_id			= $json->author_id;
		$task->end_date				= $json->end_date;
		$task->start_date			= $json->start_date;
		$task->name					= $json->name;
		$task->color 				= $json->color;
		$task->user_id 				= $json->user_id;
		$task->percentage 			= $json->percentage;
		$task->track 				= $json->track;
		$task->save();

		$json->id = $task->id;
		return Response::json($json, 200);
	}

	public function put_update($id)
	{
		$task = Task::find($id);
		$json = Input::json();

		if(preg_match('/^(\d{4}\-\d{2}\-\d{2})/', $json->start_date, $matches)) {
			$json->start_date = $matches[1];
		}
		if(preg_match('/^(\d{4}\-\d{2}\-\d{2})/', $json->end_date, $matches)) {
			$json->end_date = $matches[1];
		}

		$task->author_id			= $json->author_id;
		$task->end_date				= $json->end_date;
		$task->start_date			= $json->start_date;
		$task->name					= $json->name;
		$task->color 				= $json->color;
		$task->user_id 				= $json->user_id;
		$task->percentage 			= $json->percentage;
		$task->track 				= $json->track;
		$task->save();

		$response = Task::with(array('project', 'project.client'))
			->where_id($id)
			->first();

		return Response::json($response->to_array());
	}

	final public function get_read($id)
	{
		$task = Task::with('users')
			->find($id);

		if(!$task) {
			return Response::error('404');
		}

		return json_encode($task->to_array());
	}

	final public function delete_index($id)
	{
		Task::delete('id');
	}

	final public function get_unassigned()
	{
		$tasks = Task::with(array('project', 'project.client'))
			->where_null('user_id')
			->get();
		$response = array('sources' => array());
		foreach ($tasks as $task) {
			if (isset($task->project) && isset($task->project->name)) {
				$task->name = $task->project->code . ' - ' . $task->name;
			}
			array_push($response['sources'], $task->to_array());
		}
		return Response::json($response);
	}
}
