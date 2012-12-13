<?php

class Role extends Eloquent {

	/**
	* Role has many and blongs to rules.
	* 
	* @return  Rule
	*/
	public function rules()
	{
		return $this->has_many_and_belongs_to('Rule');
	}

	/**
	* Role has many and blongs to user.
	* 
	* @return  User
	*/
	public function users()
	{
		return $this->has_many_and_belongs_to('User');
	}

}