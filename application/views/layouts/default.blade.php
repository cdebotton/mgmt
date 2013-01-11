<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>@yield('title')</title>
	{{ Asset::styles() }}
	<script>
		var controller;
		controller = '@yield('currentController')';
	</script>
	@yield('js-bootstrap')
	{{ HTML::script('js/vendors/requirejs/require.js', array('data-main' => '/js/main')) }}
</head>
<body id="bu-schedule">

	<header class="navbar navbar-fixed">
		<div class="navbar-inner">
			{{ HTML::link_to_action('dashboard@index', 'Brooklyn United MGMT', array(), array('class' => 'brand')) }}
			@if(!Auth::guest())
				@include('partials.navigation')
			@endif
		</div>
	</header>

	@yield('content')

	@if(!Auth::guest() && Auth::user()->has_role('admin'))
		{{ Anbu::render() }}
	@endif

	@if(!Auth::guest())
	<script>
		var author_id;
		author_id = {{ Auth::user()->id }};
	</script>
	@endif

	{{ Asset::scripts() }}
</body>
</html>
