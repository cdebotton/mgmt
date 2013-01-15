@layout('layouts.default')

@section('js-bootstrap')
	<script>
		var requests;
		requests = {{ $requests }};
	</script>
@endsection

@section('content')
	<section id="request-overview">
		<header id="request-header">
			<span class="user">User</span>
			<span class="type">Type</span>
			<span class="requested-on">Requested on</span>
			<span class="dates">Dates</span>
		</header>
		<div id="request-overview-body">

		</div>
	</section>
@endsection
