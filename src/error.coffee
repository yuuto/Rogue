class BaseError extends Error
	constructor: ->
		this.name = this.constructor.name

class OverflowBorderError extends BaseError
	constructor: (area, borderPosition) ->
		super()
		this.message = "はみだしていらっしゃいます" 
		this.message += "\n" + area.basepoint.toString() 
		this.message += "\n" + area.endpoint.toString() 
		this.message += "\nborderPosition: " + borderPosition

class IllegalRangeError extends BaseError
	constructor: (obj) ->
		super()
		this.message = "へんちくりんな指定の範囲を使おうとしてますね。お気をつけて。"
		for key of obj
			this.message += "\n #{key}=#{obj[key]}"

class HugeMarginError extends BaseError
	constructor: (max, margin) ->
		super()
		this.message = "まーじんでかすぎわろた"
		this.message += "\n max=#{max}, margin=#{margin}"

class NoOverlapError extends BaseError
	constructor: ->
		super()
		this.message = "かさなってないっす"