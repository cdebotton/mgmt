<?php

use User\Role as Role;
use User\Discipline as Discipline;

Validator::register('chronology', function ($attribute, $value, $parameters)
{
	$start_date = Input::get('start_year') . '-' . ((int) Input::get('start_month') + 1) . '-' . Input::get('start_day');
	$end_date = Input::get('end_year') . '-' . ((int) Input::get('end_month') + 1) . '-' . Input::get('end_day');
	return strtotime($end_date) > strtotime($start_date);
});

class Schedules_Controller extends Base_Controller {

	public $restful = true;

	public function get_index ()
	{
		if (Auth::user()->has_role('admin')) {
			$developers = User::with(array('roles', 'tasks', 'disciplines'))
				->get();
			$roles = Role::all();
			$disciplines = Discipline::all();
			$userArray = array('null' => 'User');
			foreach($developers as $dev)
			{
				$userArray[$dev->id] = $dev->email;
			}
			$colors = array(
				'blue'		=> 'Blue', 
				'red'		=> 'Red',
				'green'		=> 'Green',
				'yellow'	=> 'Yellow'
			);
			return View::make('tasks.index')
				->with('developers', $userArray)
				->with('dev_json', eloquent_to_json($developers))
				->with('colors', $colors)
				->with('disciplines', $disciplines)
				->with('roles', $roles);
		}
		else {
			$developers = User::with(array('roles', 'tasks', 'disciplines'))
				->find(Auth::user()->id);
			return View::make('tasks.index')
				->with('dev_json', json_encode(array($developers->to_array())));
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

		$validations = Validator::make(Input::get(), $rules);
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