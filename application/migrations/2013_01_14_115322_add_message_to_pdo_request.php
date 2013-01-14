<?php

class Add_Message_To_Pdo_Request {

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::table('pdo_requests', function($table)
		{
			$table->text('message');
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
			$table->drop_column('message');
		});
	}

}
