<?php

namespace Client;

use Eloquent;

class Project extends Eloquent
{
	/**
	 * A project belongs to a client.
	 * @return Client
	 */
	public function client()
	{
		return $this->belongs_to('Client');
	}

	/**
	 * A project has many tasks.
	 * @return Task
	 */
	public function tasks()
	{
		return $this->has_many('Client\\Project\\Task');
	}
}
