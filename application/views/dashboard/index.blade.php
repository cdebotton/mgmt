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
						<h4><small>Available days off:</small> {{ $accrued_days }}</h4>
						<div id="pdo-actions">
							<a id="request-time-off" class="btn btn-inverse btn-mini" href="#">Request time off</a>
							<span id="request-counter">&mdash; <a href="#"><span class="badge badge-inverse">{{ count($user->requests) }}</span> requests pending.</a></span>
							<div id="pdo-list">
								<i class="icon-remove icon-white" id="close-pdo-list"></i>
								<ul id="pdo-list-ul">

								</ul>
							</div>
						</div>
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

		</div>
	</div>
@endsection
