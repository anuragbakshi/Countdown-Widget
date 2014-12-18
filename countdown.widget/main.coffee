MILLIS_IN_DAY: 24 * 60 * 60 * 1000
MILLIS_IN_HOUR: 60 * 60 * 1000
MILLIS_IN_MINUTE: 60 * 1000
MILLIS_IN_SECOND: 1000

countdowns: [
	label: "New Year's Day"
	time: "Jan 1, 2015"
,
	label: "UIUC Decision"
	time: "Feb 13, 2015"
,
	label: "High School Ends"
	time: "Jun 18, 2015 12:10 PM"
]

command: ""

refreshFrequency: 1000

style: """
	*
		margin 0
		padding 0

	#container
		background rgba(#000, .5)
		margin 10px 10px 15px
		padding 10px
		border-radius 5px

		color rgba(#fff, .9)
		font-family Helvetica Neue
	
	span
		font-size 14pt
		font-weight bold

	ul
		list-style none

	li
		padding 10px

		&:not(:last-child)
			border-bottom solid 1px white

	thead
		font-size 8pt
		font-weight bold

		td
			width 60px

	tbody
		font-size 12pt

	td
		text-align center
"""

render: -> """
	<div id="container">
		<ul>
		</ul>
	</div>
"""

afterRender: ->
	for countdown in @countdowns
		countdown.millis = new Date(countdown.time).getTime()

update: (output, domEl) ->
	$countdownList = $(domEl).find("#container").find("ul")
	$countdownList.empty()

	now = new Date().getTime()

	# $root.html new Date
	# $root.html new Date @countdowns[1].time
	for countdown in @countdowns
		millisUntil = countdown.millis - now
		timeUntil = {}

		timeUntil.days = millisUntil // @MILLIS_IN_DAY
		millisUntil %= @MILLIS_IN_DAY

		timeUntil.hours = millisUntil // @MILLIS_IN_HOUR
		millisUntil %= @MILLIS_IN_HOUR

		timeUntil.minutes = millisUntil // @MILLIS_IN_MINUTE
		millisUntil %= @MILLIS_IN_MINUTE

		timeUntil.seconds = millisUntil // @MILLIS_IN_SECOND
		millisUntil %= @MILLIS_IN_SECOND

		$countdownList.append("""
			<li>
				<span>#{countdown.label}</span>
				<table>
					<thead>
						<tr>
							<td>DAYS</td>
							<td>HOURS</td>
							<td>MINUTES</td>
							<td>SECONDS</td>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td>#{timeUntil.days}</td>
							<td>#{timeUntil.hours}</td>
							<td>#{timeUntil.minutes}</td>
							<td>#{timeUntil.seconds}</td>
						</tr>
					</tbody>
				</table>
			</li>
		""")