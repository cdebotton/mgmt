@layout('admin::layouts.default')

@section('content')
	<section id="schedule-viewport">
		<header class="navbar">
			<div class="navbar-inner">
				<a href="#" class="brand">Task Timeline</a>
				<ul class="nav">
					<li>
						<a href="#" id="new-task-toggle">Create New Task</a>
					</li>
					<li class="dropdown" id="filter-menu">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">Filters <span class="caret"></span></a>
						<ul class="dropdown-menu" role="menu">
							<li class="dropdown-submenu">
								<a tabindex="-1" href="#">Role</a>
								<ul class="dropdown-menu">
									<li><a href="#" data-reset-filter="true">All</a></li>
									@foreach($roles as $role)
									<li><a href="#" data-role="{{ $role->id }}">{{ $role->name }}</a></li>
									@endforeach
								</ul>
							</li>
							<li class="dropdown-submenu">
								<a tabindex="-1" href="#">Discipline</a>
								<ul class="dropdown-menu">
									<li><a href="#" data-reset-filter="true">All</a></li>
									@foreach($disciplines as $discipline)
									<li><a href="#" data-discipline="{{ $discipline->id }}">{{ $discipline->name }}</a></li>
									@endforeach
								</ul>
							</li>
						</ul>
					</li>
				</ul>
				<div id="timescale-wrapper">
					<span class="scale-label">Scale</span>
					<div id="timescale-slider">
						<div id="timescale-knob"></div>
					</div>
					<input type="number" id="timescale-input">
				</div>
			</div>
		</header>
		<section id="profile-palette">
			
		</section>
		<section id="task-timeline">
			<div id="task-timeline-wrapper">
				
			</div>
			<div id="graph-timeline">
				<div id="graph-timeline-wrapper">
					
				</div>
			</div>
		</section>
	</section>
	<script>
		var users;
		users = {{ $dev_json }};
	</script>
@endsection