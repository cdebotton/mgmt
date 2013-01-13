<?php

class Create_Pdo_Adjustments_Table {

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		SchemaEnhanced::create('pdo_adjustments', function($table){
			$table->increments('id');
			$table->integer('authorized_by');
			$table->integer('user_id');
			$table->date('effective_date');
			$table->integer('pdo_allotment');
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
		Schema::drop('pdo_adjustments');
	}

}
