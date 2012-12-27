@layout('layouts.default')

@section('content')
	<div class="navbar">
		<div class="navbar-inner">
			<a class="brand" href="#">Projects</a>
			<ul class="nav">
				<li><a href="#">New Project</a></li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="icon icon-filter"></span> Filters <span class="caret"></span></a>
					<ul class="dropdown-menu" role="menu">
						<li class="dropdown-submenu">
							<a tabindex="-1" href="#">Role</a>
							<ul class="dropdown-menu">
								<li><a href="#" data-reset-filter="true">All</a></li>
							</ul>
						</li>
						<li class="dropdown-submenu">
							<a tabindex="-1" href="#">Discipline</a>
							<ul class="dropdown-menu">
								<li><a href="#" data-reset-filter="true">All</a></li>
							</ul>
						</li>
					</ul>
				</li>
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"><span class="icon icon-move"></span> Sort <span class="caret"></span></a>
					<ul class="dropdown-menu" role="menu">
						<li class="dropdown-submenu">
							<a tabindex="-1" href="#">Role</a>
							<ul class="dropdown-menu">
								<li><a href="#" data-reset-filter="true">All</a></li>
							</ul>
						</li>
						<li class="dropdown-submenu">
							<a tabindex="-1" href="#">Discipline</a>
							<ul class="dropdown-menu">
								<li><a href="#" data-reset-filter="true">All</a></li>
							</ul>
						</li>
					</ul>
				</li>
			</ul>
		</div>
	</div>
	<script>
		var projects;
		projects = <?php echo $projects; ?>;
	</script>
@endsection