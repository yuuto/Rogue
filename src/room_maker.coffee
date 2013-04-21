class RoomMaker
	constructor: ->

	randomRoomSize: (areaWidth, areaHeight)->
		widthRange =
			min: Room.MINIMUM_SIZE
			max: areaWidth - Area.BOTH_WALL_MIN - Area.BOTH_FRAMES
		@roomWidth = Math.randomInt(widthRange)
		heightRange =
			min: Room.MINIMUM_SIZE
			max: areaHeight - Area.BOTH_WALL_MIN - Area.BOTH_FRAMES
		@roomHeight = Math.randomInt(heightRange)


	do: (leafs)->
		if !(leafs instanceof Array)
			throw new Error("配列しか受け取れないんです。ごめんなさい。")
		
		for i in [0...leafs.length]
			area = leafs[i]
			this.randomRoomSize(area.width(), area.height())

			base = area.basepoint
			end  = area.endpoint
			margin = Area.WALL_MIN + Area.FRAME

			rangeOfBaseX =
				min: base.getX() + margin
				max: end.getX() - @roomWidth - margin
			roomBaseX = Math.randomInt(rangeOfBaseX)

			rangeOfBaseY =
				min: base.getY() + margin
				max: end.getY() - @roomHeight - margin
			roomBaseY = Math.randomInt(rangeOfBaseY)
			
			room_base = new Point(roomBaseX, roomBaseY)
			room_end  = new Point(roomBaseX + @roomWidth, roomBaseY + @roomHeight)
			area.room = new Room(room_base, room_end)

