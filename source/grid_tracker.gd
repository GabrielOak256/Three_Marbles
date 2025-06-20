extends Node2D

# This is the list of points around a lattice point at radius 0 through 10. 
const search_pattern := [
[Vector2(0,0), Vector2(0,1), Vector2(1,1), Vector2(1,0), Vector2(1,-1), Vector2(0,-1), Vector2(-1,-1), Vector2(-1,0), Vector2(-1,1)],
[Vector2(0,2), Vector2(1,2), Vector2(2,2), Vector2(2,1), Vector2(2,0), Vector2(2,-1), Vector2(2,-2), Vector2(1,-2), Vector2(0,-2), Vector2(-1,-2), Vector2(-2,-2), Vector2(-2,-1), Vector2(-2,0), Vector2(-2,1), Vector2(-2,2), Vector2(-1,2)],
[Vector2(0,3), Vector2(1,3), Vector2(2,3), Vector2(3,2), Vector2(3,1), Vector2(3,0), Vector2(3,-1), Vector2(3,-2), Vector2(2,-3), Vector2(1,-3), Vector2(0,-3), Vector2(-1,-3), Vector2(-2,-3), Vector2(-3,-2), Vector2(-3,-1), Vector2(-3,0), Vector2(-3,1), Vector2(-3,2), Vector2(-2,3), Vector2(-1,3)],
[Vector2(0,4), Vector2(1,4), Vector2(2,4), Vector2(3,4), Vector2(3,3), Vector2(4,3), Vector2(4,2), Vector2(4,1), Vector2(4,0), Vector2(4,-1), Vector2(4,-2), Vector2(4,-3), Vector2(3,-3), Vector2(3,-4), Vector2(2,-4), Vector2(1,-4), Vector2(0,-4), Vector2(-1,-4), Vector2(-2,-4), Vector2(-3,-4), Vector2(-3,-3), Vector2(-4,-3), Vector2(-4,-2), Vector2(-4,-1), Vector2(-4,0), Vector2(-4,1), Vector2(-4,2), Vector2(-4,3), Vector2(-3,3), Vector2(-3,4), Vector2(-2,4), Vector2(-1,4)],
[Vector2(0,5), Vector2(1,5), Vector2(2,5), Vector2(3,5), Vector2(4,4), Vector2(5,3), Vector2(5,2), Vector2(5,1), Vector2(5,0), Vector2(5,-1), Vector2(5,-2), Vector2(5,-3), Vector2(4,-4), Vector2(3,-5), Vector2(2,-5), Vector2(1,-5), Vector2(0,-5), Vector2(-1,-5), Vector2(-2,-5), Vector2(-3,-5), Vector2(-4,-4), Vector2(-5,-3), Vector2(-5,-2), Vector2(-5,-1), Vector2(-5,0), Vector2(-5,1), Vector2(-5,2), Vector2(-5,3), Vector2(-4,4), Vector2(-3,5), Vector2(-2,5), Vector2(-1,5)],
[Vector2(0,6), Vector2(1,6), Vector2(2,6), Vector2(3,6), Vector2(4,5), Vector2(5,4), Vector2(6,3), Vector2(6,2), Vector2(6,1), Vector2(6,0), Vector2(6,-1), Vector2(6,-2), Vector2(6,-3), Vector2(5,-4), Vector2(4,-5), Vector2(3,-6), Vector2(2,-6), Vector2(1,-6), Vector2(0,-6), Vector2(-1,-6), Vector2(-2,-6), Vector2(-3,-6), Vector2(-4,-5), Vector2(-5,-4), Vector2(-6,-3), Vector2(-6,-2), Vector2(-6,-1), Vector2(-6,0), Vector2(-6,1), Vector2(-6,2), Vector2(-6,3), Vector2(-5,4), Vector2(-4,5), Vector2(-3,6), Vector2(-2,6), Vector2(-1,6)],
[Vector2(0,7), Vector2(1,7), Vector2(2,7), Vector2(3,7), Vector2(4,7), Vector2(4,6), Vector2(5,6), Vector2(6,6), Vector2(6,5), Vector2(6,4), Vector2(7,4), Vector2(7,3), Vector2(7,2), Vector2(7,1), Vector2(7,0), Vector2(7,-1), Vector2(7,-2), Vector2(7,-3), Vector2(7,-4), Vector2(6,-4), Vector2(6,-5), Vector2(6,-6), Vector2(5,-6), Vector2(4,-6), Vector2(4,-7), Vector2(3,-7), Vector2(2,-7), Vector2(1,-7), Vector2(0,-7), Vector2(-1,-7), Vector2(-2,-7), Vector2(-3,-7), Vector2(-4,-7), Vector2(-4,-6), Vector2(-5,-6), Vector2(-6,-6), Vector2(-6,-5), Vector2(-6,-4), Vector2(-7,-4), Vector2(-7,-3), Vector2(-7,-2), Vector2(-7,-1), Vector2(-7,0), Vector2(-7,1), Vector2(-7,2), Vector2(-7,3), Vector2(-7,4), Vector2(-6,4), Vector2(-6,5), Vector2(-6,6), Vector2(-5,6), Vector2(-4,6), Vector2(-4,7), Vector2(-3,7), Vector2(-2,7), Vector2(-1,7)],
[Vector2(0,8), Vector2(1,8), Vector2(2,8), Vector2(3,8), Vector2(4,8), Vector2(5,7), Vector2(6,7), Vector2(7,6), Vector2(7,5), Vector2(8,4), Vector2(8,3), Vector2(8,2), Vector2(8,1), Vector2(8,0), Vector2(8,-1), Vector2(8,-2), Vector2(8,-3), Vector2(8,-4), Vector2(7,-5), Vector2(7,-6), Vector2(6,-7), Vector2(5,-7), Vector2(4,-8), Vector2(3,-8), Vector2(2,-8), Vector2(1,-8), Vector2(0,-8), Vector2(-1,-8), Vector2(-2,-8), Vector2(-3,-8), Vector2(-4,-8), Vector2(-5,-7), Vector2(-6,-7), Vector2(-7,-6), Vector2(-7,-5), Vector2(-8,-4), Vector2(-8,-3), Vector2(-8,-2), Vector2(-8,-1), Vector2(-8,0), Vector2(-8,1), Vector2(-8,2), Vector2(-8,3), Vector2(-8,4), Vector2(-7,5), Vector2(-7,6), Vector2(-6,7), Vector2(-5,7), Vector2(-4,8), Vector2(-3,8), Vector2(-2,8), Vector2(-1,8)],
[Vector2(0,9), Vector2(1,9), Vector2(2,9), Vector2(3,9), Vector2(4,9), Vector2(5,8), Vector2(6,8), Vector2(7,7), Vector2(8,6), Vector2(8,5), Vector2(9,4), Vector2(9,3), Vector2(9,2), Vector2(9,1), Vector2(9,0), Vector2(9,-1), Vector2(9,-2), Vector2(9,-3), Vector2(9,-4), Vector2(8,-5), Vector2(8,-6), Vector2(7,-7), Vector2(6,-8), Vector2(5,-8), Vector2(4,-9), Vector2(3,-9), Vector2(2,-9), Vector2(1,-9), Vector2(0,-9), Vector2(-1,-9), Vector2(-2,-9), Vector2(-3,-9), Vector2(-4,-9), Vector2(-5,-8), Vector2(-6,-8), Vector2(-7,-7), Vector2(-8,-6), Vector2(-8,-5), Vector2(-9,-4), Vector2(-9,-3), Vector2(-9,-2), Vector2(-9,-1), Vector2(-9,0), Vector2(-9,1), Vector2(-9,2), Vector2(-9,3), Vector2(-9,4), Vector2(-8,5), Vector2(-8,6), Vector2(-7,7), Vector2(-6,8), Vector2(-5,8), Vector2(-4,9), Vector2(-3,9), Vector2(-2,9), Vector2(-1,9)],
[Vector2(0,10), Vector2(1,10), Vector2(2,10), Vector2(3,10), Vector2(4,10), Vector2(5,9), Vector2(6,9), Vector2(7,8), Vector2(8,8), Vector2(8,7), Vector2(9,6), Vector2(9,5), Vector2(10,4), Vector2(10,3), Vector2(10,2), Vector2(10,1), Vector2(10,0), Vector2(10,-1), Vector2(10,-2), Vector2(10,-3), Vector2(10,-4), Vector2(9,-5), Vector2(9,-6), Vector2(8,-7), Vector2(8,-8), Vector2(7,-8), Vector2(6,-9), Vector2(5,-9), Vector2(4,-10), Vector2(3,-10), Vector2(2,-10), Vector2(1,-10), Vector2(0,-10), Vector2(-1,-10), Vector2(-2,-10), Vector2(-3,-10), Vector2(-4,-10), Vector2(-5,-9), Vector2(-6,-9), Vector2(-7,-8), Vector2(-8,-8), Vector2(-8,-7), Vector2(-9,-6), Vector2(-9,-5), Vector2(-10,-4), Vector2(-10,-3), Vector2(-10,-2), Vector2(-10,-1), Vector2(-10,0), Vector2(-10,1), Vector2(-10,2), Vector2(-10,3), Vector2(-10,4), Vector2(-9,5), Vector2(-9,6), Vector2(-8,7), Vector2(-8,8), Vector2(-7,8), Vector2(-6,9), Vector2(-5,9), Vector2(-4,10), Vector2(-3,10), Vector2(-2,10), Vector2(-1,10)],
[Vector2(5,10), Vector2(6,10), Vector2(7,9), Vector2(8,9), Vector2(9,8), Vector2(9,7), Vector2(10,6), Vector2(10,5), Vector2(10,-5), Vector2(10,-6), Vector2(9,-7), Vector2(9,-8), Vector2(8,-9), Vector2(7,-9), Vector2(6,-10), Vector2(5,-10), Vector2(-5,-10), Vector2(-6,-10), Vector2(-7,-9), Vector2(-8,-9), Vector2(-9,-8), Vector2(-9,-7), Vector2(-10,-6), Vector2(-10,-5), Vector2(-10,5), Vector2(-10,6), Vector2(-9,7), Vector2(-9,8), Vector2(-8,9), Vector2(-7,9), Vector2(-6,10), Vector2(-5,10)],
[Vector2(7,10), Vector2(8,10), Vector2(9,9), Vector2(10,8), Vector2(10,7), Vector2(10,-7), Vector2(10,-8), Vector2(9,-9), Vector2(8,-10), Vector2(7,-10), Vector2(-7,-10), Vector2(-8,-10), Vector2(-9,-9), Vector2(-10,-8), Vector2(-10,-7), Vector2(-10,7), Vector2(-10,8), Vector2(-9,9), Vector2(-8,10), Vector2(-7,10)],
[Vector2(9,10), Vector2(10,10), Vector2(10,9), Vector2(10,-9), Vector2(10,-10), Vector2(9,-10), Vector2(-9,-10), Vector2(-10,-10), Vector2(-10,-9), Vector2(-10,9), Vector2(-10,10), Vector2(-9,10)]
]

var game_board
var game_ledger
var field : Array

func _ready() -> void:
	game_board = get_parent()
	game_ledger = game_board.game_ledger
	# Collect the Tracker Square child nodes into a convenient array of arrays.
	field = [ # This is a row of columns, so the rest of the program can use: field[x][y]
[     false,      false,      false, $"Sq(0,3)", $"Sq(0,4)", $"Sq(0,5)", $"Sq(0,6)", $"Sq(0,7)",      false,      false,       false],
[     false,      false, $"Sq(1,2)", $"Sq(1,3)", $"Sq(1,4)", $"Sq(1,5)", $"Sq(1,6)", $"Sq(1,7)", $"Sq(1,8)",      false,       false],
[     false, $"Sq(2,1)", $"Sq(2,2)", $"Sq(2,3)", $"Sq(2,4)", $"Sq(2,5)", $"Sq(2,6)", $"Sq(2,7)", $"Sq(2,8)", $"Sq(2,9)",       false],
[$"Sq(3,0)", $"Sq(3,1)", $"Sq(3,2)", $"Sq(3,3)", $"Sq(3,4)", $"Sq(3,5)", $"Sq(3,6)", $"Sq(3,7)", $"Sq(3,8)", $"Sq(3,9)", $"Sq(3,10)"],
[$"Sq(4,0)", $"Sq(4,1)", $"Sq(4,2)", $"Sq(4,3)", $"Sq(4,4)", $"Sq(4,5)", $"Sq(4,6)", $"Sq(4,7)", $"Sq(4,8)", $"Sq(4,9)", $"Sq(4,10)"],
[$"Sq(5,0)", $"Sq(5,1)", $"Sq(5,2)", $"Sq(5,3)", $"Sq(5,4)", $"Sq(5,5)", $"Sq(5,6)", $"Sq(5,7)", $"Sq(5,8)", $"Sq(5,9)", $"Sq(5,10)"],
[$"Sq(6,0)", $"Sq(6,1)", $"Sq(6,2)", $"Sq(6,3)", $"Sq(6,4)", $"Sq(6,5)", $"Sq(6,6)", $"Sq(6,7)", $"Sq(6,8)", $"Sq(6,9)", $"Sq(6,10)"],
[$"Sq(7,0)", $"Sq(7,1)", $"Sq(7,2)", $"Sq(7,3)", $"Sq(7,4)", $"Sq(7,5)", $"Sq(7,6)", $"Sq(7,7)", $"Sq(7,8)", $"Sq(7,9)", $"Sq(7,10)"],
[     false, $"Sq(8,1)", $"Sq(8,2)", $"Sq(8,3)", $"Sq(8,4)", $"Sq(8,5)", $"Sq(8,6)", $"Sq(8,7)", $"Sq(8,8)", $"Sq(8,9)",       false],
[     false,      false, $"Sq(9,2)", $"Sq(9,3)", $"Sq(9,4)", $"Sq(9,5)", $"Sq(9,6)", $"Sq(9,7)", $"Sq(9,8)",      false,       false],
[     false,      false,      false, $"Sq(10,3)", $"Sq(10,4)", $"Sq(10,5)", $"Sq(10,6)", $"Sq(10,7)", false,      false,       false]]

# Returns the location of the nearest marble of a specified color. 
func get_nearest(location : Vector2, colors : Array[int], calling_marble): # returns whatever type manual_search returns
	
	if !not_empty(colors): return null
	
	# The top left corner of the grid is (960 - 96 * 5.5, 540 - 96 * 5.5), or (432, 12).
	# Y is inverted because the screen is drawn from the top.
	# Don't try to start the approximation from the center of the board; You'll have to find a way to round the first half square.
	var start_square := Vector2(floor((location.x - 432) / 96), 10 - floor((location.y - 12) / 96))
	
	var candidates : Array = [] # Declare a container to hold all marbles of interest in a radius.
	for search_radius in search_pattern:
		for square in search_radius:
			if (((start_square.x + square.x) >= 0 && (start_square.x + square.x) < field.size()   ) &&
				((start_square.y + square.y) >= 0 && (start_square.y + square.y) < field[0].size()) &&
				field[start_square.x + square.x][start_square.y + square.y]                       ): # Make sure the offset didn't take us out of bounds.
				for color in colors: candidates.append_array(field[start_square.x + square.x][start_square.y + square.y].ledger[color]) # Collect all entries under the colors of interest from every tile the radius away.
				if (search_radius == search_pattern[0]): candidates.erase(calling_marble) # The marble should not return itself as the nearest of its color.
				if candidates: return manual_search(location, candidates) # If there are any, find the nearest, and return.
	return null # If there aren't any, return the result of manual_search() with an empty array of candidates.


func manual_search(location : Vector2, candidates : Array) -> Node2D:
	# Initialize the first candidate, and run through the list for nearer ones.
	# Return the nearest candidate.
	# If there isn't anything to react to, then we can say nothing.
	if candidates:   
		var nearest = candidates[0]
		for candidate in candidates: # Apparently distance_squared_to() is cheaper than distance_to()
			if (candidate.position.distance_squared_to(location) < nearest.position.distance_squared_to(location)): 
				nearest = candidate
		return nearest
	else: return null 


func get_nearby(location : Vector2, colors : Array[int], calling_marble, range : int = 1): 
	var start_square := Vector2(floor((location.x - 432) / 96), 10 - floor((location.y - 12) / 96))
	var result : Array
	for search_radius in range:
		for square in search_pattern[search_radius]:
			# Make sure the offset didn't take us out of bounds.
			if (((start_square.x + square.x) >= 0 && (start_square.x + square.x) < field.size()   ) &&
				((start_square.y + square.y) >= 0 && (start_square.y + square.y) < field[0].size()) &&
				field[start_square.x + square.x][start_square.y + square.y]                       ): 
				for color in colors: result.append_array(field[start_square.x + square.x][start_square.y + square.y].ledger[color])
	result.erase(calling_marble)
	return result

func not_empty(colors : Array[int]) -> bool:
	for color in colors: if (game_ledger[color] != []): return true
	return false
