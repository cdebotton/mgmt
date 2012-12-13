<?php
	class Admin_Dashboard_Controller extends Admin_Base_Controller {

		public $restful = true;

		public function get_index ()
		{
			return View::make('admin::dashboard.index');
		}

	}