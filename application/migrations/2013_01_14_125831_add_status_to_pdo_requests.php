<?php

class Add_Status_To_Pdo_Requests {

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pdo_requests', function($table)
		{
			$table->boolean('status')->defaults(false);
		});
	}

	/**
	 * Revert the changes to the database.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::table('pdo_requests', function($table)
		{
			$table->drop_column('status');
		});
	}

}
