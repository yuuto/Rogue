class AreaSeparator

	@VERTICAL: "vertical"
	@HORIZONTAL: "horizontal"

	constructor: (area) ->
		@info = new Info(area)

	do: ->
		while(@info.canSeparate())
			@info.randomize()
			this.separate()
			@info = new Info(@info.area.getFirstChild())

	separate: ->
		@info.validate()
		switch(@info.separation)
			when AreaSeparator.VERTICAL
				this.separateVertical()
			when AreaSeparator.HORIZONTAL
				this.separateHorizontal()

	separateVertical: ->
		area = @info.area
		base = area.basepoint
		end = area.endpoint
		newEndpoint1 = new Point(end.getX(), @info.position + 1)
		areaTop = new Area(base.copy(), newEndpoint1)

		newStartpoint2 = new Point(base.getX(), @info.position)
		areaBottom = new Area(newStartpoint2, end.copy())
		area.addChild(areaTop)
		area.addChild(areaBottom)

	separateHorizontal: ->
		area = @info.area
		base = area.basepoint
		end = area.endpoint
		newEndpoint1 = new Point(@info.position + 1, end.getY())
		areaLeft = new Area(base.copy(), newEndpoint1)

		newStartpoint2 = new Point(@info.position, base.getY())
		areaRight = new Area(newStartpoint2, end.copy())

		area.addChild(areaLeft)
		area.addChild(areaRight)


	class Info
		constructor: (@area) ->
			@separation = null
			@position = null

		randomize: ->
			if (!@separation?)
				this.setRandomSeparation()
			if (!@position?) 
				this.setRandomPosition()

		setRandomSeparation: ->
			switch Math.randomInt({upperLimit:2})
				when 0 then @separation = AreaSeparator.VERTICAL
				when 1 then @separation = AreaSeparator.HORIZONTAL

		setRandomPosition: ->
			areaMin = Room.MINIMUM_SIZE + Area.BOTH_WALL_MIN + Area.FRAME
			switch(@separation)
				when AreaSeparator.VERTICAL
					range =
						min: areaMin
						upperLimit: @area.height() - areaMin
					@position = Math.randomInt(range)
				when AreaSeparator.HORIZONTAL
					range =
						min: areaMin
						upperLimit: @area.width() - areaMin
					@position = Math.randomInt(range)

		validate: ->
			if (@area? && @separation? && @position?)
				#ok!
			else
				throw new Error("情報たりないっすよ先生 area:#{@area}, separation:#{@separation}, position:#{@position}")
			switch @separation
				when AreaSeparator.VERTICAL
					if ((@position < @area.basepoint.getY() + 2) || (@position > @area.endpoint.getY() - 2))
						throw new OverflowBorderError(@area, @position)
				when AreaSeparator.HORIZONTAL
					if (@position < @area.basepoint.getX() + 2 || @position > @area.endpoint.getX()-2)
						throw new OverflowBorderError(@area, @position)
		canSeparate: ->
			areaMin = Room.MINIMUM_SIZE + Area.BOTH_WALL_MIN + Area.BOTH_FRAMES
			minSize = areaMin*2-1 # -1してるのはFRAMEがかぶるから。
			return (@area.width() >= minSize && @area.height() >= minSize)
