class Room
	@MINIMUM_SIZE: 3
	constructor: (@basepoint, @endpoint) ->
		@gates = {}

	putGate: (point, otherRoom) ->
		@gates[otherRoom] = point

	getGate: (otherRoom) ->
		return @gates[otherRoom]

	toString: ->
		return "base: #{@basepoint}, end:#{@endpoint}"

