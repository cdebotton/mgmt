<?php

namespace User\Pdo;

use Eloquent;

class Request extends Eloquent
{
	private static $DATE_FORMAT = 'Y-m-d';

	public static $table = 'pdo_requests';

	public function user()
	{
		return $this->belongs_to('User');
	}

	public function duration()
	{
		$start_str = date(static::$DATE_FORMAT, strtotime($this->start_date));
		$end_str = date(static::$DATE_FORMAT, strtotime($this->end_date));
		$start = date_create_from_format(static::$DATE_FORMAT, $start_str);
		$end = date_create_from_format(static::$DATE_FORMAT, $end_str);
		$diff = date_diff($start, $end);
		return $diff->days;
	}
}
