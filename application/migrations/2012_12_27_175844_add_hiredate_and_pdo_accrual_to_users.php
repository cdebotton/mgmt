<?php

class Add_Hiredate_And_Pdo_Accrual_To_Users {

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('users', function($table)
		{
			$table->date('hired_on');
			$table->float('pdo_allotment');
		});
	}

	/**
	 * Revert the changes to the database.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('users', function($table)
		{
			$table->drop_columns(array('hired_on', 'pdo_allotment'));
		});
	}

}