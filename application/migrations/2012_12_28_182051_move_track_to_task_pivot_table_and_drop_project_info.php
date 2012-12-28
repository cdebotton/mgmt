<?php

class Move_Track_To_Task_Pivot_Table_And_Drop_Project_Info {

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('tasks', function($table)
		{
			$table->drop_column(array('project_code', 'client', 'track', 'complete'));
		});

		Schema::table('task_user', function($table)
		{
			$table->integer('track')->default(0);
		});
	}

	/**
	 * Revert the changes to the database.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('tasks', function($table)
		{
			$table->string('project_code');
			$table->string('client');
			$table->string('track')->default(0);
			$table->boolean('complete')->default(false);
		});

		Schema::table('task_user', function($table)
		{
			$table->drop_column('track');
		});
	}

}