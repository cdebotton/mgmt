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
			$table->string('project_code', 10);
			$table->string('client');
			$table->text('description');
			$table->boolean('complete');
			$table->string('color')->nullable();
			$table->integer('track')->default(0);
			$table->timestamps();
		});

		Schema::create('task_user', function ($table)
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
		Schema::drop(array('tasks', 'task_user'));
	}

}