class Stage
	# @table, Area, pathway
	constructor: (width, height)->
		base = new Point(0,0)
		end = new Point(width, height)
		@root = new Area(base, end)

	init: ->
		area = @root
		separater = new AreaSeparator(@root)
		separater.do()
		roomMaker = new RoomMaker()
		leafs = this.collectLeafs()
		roomMaker.do(leafs)
		pathMaker = new PathMaker()
		pathMaker.do(leafs)

	print: ->
		table = new Table(@root.width(), @root.height())
		table.init(".")
		#表示するAreaは子供もってないやつだけ(leaf)
		leafs = this.collectLeafs()
		for i in [0...leafs.length]
			this.writeFrame(table, leafs[i])
			this.writeRoom(table, leafs[i])
		this.writeAreaNumber(table, leafs)
		this.writeNumber(table)
		console.log @root.toStringRecursive()
		console.log table.toString()

	# 壁書きます
	writeFrame: (table, area) ->
		base = area.basepoint
		end = area.endpoint

		for i in [base.getX()...end.getX()]
			for j in [base.getY()...end.getY()]
				if (i == base.getX() || i == end.getX() - 1)
					table.set(i, j, "#")
				else if (j == base.getY() || j == end.getY() - 1)
					table.set(i, j, "#")

	writeRoom: (table, area) ->
		base = area.room.basepoint
		end = area.room.endpoint

		for i in [base.getX()...end.getX()]
			for j in [base.getY()...end.getY()]
				table.set(i, j, "@")

	writeAreaNumber: (table, leafs) ->
		for i in [0...leafs.length]
			base = leafs[i].basepoint
			table.set(base.getX()+1, base.getY()+1, i)

	writeNumber: (table) ->
		for i in [0...table.width()]
			table.set(i, 0, i%10)
		for i in [0...table.height()]
			table.set(0, i, i%10)

	collectLeafs: ->
		leafs = []
		areas = [@root];
		while(areas.length > 0)
			area = areas.pop()
			if !area.hasChild()
				leafs.push(area)
			else
				children = area.getChildren()
				areas = areas.concat(children)
		return leafs


