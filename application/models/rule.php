<?php

class Rule extends Eloquent {

	/**
	* Rule has many and blongs to roles
	* 
	* @return Role
	*/
	public function roles()
	{
		return $this->has_many_and_belongs_to('Role');
	}

}