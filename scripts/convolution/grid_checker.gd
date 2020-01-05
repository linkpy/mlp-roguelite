### \description Grid-based pattern checker for the 
###              convolution algo.
###
### The grid works as such :
### - it doesn't check empty spaces (`" "`) ;
### - the index of a letter correspond to an input of the
###   convolution algorithm (a = first input, z = 26th 
###   input) ;
### - a lowercase letter expects a void from the given 
###   input : `b` means the 2nd input should return -1.
### - a uppercase letter expects a non-void from the given
###   input : `A` means the 1st input should return 1.
###
class_name ConvolutionGridChecker
extends Convolution.Checker



### \description Grid used by the checker.
var grid: Array



###################################################### _init
func _init(g: Array) -> void:
	grid = g



############################################################
### \description Create a new instance with the same grip
###              flipped horizontaly.
###
func flip_h():
	var newgrid = []
	
	for line in grid:
		var newline = ""
		
		for x in range(line.length()):
			newline += line[line.length() - 1 - x]
		
		newgrid.push_back(newline)
	
	return get_script().new(newgrid)

############################################################
### \description Create a new instance with the same grip
###              flipped vertically.
###
func flip_v():
	var newgrid = grid.duplicate()
	newgrid.invert()
	
	return .new(newgrid)



###################################################### check
func check(pos: Vector2, ifn: FuncRef) -> bool:
	var size = grid.size()
	
	for x in range(size):
		for y in range(size):
			var cpos = pos
			cpos.x += x - floor(size/2)
			cpos.y += y - floor(size/2)
			
			var ch = grid[y][x]
			
			if ch == " ":
				continue
			
			var expect_void = ch.to_lower() == ch
			var layer = ord(ch.to_lower()) - ord('a')
			var value = ifn.call_func(layer, cpos)
			
			if value != -1 and expect_void:
				return false
			if value == -1 and not expect_void:
				return false
	
	return true
