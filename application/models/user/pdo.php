<?php

namespace User;

use Eloquent;

class Pdo extends Eloquent
{
	/**
	 * Pdo belongs to User.
	 * @return User
	 */
	public function user()
	{
		return $this->belongs_to('User');
	}
}