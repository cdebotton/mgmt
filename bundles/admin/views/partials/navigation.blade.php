				<ul class="nav">
					<li{{ URI::is('admin') ? ' class="active"' : '' }}>
						<a href="{{ URL::to('admin') }}"><i class="icon-home"></i> Dashboad</a>
					<li{{ URI::is('admin/schedules') ? ' class="active"' : '' }}>
						<a href="{{ URL::to_action('admin::schedules') }}"><i class="icon-wrench"></i> Schedules</a>
					</li>
					<li{{ URI::is('admin/projects') ? ' class="active"' : '' }}>
						<a href="{{ URL::to_action('admin::projects') }}"><i class="icon-th-list"></i> Projects</a>
					</li>
					<li{{ URI::is('admin/users') ? ' class="active"' : '' }}>
						<a href="{{ URL::to_action('admin::users') }}"><i class="icon-user"></i> Users</a>
					</li>
				</ul>
				<a href="{{ URL::to('admin/logout') }}" class="btn btn-small btn-inverse pull-right"><i class="icon-off icon-white"></i> Log out</a>