<?php

use User\Discipline as Discipline;

class Create_Disciplines_Table {

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('disciplines', function($table)
		{
			$table->increments('id');
			$table->string('name');
			$table->timestamps();
		});

		Discipline::create(array(
			'id'	=> 1,
			'name'	=> 'Developer'
		));

		Discipline::create(array(
			'id'	=> 2,
			'name'	=> 'Designer'
		));

		Discipline::create(array(
			'id'	=> 3,
			'name'	=> 'Visualization'
		));

		Discipline::create(array(
			'id'	=> 4,
			'name'	=> 'Management'
		));

		Schema::create('discipline_user', function($table)
		{
			$table->increments('id');
			$table->integer('discipline_id');
			$table->integer('user_id');
			$table->timestamps();
		});

		User::find(1)
			->disciplines()
			->sync(array(1, 4));

		User::find(2)
			->disciplines()
			->sync(array(1));

		User::find(3)
			->disciplines()
			->sync(array(1));

		User::find(4)
			->disciplines()
			->sync(array(1));
	}

	/**
	 * Revert the changes to the database.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop(array('disciplines', 'discipline_user'));
	}

}