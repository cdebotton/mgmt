@layout('layouts.default')

@section('content')
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
					<h4><small>PDO accrual rate:</small> TBD</h4>
					<h4><small>Available days off:</small> TBD</h4>
					<h4><a href="#">Request time off</a></h4>
				</article>
			</div>
			<div class="current-tasks">
				<h3>Current jobs</h3>
				<dl>
				@forelse($user->tasks as $task)
					<dt>{{ $task->name }} &mdash; {{ $task->client }}</dt>
					<dd>Starts {{ date('F j, Y', strtotime($task->start_date) ) }}</dd>
					<dd>Ends {{date('F j, Y', strtotime($task->end_date)) }}</dd>
				@empty
					<dt>You currently have no current tasks.</dt>
				@endforelse
				</dl>
			</div>
		</div>
	</div>
@endsection