<?php

class Client extends Eloquent
{
	/**
	 * A client has many projects.
	 * @return Project
	 */
	public function projects()
	{
		return $this->has_many('Client\\Project');
	}
}