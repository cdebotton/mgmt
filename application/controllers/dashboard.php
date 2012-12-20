<?php
	
	use Client\Project\Task as Task;

	class Dashboard_Controller extends Base_Controller {

		public $restful = true;

		public function get_index ()
		{
			$user = User::with(array('tasks', 'roles', 'disciplines'))
				->find(Auth::user()->id);

			$today = date('Y-m-d 00:00:00');

			$currentTasks = Task::where('start_date', '<=', $today)
				->where('end_date', '>=', $today)
				->get();


			return View::make('dashboard.index')
				->with('user', $user)
				->with('currentTasks', $currentTasks);
		}

	}