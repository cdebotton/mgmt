<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>@yield('title')</title>
	{{ Asset::styles() }}
	<script>
		var controller;
		controller = '@yield('currentController')';
		@if(!Auth::guest())
			var author_id;
			author_id = {{ Auth::user()->id }};
		@endif
	</script>
	@yield('js-bootstrap')
</head>
<body id="bu-schedule">

	<header class="navbar navbar-fixed">
		<div class="navbar-inner">
			{{ HTML::link_to_action('dashboard@index', 'ヾ(＠⌒ー⌒＠)ノ', array(), array('class' => 'brand')) }}
			@if(!Auth::guest())
				@include('partials.navigation')
			@endif
		</div>
	</header>

	@yield('content')

	{{ Asset::scripts() }}
</body>
</html>
