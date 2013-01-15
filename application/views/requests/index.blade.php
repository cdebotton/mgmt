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
			<div class="user">User</div>
			<div class="type">Type</div>
			<div class="requested-on">Requested on</div>
			<div class="dates">Dates</div>
		</header>
		<div id="request-overview-body">

		</div>
	</section>
@endsection
