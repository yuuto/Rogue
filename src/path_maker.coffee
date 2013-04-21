class PathMaker
	do: (leafs) ->
		paths = []
		for i in [0...leafs.length-1]
			console.log leafs[i].toString()
			console.log "leafs.length: " + leafs.length + ",i: " + i
			this.makeGate(leafs[i], leafs[i+1])
			#paths.push this.makePath(leafs[i], leafs[i+1])
		return paths

	makeGate: (area1, area2) ->	
		from = area1.getRoom()
		to = area2.getRoom()

		if (area1.isTopOverlap(area2))
			gate1 = new Point(this.randomGateX(from), from.basepoint.getY())
			from.putGate(to, gate1)

			gate2 = new Point(this.randomGateX(to), to.endpoint.getY())
			to.putGate(from, gate2)
		else if (area1.isRightOverlap(area2))
			throw new Error("Areaの位置関係がおかしい予感…")
		else if (area1.isBottomOverlap(area2))
			throw new Error("Areaの位置関係がおかしい予感…")
		else if (area1.isLeftOverlap(area2))
			gate1 = new Point(from.basepoint.getX(), this.randomGateY(from))
			from.putGate(to, gate1)

			gate2 = new Point(to.endpoint.getX(), this.randomGateY(to))
			to.putGate(from, gate2)

	randomGateX: (room) ->
		return Math.randomInt(
			min: room.basepoint.getX()
			max: room.endpoint.getX()
		)
	randomGateY: (room) ->
		return Math.randomInt(
			min: room.basepoint.getY()
			max: room.endpoint.getY()
		)

	# パスをつくるんだけど、結果を誰が持つか。
	makePath: (area1, area2) ->
		gate1 = area1.getRoom().getGate(area2.getRoom())
		gate2 = area2.getRoom().getGate(area1.getRoom())
		path = []
		path.push gate1

		overlap = area1.findOverlap(area2)
		path.push this.getFoot(overlap, gate1)
		path.push this.getFoot(overlap, gate2)

		path.push gate2
		return new Path(path)

	#垂線の足を求める
	getFoot: (line, point)->
		if (line.basepoint.getX() == line.endpoint.getX())
			#縦線
			return new Point(line.basepoint.getX(), point.getY())
		else
			#横線
			return new Point(point.getX(), line.basepoint.getY())