@layout('admin::layouts.default')

@section('content')
	<header id="section-header">
		<div class="hero-wrapper">
			<div class="hero-unit">
				<h2>Create Task</h2>
				<p>Create a new task.</p>
			</div>
		</div>
	</header>
	<section class = "container">
	{{ Form::horizontal_open() }}
		<div class="control-group">
			{{ Form::label('name', 'Task Name *', array('class' => 'control-label')) }}
			<div class="controls">
				{{ Form::xxlarge_text('name', Input::old('name', '')) }}
				{{ Form::block_help('Please enter a unique task name.') }}
				@if($errors->has('name'))
					{{ Form::block_help('<span class="label label-important">Invalid task name.</span>') }}
				@endif
			</div>
		</div>
		<div class="control-group">
			{{ Form::label('project_code', 'Project Code *', array('class' => 'control-label')) }}
			<div class="controls">
				{{ Form::mini_text('project_code') }}
				@if($errors->has('project_code'))
					{{ Form::block_help('<span class="label label-important">Invalid project code.</span>') }}
				@endif
			</div>
		</div>
		<div class="control-group">
			{{ Form::label('client', 'Client *', array('class' => 'control-label')) }}
			<div class="controls">
				{{ Form::small_text('client') }}
				@if($errors->has('client'))
					{{ Form::block_help('<span class="label label-important">Invalid client.</span>') }}
				@endif
			</div>
		</div>
		<div class="control-group">
			{{ Form::label('start_date', 'Start Date', array('class' => 'control-label')) }}
			<div class="controls">
				{{ Form::select('start_month', $dates['months'], (int) date('n') - 1, array('class' => 'date-selector-month')) }} - {{ Form::select('start_day', $dates['days'], date('j'), array('class' => 'date-selector-day')) }} - {{ Form::select('start_year', $dates['years'], date('Y'), array('class' => 'date-selector-year')) }}
			</div>
		</div>
		<div class="control-group">
			{{ Form::label('end_date', 'End Date', array('class' => 'control-label')) }}
			<div class="controls">
				{{ Form::select('end_month', $dates['months'], (int) date('n') - 1, array('class' => 'date-selector-month')) }} - {{ Form::select('end_day', $dates['days'], date('j'), array('class' => 'date-selector-day')) }} - {{ Form::select('end_year', $dates['years'], date('Y'), array('class' => 'date-selector-year')) }}
				@if($errors->has('end_year'))
					{{ Form::block_help('<span class="label label-important">The task end date must come after its start date.</span>') }}
				@endif
			</div>
		</div>
		<div class="control-group">
			{{ Form::label('description', 'Project Description', array('class' => 'control-label')) }}
			<div class="controls">
				{{ Form::textarea('description') }}
			</div>
		</div>
		<div class="control group">
			{{ Form::label('developers', 'Add Developers', array('class' => 'control-label')) }}
			<div class="controls">
				{{ Form::select('developers', $developers, null, array('id' => 'dev-dropdown')) }}
				{{ Buttons::small_primary_normal('Add', array('id' => 'add-dev-btn')) }}
				{{ Form::block_help(null, array('id' => 'dev-pool')) }}
			</div>	
		</div>
		<div class="form-actions">
			{{ ButtonGroup::open() }}
				{{ Buttons::primary_normal('Create', array('type' => 'submit')) }}
				{{ Buttons::normal('Reset', array('type' => 'reset')) }}
			{{ ButtonGroup::close() }}	
		</div>
	{{ Form::close() }}
	</section>
@endsection