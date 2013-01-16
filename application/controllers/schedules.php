<?php

use User\Role as Role;
use Client\Project\Task as Task;
use User\Discipline as Discipline;
use Validations\Schedule as ScheduleValidator;

class Schedules_Controller extends Base_Controller {

	public $restful = true;

	public function get_index ()
	{
		if (Auth::user()->has_role('admin')) {
			$users = User::with(array('roles', 'tasks', 'tasks.project', 'tasks.project.client', 'disciplines', 'pdos'))
				->get();
			$roles = Role::all();
			$disciplines = Discipline::all();
			$userArray = array('null' => 'User');
			foreach($users as $u)
			{
				$userArray[$u->id] = $u->email;
			}
			$colors = array(
				'blue'		=> 'Blue',
				'red'		=> 'Red',
				'green'		=> 'Green',
				'yellow'	=> 'Yellow'
			);

			$unassignedTasks = Task::with(array('project', 'project.client'))
				->where_null('user_id')->get();

			return View::make('tasks.index')
				->with('developers', $userArray)
				->with('unassigned_tasks', eloquent_to_json($unassignedTasks))
				->with('dev_json', eloquent_to_json($users))
				->with('colors', $colors)
				->with('disciplines', $disciplines)
				->with('roles', $roles);
		}
		else {
			$users = User::with(array('roles', 'tasks', 'tasks.project', 'tasks.project.client', 'disciplines'))
				->find(Auth::user()->id);
			return View::make('tasks.index')
				->with('dev_json', json_encode(array($users->to_array())));
		}

	}

	public function get_create ()
	{
		$dates = array();

		$years = range((int) date('Y') - 10, (int) date('Y') + 10);
		$years = array_combine($years, $years);
		$dates['years'] = $years;

		$dates['months'] = array('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December');

		$days = range(1,31);
		$days = array_combine($days, $days);
		$dates['days'] = $days;

		$devs = Role::where('name', '=', 'Developer')
			->first()
			->users()
			->get();

		$userArray = array('null' => 'User');
		foreach($devs as $dev)
		{
			$userArray[$dev->id] = $dev->email;
		}

		return View::make('tasks.create')
			->with('developers', $userArray)
			->with('dates', $dates);
	}

	public function post_create ()
	{
		$rules = array(
			'name'				=> 'required|unique:tasks',
			'project_code'		=> 'required|alpha_num',
			'client'			=> 'required',
			'end_year'			=> 'chronology'
			);

		$validations = ScheduleValidator::make(Input::get(), $rules);
		if($validations->fails())
		{
			return Redirect::back()
				->with_errors($validations)
				->with_input();
		}
		else
		{
			Debug::dump(Input::get());
		}
	}

}
