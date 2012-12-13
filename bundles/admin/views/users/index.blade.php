@layout('admin::layouts.default')

@section('content')
	<header id="section-header">
		<div class="hero-wrapper">
			<div class="hero-unit">
				<h2>Manage Users</h2>
				<p>Access user settings, delete, and create users.</p>
			</div>
			<article id="control-box">
				<div class="control-group">
					[[ LIST STYLE DROPDOWN ]]
				</div>
				<div class="control-group">
					[[ FILTER DROPDOWN ]]
				</div>
				<div class="control-group">
					[[ SORTING DROPDOWN ]]
				</div>
			</article>
		</div>
	</header>
	<section id="users-table" class="cust-table">
		<header id="users-header">
			<div class="user-id">ID</div>
			<div class="user-email">E-mail</div>
			<div class="user-name">Name</div>
			<div class="user-roles">Roles</div>
			<div class="user-actions">Actions</div>
		</header>
		@forelse($users as $user)
			<article class="user-row">
				<div class="user-id">{{ $user->id }}</div>
				<div class="user-email">{{ HTML::mailto($user->email) }}</div>
				<div class="user-name">{{ $user->first_name . ' ' . $user->last_name }}</div>
				<div class="user-roles">
					@forelse($user->roles as $role)
						<span class="label label-info">{{ $role->name }}</span>
					@empty
					
					@endforelse
				</div>
				<div class="user-edit">
					<a href="{{ URL::to('admin/users/edit/' . $user->id) }}" class="btn btn-small"><i class="icon-wrench"></i> Edit</a>
				</div>
				<div class="user-delete">
					<a href="{{ URL::to('admin/users/destroy/' . $user->id) }}" class="btn btn-small"><i class="icon-remove"></i> Rm</a>
				</div>
			</article>
		@empty
			<span class="label label-info">There are no users in the database.</span>
		@endforelse
	</section>
@endsection