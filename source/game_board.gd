class_name Game_Board extends Node2D

# Notes on the game board image made in Blender:
# The top point of the screen is at 0.203906m, while the top of the circle is at 0.175m
# The circular playing field is 993p across.
# There are 60 metal trim pieces.



func _ready() -> void: 
	$AnimationPlayer.play("fade_from_white")
	
	if (Board_Layouts.selection == Board_Layouts.board_layouts.size()): 
		read_input(Persist.load_custom())
	else:                                                               
		read_input(Board_Layouts.board_layouts[Board_Layouts.selection])
	
	$Score_Timer.start(score_clk_rate)


func read_input(input : String) -> void:
	prepare_settings_storage()
	$Interpreter.interpret_delays(input)
	$Interpreter.interpret_commands(input)
	if delayed_commands: $Command_Timer.start(delayed_commands[0][0])



# These can't be initialized with values from Defaults because the engine hasn't gotten to Defaults yet.
const Defaults = preload("res://Defaults.gd")
var mouse_control      : bool         
var highlight_player   : bool         
var quit_on_death      : bool         
var vampiric_player    : bool
var primary_wall_avoidance    : bool
var secondary_wall_avoidance  : bool 
var secondary_other_avoidance : bool
var marble_speed       : Array[int]   
var frozen_colors      : Array[int]  
var behavior_table     : Array        
var collision_table    : Array        
var collision_commands : Array        
var cohesion_range     : Array[int]   
var alignment_range    : Array[int]   
var alignment_weight   : Array[float]   
var separation_range   : Array[int]   
var flee_range         : Array[int]   
var attack_range       : Array[int]   

func prepare_settings_storage() -> void:
	mouse_control      = Defaults.mouse_control    # Bool not Array
	highlight_player   = Defaults.highlight_player # Bool not Array
	quit_on_death      = Defaults.quit_on_death    # Bool not Array
	vampiric_player    = Defaults.vampiric_player  # Bool not Array
	primary_wall_avoidance = Defaults.primary_wall_avoidance       # Bool not Array
	secondary_wall_avoidance = Defaults.secondary_wall_avoidance   # Bool not Array
	secondary_other_avoidance = Defaults.secondary_other_avoidance # Bool not Array
	marble_speed       = Defaults.marble_speed.duplicate(true)
	frozen_colors      = Defaults.frozen_colors.duplicate(true)
	behavior_table     = Defaults.behavior_table.duplicate(true)
	collision_table    = Defaults.collision_table.duplicate(true)
	collision_commands = Defaults.collision_commands.duplicate(true)
	cohesion_range     = Defaults.cohesion_range.duplicate(true)
	alignment_range    = Defaults.alignment_range.duplicate(true)
	alignment_weight   = Defaults.alignment_weight.duplicate(true)
	separation_range   = Defaults.separation_range.duplicate(true)
	flee_range         = Defaults.flee_range.duplicate(true)
	attack_range       = Defaults.attack_range.duplicate(true)



const score_clk_rate : float = 0.1 # time is in tenths of a second.
var play_time        : int   = 0
func _on_score_timer_timeout() -> void: 
	play_time += 1
	$Score_Timer.start(score_clk_rate)


# Buffers to hold delayed commands in memory.
var delayed_commands           : Array = []
var repeating_delayed_commands : Array = []

var command_timer_timeouts : int = 0 # imitation static variable 
func _on_command_timer_timeout() -> void:
	
	if (command_timer_timeouts < delayed_commands.size()):
		$Interpreter.interpret_commands(delayed_commands[command_timer_timeouts][1])
	elif repeating_delayed_commands:
		$Interpreter.interpret_commands(repeating_delayed_commands[((command_timer_timeouts - delayed_commands.size()) % repeating_delayed_commands.size())][1]) 
	
	if (command_timer_timeouts < delayed_commands.size() - 1):
		$Command_Timer.start(delayed_commands[command_timer_timeouts + 1][0])
	elif repeating_delayed_commands:
		$Command_Timer.start(repeating_delayed_commands[((command_timer_timeouts - delayed_commands.size()) % repeating_delayed_commands.size())][0]) 
	
	command_timer_timeouts += 1 



const collision_noises = [preload("res://Assets/basketball.mp3"), preload("res://Assets/woodhit.mp3"), preload("res://Assets/keypress.mp3")]
func collision_noise() -> void:
	$AudioStreamPlayer2D.stream = collision_noises[randi_range(0,2)]
	$AudioStreamPlayer2D.play()


var lifespan : int = 0
func player_died() -> void: 
	lifespan = play_time
	if quit_on_death: to_main_menu()



# A list of all marbles on the board, updated when a marble is added or removed.
var game_ledger : Array = [[], [], [], [], [], [], [], [], [], []]

func marble_added(marble) -> void:
	marble.color_changed.connect(_marble_color_changed)
	game_ledger[marble.color].append(marble)
	review_score()

func marble_removed(marble) -> void: 
	marble.color_changed.disconnect(_marble_color_changed)
	game_ledger[marble.color].erase(marble)
	review_score()

func _marble_color_changed(marble) -> void:
	for color_ledger in game_ledger:
		if marble in color_ledger:
			color_ledger.erase(marble)
	game_ledger[marble.color].append(marble)


# Also defined in interpreter.gd
class scoring_condition: 
	var color      : int = 0     # What color does this pertain to?
	var comparator : String = "" # What condition are we using to judge the amount of them?
	var test_value : int = 0     # How many of them should we compare against?
	var min_max    : int = 0     # Is a lower or higher time better than the current?
	var best_time  : int = 0     # Stores the best time.
	var label      : String = "" # Stores the user's label to present the time in the menu.

var scoring_conditions : Array[scoring_condition] = []

# This function handles scoring within a level. While save_high_scores() handles the final result of all these calls.
func review_score() -> void:
	if (play_time <= 0): return # Prevents the long list of initial $place calls from bogging down.
	
	for condition in scoring_conditions: 
		match condition.comparator: # If the comparison fails, continue.
			"==": if !(game_ledger[condition.color].size() == condition.test_value): continue
			"!=": if !(game_ledger[condition.color].size() != condition.test_value): continue
			"<":  if !(game_ledger[condition.color].size() <  condition.test_value): continue
			">":  if !(game_ledger[condition.color].size() >  condition.test_value): continue
			"<=": if !(game_ledger[condition.color].size() <= condition.test_value): continue
			">=": if !(game_ledger[condition.color].size() >= condition.test_value): continue
			_: continue # If the comparator is not mentioned, continue.
		
		if condition.min_max: # The time should be maximized.
			if (condition.best_time < play_time): 
				condition.best_time = play_time # Update the high-score.
		else:                 # The time should be minimized. 
			if (condition.best_time == 0): # || condition.best_time > play_time)
				condition.best_time = play_time # Update the high-score.
		

# FileAccess.get_var() does not support user-defined classes. The below code uses arrays instead.
#class score:
#	var label : String = ""
#	var last_time : int = 0
#	var best_time : int = 0

func save_high_scores() -> void:
	
	review_score() 
	
	if (lifespan == 0): lifespan = play_time # If lifespan still equals 0, it has not been updated for a death.
	
	var scores : Array[Array] = Persist.generate_default_high_scores()
	
	scores[0][1] = play_time
	scores[0][2] = play_time
	scores[1][1] = lifespan
	scores[1][2] = lifespan
	
	scores.resize(scoring_conditions.size() + 2)
	
	for i in scoring_conditions.size():
		scores[i+2] = [scoring_conditions[i].label, scoring_conditions[i].best_time, 0]
	
	
	var high_scores : Array[Array] = Persist.load_high_scores(Board_Layouts.selection) 
	
	# If this level has a better play-time and lifespan, keep those.
	if (scores[0][2] < high_scores[0][2]): 
		scores[0][2] = high_scores[0][2]
	if (scores[1][2] < high_scores[1][2]): 
		scores[1][2] = high_scores[1][2]
	
	# Review the stored high scores using the conditions to see if they've been beaten.
	for condition in scoring_conditions:
		for high in high_scores:
			if (condition.label == high[0]): # , then check if that Label has already been beaten.
				if condition.min_max: # The time should be maximized.
					if (condition.best_time < high[2]): 
						condition.best_time = high[2]
				else:                 # The time should be minimized. 
					if ((condition.best_time > high[2] && (high[2] != 0)) || (condition.best_time == 0)): 
						condition.best_time = high[2]
	
	# Save only the time data from the condition object.
	for i in scoring_conditions.size(): 
		scores[i+2][2] = scoring_conditions[i].best_time
	
	Persist.save_high_scores(Board_Layouts.selection, scores)


func to_main_menu() -> void:
	if (play_time == 0): return
	$AnimationPlayer.play("fade_to_white")
	save_high_scores()
	get_tree().change_scene_to_file("res://Title_Screen.tscn")

func quit_game() -> void:
	save_high_scores()
	get_tree().quit()
