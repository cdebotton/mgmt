@layout('layouts.default')

@section('content')
	{{ Form::horizontal_open('login', 'post', array('id' => 'login-form')) }}
		{{ Form::token() }}
		<div class="control-group">
			{{ Form::label('email', 'E-mail', array('class' => 'control-label')) }}
			<div class="controls">
				{{ Form::xlarge_text('email', Input::old('email', '')) }}
			</div>
		</div>
		<div class="control-group">
			{{ Form::label('password', 'Password', array('class' => 'control-label')) }}
			<div class="controls">
				{{ Form::xlarge_password('password') }}
			</div>
		</div>
		<div class="form-actions">
			{{ ButtonGroup::open() }}
				{{ Buttons::primary_large_normal('Login', array('type' => 'submit')) }}
				{{ Buttons::large_normal('Reset', array('type' => 'reset')) }}
			{{ ButtonGroup::close() }}
		</div>
	{{ Form::close() }}
@endsection