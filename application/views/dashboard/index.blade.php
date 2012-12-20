@layout('layouts.default')

@section('content')
	<article id="dashboard-head">
		<div class="container">
			@if($user->photo)

			@else
				<img class="img-polaroid" src="http://placehold.it/256x256" />
			@endif
			<h2>Welcome back, {{ $user->first_name }} {{ $user->last_name }}</h2>
			<article class="tags">
				@foreach($user->disciplines as $discipline)
					<span class="label label-info">{{ $discipline->name }}</span>
				@endforeach
				@foreach($user->roles as $role)
					<span class="label label-warning">{{ $role->name }}</span>
				@endforeach
			</article>
		</div>
	</article>
	<div id="current-tasks" class="container">
		<h3>Current jobs</h3>
		<dl>
		@forelse($currentTasks as $task)
			<dt>{{ $task->name }} &mdash; {{ $task->client }}</dt>
			<dd>Starts {{ date('F j, Y', strtotime($task->start_date) ) }}</dd>
			<dd>Ends {{date('F j, Y', strtotime($task->end_date)) }}</dd>
		@empty
			<dt>You currently have no current tasks.</dt>
		@endforelse
		</dl>
	</div>
@endsection