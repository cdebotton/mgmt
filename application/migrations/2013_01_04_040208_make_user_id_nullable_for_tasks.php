<?php

class Make_User_Id_Nullable_For_Tasks {

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('tasks', function($table)
		{
			$table->drop_column('user_id');
			
		});

		Schema::table('tasks', function($table)
		{
			$table->integer('user_id')->nullable();
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
			$table->drop_column('user_id');
			
		});
		
		Schema::table('tasks', function($table)
		{
			$table->integer('user_id');
		});
	}

}