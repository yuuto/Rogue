class StageBuilder

	constructor: () ->


	width: (width) ->
		@width = width
	height: (height) ->
		@height = height

	build: () ->
		@stage = new Stage(@width, @height)
		# TODO ここでAreaとかRoomとかも生成するよ
		return @stage