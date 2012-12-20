@layout('layouts.default')

@section('content')
	<article id="dashboard-head">
		<div class="container">
			@if($user->photo)

			@else
				<img class="img-polaroid" src="http://placehold.it/256x256" />
			@endif
			<h2>Welcome back, {{ $user->first_name }} {{ $user->last_name }}</h2>
		</div>
	</article>
@endsection