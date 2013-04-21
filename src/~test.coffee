Test =
	separateHorizontal: (rect, borderPosition) ->
		rect.separateHorizontal(borderPosition)
		console.info(rect.toString())
		console.info(rect.toTable().toString())

	separateVertical: (rect, borderPosition) ->
		rect.separateVertical(borderPosition)
		console.info(rect.toString())
		console.info(rect.toTable().toString())

	constract2D: (x, y) ->
		console.info(Array.constract2D({x:x, y:y}).toString())

	init: (x, y) ->
		stage = new Stage(x, y)
		stage.init()
		stage.print()

	table: (x, y) ->
		console.info((new Table({x: x, y: y})).toString() )

	point: (x, y) ->
		console.info new Point(x, y).toString()

	stagePrint: ()->
		stage = new Stage(5, 5)
		stage.print()

Test.init(80, 40)
# Test.stagePrint()
