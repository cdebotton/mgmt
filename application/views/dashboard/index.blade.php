@layout('layouts.default')

@section('content')
	<div id="dashboard-container">
		<div id="dashboard-head">
			<div class="container">
				<div class="profile photo">
					@if($user->photo)

					@else
						<img class="img-polaroid" src="http://placehold.it/256x256" />
					@endif
				</div>
				<div class="profile header">
					<h2><small>Welcome back,</small><br/>{{ $user->first_name }} {{ $user->last_name }}</h2>
					<article class="tags">
						@foreach($user->disciplines as $discipline)
							<span class="label label-info">{{ $discipline->name }}</span>
						@endforeach
						@foreach($user->roles as $role)
							<span class="label label-warning">{{ $role->name }}</span>
						@endforeach
						<h4><small>PDO Limit:</small> {{ $user->pdo_allotment }} <small>days</small></h4>
						<h4><small>PDO accrual rate:</small> {{ number_format(($user->pdo_allotment / 12), 3) }} <small>days per month</small></h4>
						<h4><small>Available days off:</small> TBD</h4>
						<a id="request-time-off" class="btn btn-inverse btn-mini" href="#">Request time off</a>
					</article>
				</div>
				<div class="current-tasks">
					<h3>Current jobs</h3>
					<span class="badge badge-info job-count">{{ count($user->tasks) }}</span>
					<dl>
					@forelse($user->tasks as $task)
						@if($task->project)
							<dt>{{$task->project->name }}</dt>
						@endif
						<dt>{{ $task->name }}
							@if($task->project && $task->project)
								&mdash; {{ $task->project->client->name }}
							@endif
						</dt>
						<dd>Starts {{ date('F j, Y', strtotime($task->start_date) ) }}</dd>
						<dd>Ends {{date('F j, Y', strtotime($task->end_date)) }}</dd>
					@empty
						<dt>You currently have no current tasks.</dt>
					@endforelse
					</dl>
				</div>
			</div>
		</div>
		<div id="pdo-request">
			<!-- Remove after styling is done -->
				<div class="container">
					<header id="pdo-request-header">
						<h3 class="pull-left">Time Off <small>Send a Request for Approval</small></h3>
						<a href="#" class="pull-right"><i id="close-user-drawer" class="icon icon-remove icon-white"></i></a>
					</header>
					<form class="form-horizontal">
						<div class="form-row">
							<div class="form-element first-name">
								<input type="text" name="first-name" value="">
								<div class="meta">
									<label class="form-label">First Name</label>
								</div>
							</div>
						</div>
					</form>
				</div>

			<!-- End remove block -->
		</div>
	</div>
@endsection
