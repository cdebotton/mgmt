<?php

class Create_Tasks_Tables {
	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('tasks', function ($table)
		{
			$table->increments('id');
			$table->integer('author_id');
			$table->date('start_date');
			$table->date('end_date');
			$table->string('name');
			$table->text('description');
			$table->string('color')->nullable();
			$table->integer('track')->default(0);
			$table->integer('user_id')->nullable();
			$table->integer('project_id')->nullable();
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
		Schema::drop('tasks');
	}

}
