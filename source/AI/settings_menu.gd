extends CanvasLayer

const seperator : String = "--------------------------------------------------------------------------------\n"

func _ready() -> void:
	var text : String = ""
	
	var high_scores : Array[Array] = Persist.load_high_scores(Board_Layouts.selection)
	
	for high_score in high_scores: 
		
		# Display both the time the player just made, and the best logged.
		var last_time : String 
		if high_score[1]: last_time = "%d:%02d:%d" % [(high_score[1] / 10) / 60, (high_score[1] / 10) % 60, high_score[1] % 10] 
		else:             last_time = "_:__:_"
		var best_time : String 
		if high_score[2]: best_time = "%d:%02d:%d" % [(high_score[2] / 10) / 60, (high_score[2] / 10) % 60, high_score[2] % 10] 
		else:             best_time = "_:__:_"
		text += (high_score[0] + last_time + "|" + best_time + "\n")
	
	text += seperator
	
	text += Board_Layouts.menu_text[Board_Layouts.selection][Persist.load_lang()]
	
	if (Board_Layouts.selection == Board_Layouts.board_layouts.size()): text += Persist.load_custom()
	else: text += Board_Layouts.board_layouts[Board_Layouts.selection]
	
	$TextEdit.set_text(text)
	
	if (Board_Layouts.selection == Board_Layouts.board_layouts.size()): $TextEdit.set_editable(true)
	
	$AnimationPlayer.play("fade_from_white")

func _process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("quit"): 
		$AnimationPlayer.play("fade_to_white")
		$TextEdit.backspace() # q leaves an "q" behind
		$TextEdit.set_editable(false)
		get_tree().change_scene_to_file("res://Title_Screen.tscn")
	
	if Input.is_action_pressed("save_input"):
		$AnimationPlayer.play("fade_to_white")
		$TextEdit.backspace() # Ctl-S leaves an "s" behind
		$TextEdit.set_editable(false)
		if (Board_Layouts.selection == Board_Layouts.board_layouts.size()):
			if ($TextEdit.get_text().find(seperator) == -1): Persist.save_custom($TextEdit.get_text())
			else: Persist.save_custom($TextEdit.get_text().right($TextEdit.get_text().length() - $TextEdit.get_text().find(seperator) - seperator.length()))
		get_tree().change_scene_to_file("res://Game_Board.tscn")
	
	if Input.is_action_just_pressed("quit_game"): 
		if (Board_Layouts.selection == Board_Layouts.board_layouts.size()): Persist.save_custom($TextEdit.get_text().right($TextEdit.get_text().length() - $TextEdit.get_text().find(seperator) - seperator.length()))
		get_tree().quit()
	
