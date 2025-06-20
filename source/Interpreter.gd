extends Node

const marble_diameter = 22 
const default_speed : int = 200 # also defined in Defaults
const playfield_center = Vector2(1920/2, 1080/2)
const playfield_radius = 450 # also defined in White_Marble.gd
# 450 is a magic constant, affected by radius of playing field minus radius of marble.
# It would be 455, but there is a bug I don't understand where marbles on the very edge of the board, if still, don't respond to collisions.

const colors = ["black", "white", "red", "yellow", "blue", "orange", "green", "purple", "gray", "brown"]
const color_codes = ["k", "w", "r", "y", "b", "o", "g", "p", "a", "n"]

const marble_scene = preload("res://Marble.tscn")
const black_scene = preload("res://Black_Marble.tscn")
const white_scene = preload("res://White_Marble.tscn")
const player_scene = preload("res://Player_Marble.tscn")

const playfield_images = [
"res://Assets/Wood_Board.png",    "res://Assets/Moon_Board.png",   "res://Assets/Whirlpool_Board.png", 
"res://Assets/YinYang_Board.png", "res://Assets/RedEye_Board.png", "res://Assets/Creatures_Board.png",             
"res://Assets/Shell_Board.png",   "res://Assets/Galaxy_Board.png", "res://Assets/Metatron_Board.png", 
"res://Assets/Engine_Board.png",  "res://Assets/Nebula_Board.png", "res://Assets/Pandemonium_Board.png", 
"res://Assets/Squares_Board.png"]

# Defined in game_board.gd
#class scoring_condition:
#	var color : int = 0 # What color does this pertain to?
#	var comparator : String = "" # What condition are we using to judge the amount of them?
#	var test_value : int = 0 # How many of them should we compare against?
#	var min_max : int = 0 # Is a better time lower or higher than the current?
#	var best_time : int = 0 # Stores the best time.
#	var label : String = "" # Stores the user's label to present the time in the menu.


var game_board 
func _ready() -> void: game_board = get_parent()


func interpret_delays(input) -> void:
	game_board.delayed_commands = []           # Reset the single firing buffer.
	game_board.repeating_delayed_commands = [] # Reset the repeating buffer.
	for line in input.to_lower().split("\n"): # Break the input string into lines.
		if (line.left("$delay ".length()) == "$delay "): # If the first word in the line is "$delay", 
			var argv = line.split(" ")                   # Split the line into words.
			
			if (argv.size() == 2): # Special case, no command to execute, just wait.
				game_board.delayed_commands.append([float(argv[1]), ""])
				continue
			
			line = line.substr(argv[0].length() + 1 + argv[1].length() + 1) # Remove the delay command and time input.
			if (argv[2] == "repeat"):                    # If the third word is "repeat",
				line = line.substr(argv[2].length() + 1) # Remove the repeat flag.
				game_board.repeating_delayed_commands.append([float(argv[1]), line]) # Add the command to the repeating buffer.
			game_board.delayed_commands.append([float(argv[1]), line]) # Either way add the command to the single firing buffer.


# Ignores anything starting with "$delay".
func interpret_commands(input) -> void: # Assumes input of string[]
	for line in input.split("\n"): # Split the input into lines, and iterate over the lines.
		var argv = line.to_lower().split(" ") # Split the current line into words, tolerating capital letters.
		
		
		if (argv.size() >= 1):
			match argv[0]:
				"$quit": game_board.to_main_menu(); continue
		
		
		if (argv.size() >= 2):
			match argv[0]:
				"$board": game_board.get_node("Playing_Field").texture = load(playfield_images[int(argv[1]) % playfield_images.size()]); continue
				
				"$mouse_control":    if (read_bool(argv[1]) != -1): game_board.mouse_control = read_bool(argv[1]); continue
				"$highlight_player": if (read_bool(argv[1]) != -1): game_board.highlight_player = read_bool(argv[1]); continue
				"$quit_on_death":    if (read_bool(argv[1]) != -1): game_board.quit_on_death = read_bool(argv[1]); continue
				"$vampiric_player":  if (read_bool(argv[1]) != -1): game_board.vampiric_player = read_bool(argv[1]); continue
				
				"$primary_wall_avoidance":    if (read_bool(argv[1]) != -1): game_board.primary_wall_avoidance = read_bool(argv[1]); continue
				"$secondary_wall_avoidance":  if (read_bool(argv[1]) != -1): game_board.secondary_wall_avoidance = read_bool(argv[1]); continue
				"$secondary_other_avoidance": if (read_bool(argv[1]) != -1): game_board.secondary_other_avoidance = read_bool(argv[1]); continue
		
		
		if (argv.size() >= 3):
			match argv[0]:
				"$cohesion_range": if (read_color(argv[1]) != -1):     game_board.cohesion_range[read_color(argv[1])] = int((float(argv[2]) * marble_diameter) ** 2); continue
				"$alignment_range": if (read_color(argv[1]) != -1):   game_board.alignment_range[read_color(argv[1])] = int((float(argv[2]) * marble_diameter) ** 2); continue
				"$alignment_weight": if (read_color(argv[1]) != -1): game_board.alignment_weight[read_color(argv[1])] = float(argv[2]); continue
				"$separation_range": if (read_color(argv[1]) != -1): game_board.separation_range[read_color(argv[1])] = int((float(argv[2]) * 22) ** 2); continue
				"$flee_range": if (read_color(argv[1]) != -1):             game_board.flee_range[read_color(argv[1])] = int((float(argv[2]) * marble_diameter) ** 2); continue
				"$attack_range": if (read_color(argv[1]) != -1):         game_board.attack_range[read_color(argv[1])] = int((float(argv[2]) * marble_diameter) ** 2); continue
				
				"$freeze": if (read_color(argv[1]) != -1 && read_bool(argv[2]) != -1): game_board.frozen_colors[read_color(argv[1])] = read_bool(argv[2]); continue
				
				"$speed": if (read_color(argv[1]) != -1): game_board.marble_speed[read_color(argv[1])] = int(float(argv[2]) * game_board.Defaults.default_speed); continue
		
		
		if (argv.size() >= 4):
			match argv[0]:
				"$behavior": if (read_color(argv[1]) != -1 && read_color(argv[2]) != -1): game_board.behavior_table[read_color(argv[1])][read_color(argv[2])] = int(argv[3]) % 4; continue
				
				
				"$collision": 
					var arg1 = read_color(argv[1]); var arg2 = read_color(argv[2])
					if (arg1 != -1 && arg2 != -1):
						var arg3 = int(argv[3]) % 4
						if (arg1 > arg2): 
							game_board.collision_table[arg1][arg2] = arg3
							game_board.collision_commands[arg1][arg2] = line.substr(argv[0].length() + 1 + argv[1].length() + 1 + argv[2].length() + 1 + argv[3].length())
						else: # Invert 1 and 2
							if (arg3 % 4 == 1 || arg3 % 4 == 2): game_board.collision_table[arg2][arg1] = 3 - arg3 
							else:                                game_board.collision_table[arg2][arg1] = arg3
							game_board.collision_commands[arg2][arg1] = line.substr(argv[0].length() + 1 + argv[1].length() + 1 + argv[2].length() + 1 + argv[3].length())
					continue
				
				
				"$place":
					argv.append_array(["", ""]) # So it doesn't crash without enough arguments.
					if (argv[1] == "player"): 
						if (argv[2] == "polar"): 
							if (read_color(argv[3]) != -1): place_marble(polar_to_board(read_float(argv[4]), argv[5]), read_color(argv[3]), true)
						else:                    
							if (read_color(argv[2]) != -1): place_marble(rectangular_to_board(read_float(argv[3]), read_float(argv[4])), read_color(argv[2]), true)
					elif (argv[1] == "polar"):   
						if (read_color(argv[2]) != -1): place_marble(polar_to_board(read_float(argv[3]), argv[4]), read_color(argv[2]), false)
					else:                        
						if (read_color(argv[1]) != -1): place_marble(rectangular_to_board(read_float(argv[2]), read_float(argv[3])), read_color(argv[1]), false)
					continue
				
				
				"$score":
					if (read_color(argv[1]) != -1 && read_comparator(argv[2]) != "" && read_min_max(argv[4]) != -1): 
						var condition : Game_Board.scoring_condition = Game_Board.scoring_condition.new()
						condition.color = read_color(argv[1])
						condition.comparator = read_comparator(argv[2])
						condition.test_value = int(argv[3])
						condition.min_max = read_min_max(argv[4])
						condition.label = line.right(line.length() - (line.find("|") + 1)).replace("\\n", "\n")
						game_board.scoring_conditions.append(condition)
					continue
				
				
				# $label should only be used by the player in the custom level.
				"$label": Persist.save_label(int(argv[1])/255.0, int(argv[2])/255.0, int(argv[3])/255.0, line.right(line.length() - (line.find("|") + 1)).replace("\\n", "\n")); continue
		
		
		
		




func place_marble(location : Vector2, color : int, is_player : bool = false) -> void:
	var new_marble
	if is_player: new_marble = player_scene.instantiate()
	else:
		if (color == 0):   new_marble = black_scene.instantiate()
		elif (color == 1): new_marble = white_scene.instantiate()
		else:              new_marble = marble_scene.instantiate()
	new_marble.position = location
	game_board.add_child(new_marble)
	if is_player: new_marble.player_ready(color)
	else:         new_marble.marble_ready(color)
	game_board.marble_added(new_marble)

func polar_to_board(radius, angle) -> Vector2: # Every *_to_board function argument is a read_* result, except angle.
	radius *= playfield_radius                 # angle should not go through fmod(angle, 1.0).
	if (angle == "random"): angle = randf_range(0, 2.0 * PI)
	return Vector2((cos(-float(angle)) * radius) + playfield_center.x, (sin(-float(angle)) * radius) + playfield_center.y)

func rectangular_to_board(x, y) -> Vector2: 
	if (round_to_place(abs(y), 2) != round_to_place(sin(acos(x)), 2)): y = fmod(y, sin(acos(x)))
	return Vector2((x * playfield_radius) + playfield_center.x, -(y * playfield_radius) + playfield_center.y)

func read_color(input : String) -> int:
	var                output = colors.find(input)
	if (output == -1): output = color_codes.find(input)
	return output

func read_bool(input : String) -> int:
	if (input == "true" || input == "1"): return 1
	if (input == "false" || input == "0"): return 0
	return -1

func read_float(input : String) -> float:
	if (input == "random"):        return randf_range(-1.0, 1.0)
	# Clean the input, modulus will turn 1 to 0.
	if (abs(float(input)) == 1.0): return float(input)
	else:                          return fmod(float(input), 1.0)

func read_comparator(input : String) -> String:
	if   input == "==": return input
	elif input == "!=": return input
	elif input == "<" : return input
	elif input == ">" : return input
	elif input == "<=": return input
	elif input == ">=": return input
	else:               return ""

func read_min_max(input : String) -> int:
	if   input == "min": return 0
	elif input == "max": return 1
	else: return -1



func round_to_place(input : float, place : int): return round(input * pow(10, place))/pow(10, place)
