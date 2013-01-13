<?php

namespace User\Pdo;

use Eloquent;

class Adjustment extends Eloquent
{
	public static $table = 'pdo_adjustments';

	public function user()
	{
		return $this->belongs_to('User');
	}
}
