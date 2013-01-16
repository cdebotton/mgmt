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

		$accrued_days = $user->accrued_pdos() - $user->pdos_used();
		if ($accrued_days > $user->pdo_allotment) $accrued_days = $user->pdo_allotment;

		return View::make('dashboard.index')
			->with('user', $user)
			->with('accrued_days', $accrued_days);
	}

}
