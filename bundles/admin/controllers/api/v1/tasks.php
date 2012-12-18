<?php

use Client\Project\Task as Task;

class Admin_Api_V1_Tasks_Controller extends Controller {
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
		$task->client				= $json->client;
		$task->end_date				= $json->end_date;
		$task->start_date			= $json->start_date;
		$task->name					= $json->name;
		$task->project_code			= $json->project_code;
		$task->track				= $json->track;
		$task->color 				= $json->color;
		$task->save();

		$task->users()->attach($json->user_id);

		$user = Task::find($task->id)
				->users()
				->where_user_id($json->user_id)
				->first();

		if ($user) {
			$user->pivot->percentage = $json->percentage;
			$user->pivot->save();
		}
		
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
		$task->client				= $json->client;
		$task->end_date				= $json->end_date;
		$task->start_date			= $json->start_date;
		$task->name					= $json->name;
		$task->project_code			= $json->project_code;
		$task->track				= $json->track;
		$task->color 				= $json->color;
		$task->save();

		if (isset($json->user_id)) {
			$task->users()->sync(array($json->user_id));

			$user = Task::find($id)
				->users()
				->where_user_id($json->user_id)
				->first();

			if ($user) {
				$user->pivot->percentage = $json->percentage;
				$user->pivot->save();
			}
		} 

		return Response::json($task);
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

	}

	final public function get_test($id, $user_id)
	{
		$user = Task::find($id)
			->users()
			->where_user_id($user_id)
			->first();

		$user->pivot->percentage = 75;
		$user->pivot->save();
		

		return json_encode($user);
	}
}