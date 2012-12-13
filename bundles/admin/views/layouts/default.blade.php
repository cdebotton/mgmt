<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>@yield('title')</title>
	{{ Asset::styles() }}
	{{ HTML::script('js/vendors/requirejs/require.js', array('data-main' => '/js/main')) }}
</head>
<body id="bu-schedule">
	<header class="navbar navbar-fixed">
		<div class="navbar-inner">
			{{ HTML::link_to_action('admin::dashboard@index', 'Brooklyn United Dev Schedule Management', null, array('class' => 'brand')) }}
			@if(!Auth::guest())
				@include('admin::partials.navigation')
			@endif
		</div>
	</header>
	@if(!Auth::guest())
		<nav id="breadcrumb-trail">
			{{ Breadcrumb::make('bootstrap') }}
		</nav>
	@endif
	@yield('content')
	{{ Anbu::render() }}
	@if(!Auth::guest())
	<script>
		var author_id;
		author_id = {{ Auth::user()->id }};
	</script>
	@endif
	{{ Asset::scripts() }}
</body>
</html>