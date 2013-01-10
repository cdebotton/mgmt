<?php

use User\Role as Role;
use User\Role\Rule as Rule;

class Authorized_Custom_Users_Table {

	/**
	 * Make changes to the database.
	 *
	 * @return void
	 */
	public function up()
	{
		Schema::create('users', function($table)
		{
			$table->increments('id');
			$table->string('email')->unique();
			$table->string('password');
			$table->string('first_name');
			$table->string('last_name');
			$table->timestamps();
		});

		User::create(array(
			'id'       		 => 1,
			'email'    		 => 'debotton@brooklynunited.com',
			'password' 		 => Hash::make('test'),
			'first_name'     => 'Christian',
			'last_name'      => 'de Botton'
		));

		User::create(array(
			'id'       		 => 2,
			'email'    		 => 'nilaratna@brooklynunited.com',
			'password' 		 => Hash::make('test'),
			'first_name'     => 'Pritika',
			'last_name'      => 'Nilaratna'
		));

		User::create(array(
			'id'       		 => 3,
			'email'    		 => 'konovalova@brooklynunited.com',
			'password' 		 => Hash::make('test'),
			'first_name'     => 'Sasha',
			'last_name'      => 'Konovalova'
		));

		User::create(array(
			'id'       		 => 4,
			'email'    		 => 'smolenski@brooklynunited.com',
			'password' 		 => Hash::make('test'),
			'first_name'     => 'Sam',
			'last_name'      => 'Smolenski'
		));

		User::create(array(
			'id'       		=> 5,
			'email'    		=> 'bielefeld@brooklynunited.com',
			'password' 		=> Hash::make('test'),
			'first_name'    => 'Shirmung',
			'last_name'     => 'Bielefeld'
		));

		Schema::create('roles', function($table)
		{
			$table->increments('id');
			$table->string('name');
			$table->timestamps();
		});

		Role::create(array(
			'id'   => 1,
			'name' => 'Admin'
		));

		Role::create(array(
			'id'   => 2,
			'name' => 'Member'
		));

		Role::create(array(
			'id'   => 3,
			'name' => 'Demo'
		));

		Schema::create('rules', function($table)
		{
			$table->increments('id');
			$table->string('group');
			$table->string('action');
			$table->string('description');
			$table->timestamps();
		});

		Rule::create(array(
			'id'          => 1,
			'group'       => 'demo',
			'action'      => '*',
			'description' => 'Can access Demo all actions.'
		));

		Rule::create(array(
			'id'          => 2,
			'group'       => 'demo',
			'action'      => 'view',
			'description' => 'Can view Demo.'
		));

		Rule::create(array(
			'id'          => 3,
			'group'       => 'demo',
			'action'      => 'create',
			'description' => 'Can create Demo.'
		));

		Rule::create(array(
			'id'          => 4,
			'group'       => 'demo',
			'action'      => 'edit',
			'description' => 'Can edit Demo.'
		));

		Rule::create(array(
			'id'          => 5,
			'group'       => 'demo',
			'action'      => 'revise',
			'description' => 'Can revise Demo.'
		));

		Rule::create(array(
			'id'          => 6,
			'group'       => 'demo',
			'action'      => 'publish',
			'description' => 'Can publish Demo.'
		));

		Rule::create(array(
			'id'          => 7,
			'group'       => 'demo',
			'action'      => 'delete',
			'description' => 'Can delete Demo.'
		));

		Schema::create('role_rule', function($table)
		{
			$table->increments('id');
			$table->integer('role_id');
			$table->integer('rule_id');
			$table->timestamps();
		});

		Role::find(1)->rules()->sync(array(1));
		Role::find(2)->rules()->sync(array(2, 5, 6, 7));
		Role::find(3)->rules()->sync(array(2, 4, 3));

		Schema::create('role_user', function($table)
		{
			$table->increments('id');
			$table->integer('user_id');
			$table->integer('role_id');
			$table->timestamps();
		});

		User::find(1)
			->roles()
			->sync(array(1,2));

		User::find(2)
			->roles()
			->attach(2);

		User::find(3)
			->roles()
			->attach(2);

		User::find(4)
			->roles()
			->attach(2);

		User::find(5)
			->roles()
			->attach(2);
	}

	/**
	 * Revert the changes to the database.
	 *
	 * @return void
	 */
	public function down()
	{
		Schema::drop('users');
		Schema::drop('roles');
		Schema::drop('rules');
		Schema::drop('role_user');
		Schema::drop('role_rule');
	}

}
