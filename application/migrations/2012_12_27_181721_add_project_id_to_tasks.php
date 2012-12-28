<?php

class Add_Project_Id_To_Tasks {

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('tasks', function($table)
		{
			$table->integer('project_id')->nullable();
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
			$table->drop_column('project_id');
		});
	}

}