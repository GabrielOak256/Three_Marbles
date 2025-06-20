class_name White_Marble extends Marble

const playfield_radius : int = 450 # also defined in interpreter.gd

var next_target : Vector2 

const timeout : int = 5 # How long will the marble try to reach its target before giving up?
var move_on : bool = false # Is it currently giving up?

# This function overwrites the version in parent. 
func marble_ready(set_color : int) -> void:
	
	set_lock_rotation_enabled(true) # Get RigidBody2D child in order.
	Raycasts = [$"RayCast2D 1", $"RayCast2D 2", $"RayCast2D 3", $"RayCast2D 4"] # Initialize var Raycasts with Raycast2D children for convenience.
	game_board = get_parent()                          # Initialize game_board member variable.
	grid_tracker = game_board.get_node("Grid_Tracker") # Initialize grid_tracker member variable.
	evaluate_color(set_color)
	
	# Unique stuff below:
	
	if (position.x > 960): 
		right_or_left *= -1
	if (position.y > 540):
		up_or_down *= -1
		switch *= -1
	
	next_target = get_next_target() # This has to be called once to initialize it.
	
	$Timer.start(timeout)


# This function overwrites the version in parent. 
func decide_direction() -> Vector2:
	
	if (position.distance_to(next_target) < 6 || move_on): # 6 pixels is close enough.
		move_on = false
		$Timer.start(timeout)
		set_linear_velocity(Vector2(0,0)) # Stop the marble before it overshoots.
		next_target = get_next_target()
	
	return (next_target - position).normalized()


var right_or_left : int = 1     # imitation static variable
var up_or_down : int = 1        # imitation static variable
var switch : int = 1            # imitation static variable
var just_crossed : bool = false # imitation static variable
func get_next_target() -> Vector2:
	 
	# Get the relationship between the marble and the origin.
	var from_origin : Vector2 = position - Vector2(960, 540)
	
	# If we have gotten to the top or bottom, go the other way.
	if  (from_origin.y < -(playfield_radius - 20)): up_or_down = -1
	elif (from_origin.y > (playfield_radius - 20)): up_or_down = 1
	
	# Is this function call to cross the board, or to set up for the next crossing?
	if (just_crossed):
		just_crossed = false
		switch *= -1 # Without the switch, the marble goes in circles.
		# According to an ico triangle calculator, 0.04944 is the angle between the legs of a 445,445,22 triangle.
		return rotate_Vector2(from_origin, 0.04944 * up_or_down * switch) + Vector2(960,540)
	else:
		just_crossed = true
		right_or_left *= -1 # Which way to cross?
		return Vector2(right_or_left * (playfield_radius * cos(asin( (position.y - 540) / playfield_radius )) ) + 960, position.y) # This line of code was a big part of your first all-nighter.


func _on_timer_timeout() -> void: move_on = true
