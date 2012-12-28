<?php

class Add_Percentage_To_Tasks {

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('tasks', function($table)
		{
			$table->integer('percentage');
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
			$table->drop_column('percentage');
		});
	}

}