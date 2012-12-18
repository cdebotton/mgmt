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
				</ul>
				<div id="timescale-wrapper">
					<span class="scale-label">Scale</span>
					<div id="timescale-slider">
						<div id="timescale-knob"></div>
					</div>
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