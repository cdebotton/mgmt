<?php

namespace User\Pdo;

use Eloquent;

class Request extends Eloquent
{
	public static $table = 'pdo_requests';

	public function user()
	{
		return $this->belongs_to('User');
	}
}
