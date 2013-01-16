<?php
use Client\Project\Task as Task;

class Dashboard_Controller extends Base_Controller {

	public $restful = true;

	public function get_index ()
	{
		$today = date('Y-m-d');

		$user = User::with(array('pdos', 'disciplines', 'roles', 'tasks' => function($query) use($today)
		{
			$query->where('start_date', '<=', $today)
				->where('end_date', '>=', $today);
		}, 'requests' => function($query)
		{
			$query->where_status(false);
		}))->where_id(Auth::user()->id)
			->first();

		$daysUsed = 0;
		$today_str = date(static::$DATE_FORMAT);
		$today = date_create_from_format(static::$DATE_FORMAT, $today_str);
		$hired_on_str = date(static::$DATE_FORMAT, strtotime($user->hired_on));
		$hired_on = date_create_from_format(static::$DATE_FORMAT, $hired_on_str);
		$date_diff = date_diff($today, $hired_on);
		$months = $date_diff->m + ($date_diff->y * 12);
		$accrued_days = $months * ($user->pdo_allotment/12);

		foreach ($user->pdos as $pdo) {
			$start_str = date(static::$DATE_FORMAT, strtotime($pdo->start_date));
			$end_str = date(static::$DATE_FORMAT, strtotime($pdo->end_date));
			$start = date_create_from_format(static::$DATE_FORMAT, $start_str);
			$end = date_create_from_format(static::$DATE_FORMAT, $end_str);
			$diff = date_diff($start, $end);
			$accrued_days -= $diff->days;
		}
		if ($accrued_days > $user->pdo_allotment) $accrued_days = $user->pdo_allotment;

		return View::make('dashboard.index')
			->with('user', $user)
			->with('accrued_days', $accrued_days);
	}

}
