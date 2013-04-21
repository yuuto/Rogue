# immutable
# This class is Point on the coordinate system
class Point
	constructor: (@x, @y) ->

	copy: ->
		return new Point(@x, @y)

	toString: ->
		return "(#{@x}, #{@y})"

	getX: ->
		return @x

	getY: ->
		return @y

	equal: (other)->
		return (@x == other.x) && (@y == other.y)

	shift: (dx, dy) ->
		return new Point(@x+dx, @y+dy)
		