<?php

class Create_Pdo_Requests_Table {

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		SchemaEnhanced::create('pdo_requests', function($table){
			$table->increments('id');
			$table->integer('user_id');
			$table->date('request_date');
			$table->date('start_date');
			$table->date('end_date');
			$table->text('reason');
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
		Schema::drop('pdo_requests');
	}

}
