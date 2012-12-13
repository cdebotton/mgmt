<?php

class Tasks_Tables_Two {
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
			$table->string('project_code', 10);
			$table->string('client');
			$table->text('description');
			$table->boolean('complete');
			$table->timestamps();
		});

		Schema::create('task_users', function ($table)
		{
			$table->increments('id');
			$table->integer('task_id');
			$table->integer('user_id');
			$table->string('percentage');
			$table->text('notes');
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
		Schema::drop('tasks_users');
	}

}