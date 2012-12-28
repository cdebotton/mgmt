<?php

namespace Client\Project;

use Eloquent;
use Validator;
use Input;

class Task extends Eloquent
{
	protected static $validation;

	protected static $rules = array(
		'name'			=> 'required|unique:tasks',
		'client'		=> 'required',
		'project_code'	=> 'required|min:2|max:10',
		'start_date'	=> 'required|chronology',
		'end_date'		=> 'required',
		'author_id'		=> 'required|numeric',
		'developer_id'	=> 'required|numeric'
	);

	public static function is_valid(array $input)
	{
		static::$validation = Validator::make($input, static::$rules);

		if (static::$validation->fails()) {
			return static::$validation->errors;
		}

		return true;
	}

	public function user()
	{
		return $this->belongs_to('User');
	}

	public function author()
	{
		return $this->belongs_to('User', 'author_id');
	}

	public function project()
	{
		return $this->belongs_to('Client\\Project');
	}
}

Validator::register('chronology', function ($attribute, $value, $parameters)
{
	$start = Input::get('start_date');
	$end = Input::get('end_date');
	return $start < $end;
});