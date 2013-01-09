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

		Client::create(array(
			'id' 		=> 1,
			'name'		=> 'Busby'
		));

		Client::create(array(
			'id' 		=> 2,
			'name'		=> 'Toshiko Mori'
		));

		Client::create(array(
			'id' 		=> 3,
			'name'		=> 'Brooklyn Arts Council'
		));

		Client::create(array(
			'id' 		=> 4,
			'name'		=> 'Peter Rose & Partners'
		));

		Client::create(array(
			'id' 		=> 5,
			'name'		=> 'Vertebra'
		));

		Client::create(array(
			'id' 		=> 6,
			'name'		=> 'Todd Williams & Billie Tsien Architects'
		));

		Client::create(array(
			'id' 		=> 7,
			'name'		=> 'RS Granoff Architects'
		));

		Client::create(array(
			'id' 		=> 8,
			'name'		=> 'AT&T'
		));

		Client::create(array(
			'id' 		=> 9,
			'name'		=> 'Gucci'
		));

		Client::create(array(
			'id' 		=> 10,
			'name'		=> 'Levi\'s'
		));

		Client::create(array(
			'id' 		=> 11,
			'name'		=> 'Guggenheim'
		));

		Client::create(array(
			'id' 		=> 12,
			'name'		=> 'Gary Hutswit Films'
		));

		Client::create(array(
			'id' 		=> 13,
			'name'		=> 'Associated Press'
		));

		Client::create(array(
			'id' 		=> 14,
			'name'		=> 'Mary Bright'
		));

		Client::create(array(
			'id' 		=> 15,
			'name'		=> '80 Metropolitan'
		));

		Client::create(array(
			'id' 		=> 16,
			'name'		=> 'Governer\'s Island'
		));

		Client::create(array(
			'id' 		=> 17,
			'name'		=> 'Raison Pure'
		));

		Client::create(array(
			'id' 		=> 18,
			'name'		=> 'Peter Walker Partners'
		));

		Client::create(array(
			'id' 		=> 19,
			'name'		=> 'Brilliant Transportation'
		));

		Client::create(array(
			'id' 		=> 20,
			'name'		=> 'Alloy Development'
		));

		Client::create(array(
			'id' 		=> 21,
			'name'		=> 'Sagmeister Inc.'
		));

		Client::create(array(
			'id' 		=> 22,
			'name'		=> 'Columbia University'
		));

		Client::create(array(
			'id' 		=> 23,
			'name'		=> 'Steiner Studios'
		));

		Client::create(array(
			'id' 		=> 24,
			'name'		=> 'Corcoran Group'
		));

		Client::create(array(
			'id' 		=> 25,
			'name'		=> 'Droog'
		));
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
