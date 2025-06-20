extends Control

enum LANG {en_US, en_UK, zh_CN, POOR_TRANSLATION} 


var buttons : Array 
func _ready() -> void: 
	buttons = [
	$Tutorial_Button, $Moon_Button, $Whirlpool_Button, $YinYang_Button,
	$RedEye_Button, $Creatures_Button, $Shell_Button, $Galaxy_Button, 
	$Metatron_Button, $Engine_Button, $Nebula_Button, $Pandemonium_Button,
	$Custom_Button]
	
	for i in buttons.size(): 
		buttons[i].index = i
		buttons[i].update_label()
		buttons[i].review_color()
	
	$AnimationPlayer.play("fade_from_white")


func _process(_delta: float) -> void: 
	if Input.is_action_just_pressed("select_1"): 
		var lang : int = Persist.load_lang()
		if (lang != LANG.zh_CN && lang != LANG.POOR_TRANSLATION): 
			Persist.save_lang(LANG.en_US)
			buttons_review_lang()
		else:                                                     
			Persist.save_lang(LANG.POOR_TRANSLATION)
			buttons_review_lang()
	if Input.is_action_just_pressed("select_2"): 
		Persist.save_lang(LANG.en_UK)
		buttons_review_lang()
	if Input.is_action_just_pressed("select_3"): 
		Persist.save_lang(LANG.zh_CN)
		buttons_review_lang()
	
	if Input.is_action_just_pressed("hard_reset"): 
		Persist.reset()
		buttons[buttons.size() - 1].custom_label_data = Persist.load_label()
		buttons_review_lang()
	
	if Input.is_action_just_pressed("quit_game"): get_tree().quit()
	

func buttons_review_lang() -> void: for button in buttons: button.review_lang()


func button_left_clicked(level : int) -> void:
	$AnimationPlayer.play("fade_to_white")
	Board_Layouts.selection = level
	get_tree().change_scene_to_file("res://Game_Board.tscn")

func button_right_clicked(level : int) -> void:
	$AnimationPlayer.play("fade_to_white")
	Board_Layouts.selection = level
	get_tree().change_scene_to_file("res://Settings_Menu.tscn")
