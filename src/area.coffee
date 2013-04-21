# Area とは、二次元平面上の矩形を表す始点・終点のペアである。
# たとえば、(1,1)-(3,4) は下のように図示される。
# endpoint.getX(), getY()をコールする場合はその情報を位置情報に使うのであれば
# -1した値を使わなければならない点に注意。
# ex) 右端の列を指し示す場合など。
#  0123456789
# 0..........
# 1.**.......
# 2.**.......
# 3.**.......
# 4..........
# 5..........

class Area
	# 2 で掛け算をしているのは、上下もしくは左右の厚みを含んでいるからです。
	# なぜなら、部屋の大きさを計算するときに都合がよいからです。
	@FRAME: 1
	@BOTH_FRAMES: 2
	@WALL_MIN: 1
	@BOTH_WALL_MIN: 2
	constructor: (@basepoint, @endpoint) ->
		@children=[]
		@room = null

	addChild: (child) ->
		@children.push(child)

	getChildren: ->
		return @children

	width: ->
		return @endpoint.getX() - @basepoint.getX()

	height: -> 
		return @endpoint.getY() - @basepoint.getY()

	leftTop: ->
		return @basepoint

	rightTop: ->
		return new Point(@endpoint.getX(), @basepoint.getY())

	leftBottom: ->
		return new Point(@basepoint.getX(), @endpoint.getY())

	rightBottom: ->
		return @endpoint

	getFirstChild: ->
		if (@children.length == 0)
			throw new Error("子供がいないでござる")
		return @children[0]

	hasChild: ->
		return @children.length > 0

	isBottomOverlap: (other) ->
		return (@endpoint.getY() - 1) == other.basepoint.getY()

	isLeftOverlap: (other) ->
		return @basepoint.getX() == (other.endpoint.getX() - 1)

	isTopOverlap: (other) ->
		return other.isBottomOverlap(this)

	isRightOverlap: (other) ->
		return other.isLeftOverlap(this)

	findOverlap: (other) ->
		#1 下辺
		if (this.isBottomOverlap(other))
			return new Area(this.leftBottom(), this.rightBottom())
		#2 左辺
		if (this.isLeftOverlap(other))
			return new Area(this.leftTop(), this.leftBottom())
		#3 上辺
		if (this.isTopOverlap(other))
			return new Area(this.leftTop(), this.rightTop())
		#4 右辺
		if (this.isRightOverlap(other))
			return new Area(this.rightTop(), this.rightBottom())

		throw new NoOverlapError()

	getRoom: ->
		return @room

	toString: ->
		return "base: #{@basepoint}, end:#{@endpoint}"

	toStringRecursive: (level=0) ->
		if @children.length == 0
			if @room?
				return "*#{this.toString()} ROOM: #{@room.toString()} \n"
			else
				return "*#{this.toString()}\n"
		else
			result = this.toString() + "\n"
			for i in [0...@children.length]
				result += "  " for [0...level+1]
				result += @children[i].toStringRecursive(level+1)
			return result