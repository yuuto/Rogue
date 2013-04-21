class Range
	constructor: (object) ->
		if(object.constructor.name != "Object")
			throw new Error("#{object} is not instance of Object")

		if(object.min?)
			@min = object.min
		else if(object.lowerLimit?)
			@min = object.lowerLimit+1
		else
			@min = 0

		if(object.max?)
			@max = object.max
		else if (object.upperLimit?)
			@max = object.upperLimit-1
		else
			throw new IllegalRangeError(object)
		if @min > @max
			throw new IllegalRangeError(object)

	lowerLimit: ->
		return @min - 1
	upperLimit: ->
		return @max + 1
	toString: ->
		return "min: #{@min}, max: #{@max}"


Math.randomInt = (obj) ->
	range = new Range(obj)
	return Math.floor(Math.random() * (range.upperLimit() - range.min)) + range.min

# max = 2, margin = 1 -> failure
# max = 3, margin = 1 -> {2}
# max = 4, margin = 1 -> {2,3}
Math.randomMarginInt = (max, margin) ->
	if (max <= margin * 2)
		throw new HugeMarginError(max, margin)
	return Math.randomInt(upperLimit:max - (margin * 2)) + margin + 1


String.createIndentLine = (level, str) ->
	strline  = ""
	strline += "  " for [0...level]
	strline += str + "\n"
	return strline

