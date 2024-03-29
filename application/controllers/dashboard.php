<?php
use Client\Project\Task as Task;

class Dashboard_Controller extends Base_Controller {

	public $restful = true;

	public function get_index ()
	{
		$today = date('Y-m-d');
		$user = User::with(array('pdos', 'disciplines', 'adjustments', 'roles', 'tasks' => function($query) use($today)
		{
			$query->where('start_date', '<=', $today)
				->where('end_date', '>=', $today);
		}, 'requests' => function($query)
		{
			$query->where_status(false);
		}))->where_id(Auth::user()->id)
			->first();
		$pdoGrid = $user->buildPdoGrid();
		$gridKeys = array_keys($pdoGrid);
		$lastKey = $gridKeys[count($pdoGrid) - 1];
		$accrued_days = $pdoGrid[$lastKey]['pdo_count'];
		return View::make('dashboard.index')
			->with('user', $user)
			->with('accrued_days', $accrued_days)
			->with('pdo_grid', json_encode($pdoGrid));
	}

}
