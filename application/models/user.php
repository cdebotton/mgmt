<?php

class User extends Eloquent {
	
	public static $hidden = array('password');

	public function tasks()
	{
		return $this->has_many_and_belongs_to('Client\\Project\\Task')->with('percentage');
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
			return in_array($key, $this->roles_list);
		}

		return false;
	}

}