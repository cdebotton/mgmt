<?php

use Validations\User as UserValidator;

class User extends Eloquent {
	private static $DATE_FORMAT = 'Y-m-d';

	public static $hidden = array('password');

	/**
	 * Return all the Paid Days Off that a user has.
	 * @return User\Pdo
	 */
	public function pdos()
	{
		return $this->has_many('User\\Pdo');
	}

	/**
	 * Return the adjustment history of a users PDO Accrual rate.
	 * @return User\Pdo\Adjustment
	 */
	public function adjustments()
	{
		return $this->has_many('User\\Pdo\\Adjustment');
	}

	/**
	 * Return unapproved requests a user has for paid days off.
	 * @return User\Pdo\Request
	 */
	public function requests()
	{
		return $this->has_many('User\\Pdo\\Request');
	}

	/**
	 * Return all disciplines that a user is tagged with.
	 * @return User\Discipline
	 */
	public function disciplines()
	{
		return $this->has_many_and_belongs_to('User\\Discipline');
	}

	/**
	 * Return the tasks that are assigned to a user.
	 * @return Client\Project\Task
	 */
	public function tasks()
	{
		return $this->has_many('Client\\Project\\Task');
	}

	/**
	* User has many and belongs to roles.
	*
	* @return Role
	*/
	public function roles()
	{
		return $this->has_many_and_belongs_to('User\\Role');
	}

	/**
	* Get only name of user roles with memory cache.
	*
	* @return array()
	*/
	public function get_roles_list()
	{
		$ckey = 'has_roles_'.$this->id;
		$cache = Cache::driver('memory');

		if ( ! $roles = $cache->get($ckey))
		{
			$roles = $this->roles()->lists('name');
			foreach ($roles as &$role) {
				$role = strtolower($role);
			}
			$cache->forever($ckey, $roles);
		}

		return $roles;
	}

	/**
	* Check has exact role?
	*
	* @param  string  $key
	* @return bool
	*/
	public function has_role($key = null)
	{
		if ( ! is_null($key))
		{
			return in_array(strtolower($key), $this->roles_list);
		}

		return false;
	}

	/**
	 * Get the duration of a users employment.
	 * @return DateDiff
	 */
	public function employment_duration()
	{
		$today_str = date(static::$DATE_FORMAT);
		$today = date_create_from_format(static::$DATE_FORMAT, $today_str);
		$hired_on_str = date(static::$DATE_FORMAT, strtotime($this->hired_on));
		$hired_on = date_create_from_format(static::$DATE_FORMAT, $hired_on_str);
		return date_diff($today, $hired_on);
	}

	/**
	 * Return an array of the users PDO Accrual adjustment history.
	 * @return array
	 */
	public function pdo_adjustment_history()
	{
		$hired_on_string = date(static::$DATE_FORMAT, strtotime($this->hired_on));
		$hired_on_date = date_create_from_format(static::$DATE_FORMAT, $hired_on_string);
		$history = array(array(
			'date' => $hired_on_date,
			'rate' => $this->pdo_allotment
		));
		$adjustments = $this->adjustments;
		foreach ($adjustments as $adjustment) {
			$date_string = date(static::$DATE_FORMAT, strtotime($adjustment->effective_date));
			$date = date_create_from_format(static::$DATE_FORMAT, $date_string);
			array_push($history, array(
				'date' => $date,
				'rate' => $adjustment->pdo_allotment
			));
		}
		return $history;
	}

	/**
	 * Calculate how many paid days off the user has accrued through the
	 * duration of their employment
	 * @return int
	 */
	public function accrued_pdos()
	{
		$history = $this->pdo_adjustment_history();
		$today_string = date(static::$DATE_FORMAT, strtotime(date(static::$DATE_FORMAT)));
		$today_date = date_create_from_format(static::$DATE_FORMAT, $today_string);
		$len = count($history);
		$pdoCount = 0;
		$buffer = $len - 1;
		for ($i = 0; $i < $len; $i++) {
			$start = $history[$i]['date'];
			$end = $i < $buffer ? $history[$i+1]['date'] : $today_date;
			$diff = date_diff($start, $end);
			$months = (12 * $diff->y) + $diff->m;
			$rate = $history[$i]['rate'] / 12;
			$pdoCount += floor($months * 12);
		}
		return $pdoCount;
	}

	/**
	 * Calculate how many paid days off the user has taken
	 * throughout the duration of their employment.
	 * @return int
	 */
	public function pdos_used()
	{
		$total = 0;
		foreach ($this->pdos as $pdo) {
			$total += $pdo->duration();
		}
		return $total;
	}

	/**
	 * Calculate how many paid days off the user currently
	 * has available to them.
	 * @return int
	 */
	public function available_pdos()
	{
		$accrued_days = floor($this->accrued_pdos() - $this->pdos_used());
		return $accrued_days > $this->current_pdo_allotment ? $this->current_pdo_allotment : $accrued_days;
	}

	/**
	 * Get the current value of the users PDO Accrual rate.
	 * If the user has a PDO Adjustment history, the latest adjustment is used as this value.
	 * @return float
	 */
	public function get_current_pdo_allotment()
	{
		$adjustment = $this->has_many('User\\Pdo\\Adjustment')
			->order_by('effective_date', 'DESC')
			->first();
		return (!$adjustment) ? $this->pdo_allotment : $adjustment->pdo_allotment;
	}
}
