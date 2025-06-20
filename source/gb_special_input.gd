extends Node

var game_board
func _ready() -> void: game_board = get_parent()

func _process(_delta: float) -> void: 
	
	if Input.is_action_just_pressed("pause"): get_tree().paused = !get_tree().paused
	
	if Input.is_action_just_pressed("quit"): 
		get_tree().paused = false
		game_board.to_main_menu()
	
	if Input.is_action_just_pressed("quit_game"): game_board.quit_game()
	
