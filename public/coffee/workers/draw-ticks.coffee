ticks = { dates: [] }
grid = {}
dx = 0
c = 0
months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sept', 'Oct', 'Nov', 'Dec']
days = ['Mon', 'Tues', 'Wed', 'Thur', 'Fri', 'Sat', 'Sun']

readableDate = (date) -> "#{getDay date} #{getMonth date} #{getDate date} #{getYear date}"

getDay = (date) ->
			dayVal = date.getDay() - 1
			if dayVal < 0 then dayVal = 6
			days[dayVal]

getMonth = (date) -> months[date.getMonth()]

getYear = (date) -> date.getFullYear()

getDate = (date) -> date.getDate()

self.addEventListener 'message', (e) ->
	d = e.data.start
	while d <= e.data.end
		epoch = d.getTime()
		grid[epoch] = dx
		dx += e.data.PX_PER_DAY
		if c % 7 is 0
			ticks.dates.push {
				dx: dx
				epoch: epoch
				readable: readableDate d
			}
		c++
		d.setDate d.getDate() + 1
	self.postMessage { grid: grid, ticks: ticks }
, false