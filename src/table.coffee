class Table
	constructor: (width, height) ->
		@size = new Point(width, height)
		@rows = new Array(@size.x)
		for i in [0...@size.x]
			@rows[i] = new Array(@size.y)
		this.init(0)

	toString: ->
		str = ""
		for j in [0...@size.y]
			for i in [0...@size.x]
				str += @rows[i][j]
			str += "\n"
		return str

	init: (value) ->
		for j in [0...@size.y]
			for i in [0...@size.x]
				@rows[i][j] = value

	get: (x, y) ->
		return @rows[x][y]

	set: (x, y, value) ->
		@rows[x][y] = value

	width: ->
		@size.getX()

	height: ->
		@size.getY()
