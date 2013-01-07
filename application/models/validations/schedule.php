<?php

namespace Validations;

use \Laravel\Validator as Validator;

class Schedule extends Validator
{
	public static function validate_chronology ($attribute, $value, $parameters)
	{
		$start_year = Input::get('start_year');
		$start_month = (int)Input::get('start_month') + 1;
		$start_day = Input::get('start_day');
		$start_date = $start_year . '-' . $start_month . '-' . $start_day;
		$end_year = Input::get('end_year');
		$end_month = (int)Input::get('end_month') + 1;
		$end_day = Input::get('end_day');
		$end_date = $end_year . '-' . $end_month . '-' . $end_day;
		return strtotime($end_date) > strtotime($start_date);
	}
}
