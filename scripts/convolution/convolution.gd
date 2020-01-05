### \description Convolution algorithm for pattern detection
###              in a discret 2D plane.
###
### The algorithm uses a set of inputs and a set of 
### checkers. The input are used to retreive data for the
### checkers, to detect patterns.
###
class_name Convolution
extends Reference



############################################################
### \description Convolution input.
###
class CInput extends Reference:
	########################################################
	### \description Get the value of the input at the given
	###              position.
	###
	### \note Should returns -1 if there is nothing.
	###
	func get_value(_position: Vector2) -> int:
		return -1

############################################################
### \description Pattern checker.
###
class Checker extends Reference:
	########################################################
	### \description Check if a pattern is detected at the
	###              given position.
	###
	func check(_position: Vector2, _fn: FuncRef) -> bool:
		return false



### \description Inputs of the convolution algorithm.
var inputs: Array = []
### \description Checkers of the convolution algorithm.
var checkers: Array = []



############################################################
### \description Add an input to the convolution algo.
###
func add_input(inp: CInput):
	inputs.push_back(inp)
	return self

############################################################
### \description Add a checker to the convolution algo.
###
### \note The callback is called when the associated checker
###       detects a pattern.
###
func add_checker(chk: Checker, cb: FuncRef):
	if cb != null:
		assert(cb.is_valid())
	
	checkers.push_back([chk, cb])
	return self



############################################################
### \decription Run the convolution algorithm on the given
###             positions.
###
func process(positions: Array) -> void:
	var chk_ifn = funcref(self, "_checker_input_fn")
	
	for pos in positions:
		for checker in checkers:
			var chk = checker[0]
			var cb = checker[1]
			
			if chk.check(pos, chk_ifn):
				if cb != null:
					if not cb.is_valid():
						printerr("The callback shouldn't be invalid.")
					else:
						cb.call_func(pos)



############################################################
### \description Function passed to the checkers.
###
func _checker_input_fn(layer: int, position: Vector2) -> int:
	assert(layer >= 0 and layer < inputs.size())
	return inputs[layer].get_value(position)
