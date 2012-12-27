<?php

class Create_Clients_Table {

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('clients', function($table)
		{
			$table->increments('id');
			$table->string('name');
			$table->text('memo');
			$table->timestamps();
		});
	}

	/**
	 * Revert the changes to the database.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('clients');
	}

}