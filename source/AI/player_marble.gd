class_name Player_Marble extends Marble

func player_ready(set_color : int = 4) -> void: # 4 is Blue
	marble_ready(set_color)
	if (game_board.highlight_player): $Player_Outline.show()

# Overwrites Marble's decide_direction.
func decide_direction() -> Vector2:
	if flockmate_colors: 
		flockmates = grid_tracker.get_nearby(position, flockmate_colors, self, scan_range)
		in_cohesion_range = 0
		for boid in flockmates: if (position.distance_squared_to(boid.position) < game_board.cohesion_range[color]): in_cohesion_range += 1
	
	if game_board.mouse_control: return (get_viewport().get_mouse_position() - position).normalized()
	else: 
		var heading = Vector2(0,0)
		if Input.is_action_pressed("move_right"): heading.x += 1
		if Input.is_action_pressed("move_left"):  heading.x -= 1
		if Input.is_action_pressed("move_down"):  heading.y += 1
		if Input.is_action_pressed("move_up"):    heading.y -= 1
		return heading.normalized()



# Overwrites Marble's _on_body_entered() with mostly identical code.
func _on_body_entered(body: Node) -> void:
	if ("color" in body): # Does whatever it hit have a "color" member? Then we can assume it is a marble. GDScript doesn't support dynamic_cast.
		if (body.color <= color): # Action is only this marble's responsibility if this marble's color is greater than or equal the other.
			game_board.collision_noise()
			var table_entry : int = game_board.collision_table[color][body.color]
			
			# If both count flockmates, and it is a color this fights, whoever has more wins.
			if (is_flocking && body.is_flocking && ((table_entry == 1) || (table_entry == 2))):
				if   (in_cohesion_range < body.in_cohesion_range): remove(self)
				elif (in_cohesion_range > body.in_cohesion_range): remove(body)
			else:
				if (table_entry == 1): remove(body)
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
			
			
		else: # Special behaviors that standard marbles cannot be expected to handle:
			var table_entry : int = game_board.collision_table[body.color][color] # now inverted
			if (is_flocking && body.is_flocking && ((table_entry == 1) || (table_entry == 2))):
				if ((in_cohesion_range > body.in_cohesion_range) && game_board.vampiric_player): 
					body.queue_free() # When we copy the marble's color, it will no longer see us as a predator, and not remove itself.
					game_board.marble_removed(body)
					evaluate_color(body.color)
					color_changed.emit(self)
				elif (in_cohesion_range < body.in_cohesion_range): game_board.player_died()
			else:
				if   (table_entry == 1): game_board.player_died()
				elif (table_entry == 2): 
					if (game_board.vampiric_player): 
						body.queue_free() # When we copy the marble's color, it will no longer see us as a predator, and not remove itself.
						game_board.marble_removed(body)
						evaluate_color(body.color)
						color_changed.emit(self)
		



# Overwrites Marble's remove().
func remove(marble): 
	game_board.marble_removed(marble)
	if (marble == self): game_board.player_died()
	elif (game_board.vampiric_player): 
		evaluate_color(marble.color)
		color_changed.emit(self)
	marble.queue_free() 
