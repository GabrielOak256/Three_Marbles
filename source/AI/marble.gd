class_name Marble extends RigidBody2D

const marble_images = [
"res://Assets/Black_Marble.png", "res://Assets/White_Marble.png", 
"res://Assets/Red_Marble.png", "res://Assets/Yellow_Marble.png", 
"res://Assets/Blue_Marble.png", "res://Assets/Orange_Marble.png",
"res://Assets/Green_Marble.png", "res://Assets/Purple_Marble.png", 
"res://Assets/Gray_Marble.png", "res://Assets/Brown_Marble.png"]

# Needed by all marbles.
var color : int = 0 # Which color am I?
var direction : Vector2 = Vector2(0,0) # Which way will I go this physics frame?

# Needed by chase/flee marbles.
var Raycasts : Array[RayCast2D] # To conveniently access child RayCast2D nodes.
var game_board
var grid_tracker # Stores a reference to Game_Board's Grid_Tracker.

var prey_colors : Array[int] # The colors to chase.
var predator_colors : Array[int] # The colors to flee.

var direction_recommendation : Vector2 = Vector2(0,0) # A variable to hold the direction while it is being calculated.

var is_flocking : bool = false # Does this marble flock with any color?

# Needed by flocking marbles.
var other_colors : Array[int] # The colors to at least not bump into.
var flockmate_colors : Array[int] # The colors to flock with.

var hunt_range : int = 0 # The larger of this color's attack_range and flee_range. Only calculated if this is a flocking marble.
var scan_range : int = 0 # How far do I look for flockmates?

var flockmates : Array # Who with flockmate colors is in range?
var others : Array     # Who without notable colors is in range?
var hunt               # Who is the nearest predator or prey? (Flocking marbles will chase/flee either depending on amount of allies.)
var in_separation_range : int = 0 # How many are in range to be considered by the separation rule?
var in_alignment_range : int = 0  # How many are in range to be considered by the alignment rule?
var in_cohesion_range : int = 0   # How many are in range to be considered by the cohesion rule?
var separation_recommendation : Vector2 = Vector2(0,0) # Accumulates where it should go according to the separation rule.
var alignment_recommendation : Vector2 = Vector2(0,0)  # Accumulates where it should go according to the alignment rule.
var cohesion_recommendation : Vector2 = Vector2(0,0)   # Accumulates where it should go according to the cohesion rule.

signal color_changed(marble)

# Not _on_ready() -> void: , because in GDScript constructors cannot take arguments.
func marble_ready(set_color : int) -> void:
	
	set_lock_rotation_enabled(true) # Get RigidBody2D child in order.
	Raycasts = [$"RayCast2D 1", $"RayCast2D 2", $"RayCast2D 3", $"RayCast2D 4"] # Initialize var Raycasts with Raycast2D children for convenience.
	game_board = get_parent()                          # Initialize game_board member variable.
	grid_tracker = game_board.get_node("Grid_Tracker") # Initialize grid_tracker member variable.
	evaluate_color(set_color)

func evaluate_color(set_color : int):
	color = set_color % marble_images.size() # Initialize colors member variable.
	$Sprite2D.texture = load(marble_images[color]) # Get Sprite2D child in order.
	
	if (game_board.frozen_colors[color]): freeze = true
	else:                                 freeze = false
	
	other_colors = []
	prey_colors = []
	predator_colors = []
	flockmate_colors = []
	
	for i in  game_board.behavior_table[color].size(): # Store the indexes of the relevant colors in their appropriate lists.
		if   (game_board.behavior_table[color][i] == 1): prey_colors.append(i)
		elif (game_board.behavior_table[color][i] == 2): predator_colors.append(i)
		elif (game_board.behavior_table[color][i] == 3): flockmate_colors.append(i)
	
	if (flockmate_colors): is_flocking = true  # Initialize is_flocking member variable.
	else:                  is_flocking = false 
	
	if is_flocking: # The below is only relevant for flocking marbles.
		for i in  game_board.behavior_table[color].size():
			if   (game_board.behavior_table[color][i] == 0): other_colors.append(i)
		
		scan_range = ceil((max(game_board.cohesion_range[color], # Initialize var scan_range with largest of the flocking ranges (usually cohesion_range), 
							  game_board.alignment_range[color], # divided by the length of a grid_tracker tile (96).
							  game_board.separation_range[color]) ** 0.5) / 96) # The flocking *_range variables are stored squared to ease the navigation algorithm.
		if (scan_range > grid_tracker.search_pattern.size()): scan_range = grid_tracker.search_pattern.size() # Do range checking before passing to the search function.
		
		hunt_range = max(game_board.attack_range[color], game_board.flee_range[color]) # Initialize var hunt_range with the larger of this color's flee_range and attack_range.

func _integrate_forces(state : PhysicsDirectBodyState2D):
	direction = decide_direction()
	state.apply_force(direction * game_board.marble_speed[color])


func decide_direction() -> Vector2:
	
	if prey_colors || predator_colors: hunt = grid_tracker.get_nearest(position, prey_colors + predator_colors, self)
	
	direction_recommendation = Vector2(0,0)
	
	if !is_flocking: 
		if hunt: 
			if hunt.color in prey_colors: direction_recommendation = (hunt.position - position).normalized() 
			else:                         direction_recommendation = (position - hunt.position).normalized()
			if game_board.primary_wall_avoidance: return (direction_recommendation.normalized() + avoid_wall(direction_recommendation.angle())).normalized()
			else:                                 return direction_recommendation.normalized()  
		else: return Vector2(0,0)
	
	if flockmate_colors: flockmates = grid_tracker.get_nearby(position, flockmate_colors, self, scan_range)
	if other_colors: others = grid_tracker.get_nearby(position, other_colors, self, 1)
	
	separation_recommendation = Vector2(0,0)
	alignment_recommendation = Vector2(0,0)
	cohesion_recommendation = Vector2(0,0)
	in_separation_range = 0
	in_alignment_range = 0
	in_cohesion_range = 0
	
	for boid in flockmates: 
		var distance = position.distance_squared_to(boid.position) # Apparently distance_squared_to() is cheaper than distance_to()
		if (distance < game_board.separation_range[color]): 
			separation_recommendation += (position - boid.position)
			in_separation_range += 1
		if (distance < game_board.alignment_range[color]):
			alignment_recommendation += boid.direction 
			in_alignment_range += 1
		if (distance < game_board.cohesion_range[color]): 
			cohesion_recommendation += (boid.position - position) 
			in_cohesion_range += 1
	
	if (in_cohesion_range == 0): # There are no flockmates within cohesion_range; Rejoin the flock if there is one.
		var nearest_flockmate = grid_tracker.get_nearest(position, flockmate_colors, self)
		if nearest_flockmate: direction_recommendation = nearest_flockmate.position - position
	
	if hunt: 
		var distance = position.distance_squared_to(hunt.position)
		if (distance < hunt_range): 
			if (in_cohesion_range == 0): in_cohesion_range = 1 # So it doesn't stall if it's alone.
			if hunt.is_flocking: 
				if   ((distance < game_board.flee_range[color]) && (hunt.in_cohesion_range > in_cohesion_range)):
					separation_recommendation += (position - hunt.position) * in_cohesion_range
				elif ((distance < game_board.attack_range[color]) && (hunt.in_cohesion_range < in_cohesion_range)):
					cohesion_recommendation += (hunt.position - position) * in_cohesion_range
					alignment_recommendation += hunt.direction * in_cohesion_range
			else: # It doesn't count in_cohesion_range.
				if   ((distance < game_board.flee_range[color]) && (hunt.color in predator_colors)):
					separation_recommendation += (position - hunt.position) * in_cohesion_range
				elif (distance < game_board.attack_range[color] && (hunt.color in prey_colors)): # It is prey, not a predator. Chase if in range. 
					cohesion_recommendation += (hunt.position - position) * in_cohesion_range
					alignment_recommendation += hunt.direction * in_cohesion_range
	
	if game_board.secondary_other_avoidance:
		for boid in others: 
			if (position.distance_squared_to(boid.position) < game_board.separation_range[color]):
				separation_recommendation += (position - boid.position)
	
	if in_separation_range: direction_recommendation += separation_recommendation.normalized()/in_separation_range
	if in_alignment_range: direction_recommendation += game_board.alignment_weight[color] * alignment_recommendation.normalized()/in_alignment_range
	if in_cohesion_range: direction_recommendation += cohesion_recommendation.normalized()/in_cohesion_range
	
	if game_board.secondary_wall_avoidance: return (direction_recommendation.normalized() + avoid_wall(direction_recommendation.angle())).normalized()
	else:                                   return direction_recommendation.normalized()  
	


func avoid_wall(direction_angle : float) -> Vector2:
	# Point each vector to the specified point about the given angle.
	$"RayCast2D 1".target_position = rotate_Vector2(Vector2(32, 48), direction_angle) 
	$"RayCast2D 2".target_position = rotate_Vector2(Vector2(96, 16), direction_angle)
	$"RayCast2D 3".target_position = rotate_Vector2(Vector2(112, -16), direction_angle) 
	$"RayCast2D 4".target_position = rotate_Vector2(Vector2(32, -48), direction_angle)
	
	var recommendation : Vector2 = Vector2(0,0)                   # Get a vector away from any collisions, normalize it (to the unit circle), then scale that direction by 100/(length^2). I think that's equivalent to 100/(length^3). 
	for ray in Raycasts: if ray.is_colliding(): recommendation += ( (position - ray.get_collision_point()).normalized() * ( 100/((position - ray.get_collision_point()).length_squared()) ) )
	return recommendation


func _on_body_entered(body: Node) -> void:
	if ("color" in body): # Does whatever it hit have a "color" member? Then we can assume it is a marble. GDScript doesn't support dynamic_cast.
		if (body.color < color): # Action is only this marble's responsibility if this marble's color is greater than or equal the other.
			game_board.collision_noise()
			var table_entry : int = game_board.collision_table[color][body.color]
			
			# If both count flockmates, and it is a color this fights, whoever has more wins.
			if (is_flocking && body.is_flocking && ((table_entry == 1) || (table_entry == 2))):
				if   (in_cohesion_range < body.in_cohesion_range): remove(self)
				elif (in_cohesion_range > body.in_cohesion_range): remove(body)
			else:
				if   (table_entry == 1): remove(body)
				elif (table_entry == 2): remove(self)
				elif (table_entry == 3): remove(body); remove(self)
			
			
			var command : String = game_board.collision_commands[color][body.color]
			if command != "": # If it's supposed to do something on this kind of collision:
				var interpreter = game_board.get_node("Interpreter")
				var pos = command.find("$")
				if (pos != -1): # If there is a conventional command, run it through the interpreter, and save the rest of the line.
					interpreter.call_deferred("interpret_commands", command.substr(pos))
					command = command.left(pos)
				var argv = command.split(" ")
				for arg in argv: # place each named color
					var color = interpreter.read_color(arg) 
					if (color != -1): interpreter.call_deferred("place_marble", position, color) # call_deferred because, ... instantiating a physics object mid-frame confuses it? lock_rotation returns true, while the marbles spin about.
			
			



func remove(marble): 
	game_board.marble_removed(marble)
	marble.queue_free()


func rotate_Vector2(vec : Vector2, ang : float) -> Vector2: return Vector2(vec.x * cos(ang) - vec.y * sin(ang), vec.x * sin(ang) + vec.y * cos(ang))
