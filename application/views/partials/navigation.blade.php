				<ul class="nav">
					<li{{ URI::is('/') ? ' class="active"' : '' }}>
						<a href="{{ URL::to('') }}"><i class="icon-home"></i> Dashboad</a>
					<li>
						<a href="{{ URL::to('profile') }}"> My Profile</a>
					</li>
					<li{{ URI::is('schedules') ? ' class="active"' : '' }}>
						<a href="{{ URL::to_action('schedules') }}"><i class="icon-wrench"></i> Schedules</a>
					</li>
					<li{{ URI::is('projects') ? ' class="active"' : '' }}>
						<a href="{{ URL::to_action('projects') }}"><i class="icon-th-list"></i> Projects</a>
					</li>
					<li{{ URI::is('users') ? ' class="active"' : '' }}>
						<a href="{{ URL::to_action('users') }}"><i class="icon-user"></i> Users</a>
					</li>
				</ul>
				<a href="{{ URL::to('logout') }}" class="btn btn-small btn-inverse pull-right"><i class="icon-off icon-white"></i> Log out</a>