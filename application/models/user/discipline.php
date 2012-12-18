<?php

namespace User;

use Eloquent;

class Discipline extends Eloquent
{
	/**
	 * Discipline has many users.
	 * @return User
	 */
	public function users()
	{
		return $this->has_many_and_belongs_to('User');
	}
}