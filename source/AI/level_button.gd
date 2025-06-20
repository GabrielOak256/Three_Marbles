extends Area2D

const const_labels = [
["Start Here", "Git!", "???", "Swiftly Begin"], 
["Go Around", "A Man\nMade Of\nCheese", "???", "Tidal\nSatellite\nof Craters"], 
["We Have\nSeen\nThe Enemy", "Barbeque\nWeather", "???", "Going\nOutward It\nAchieves Full\nStrength!"], 
["Order\nand\nChaos", "Order\nand\nChaos", "???", "Order\nand\nChaos"], 
["Red Eye", "Jupiter\nTea Party", "???", "Jupiter's\nEyes Are Red"], 
["The\nHerd, Pack,\nScavengers", "Breakfast\nDinner\nSupper", "???", "How Might\nDogwood Tree\nDifferentiated?"], 
["Self\nAssembling\nCathedral", "The Nautilus\ncontent risk:\nFrench", "???", "Don't Be\nShell Fish"], 
["And Around", "So\nMany Worlds\nNot One\nConquered", "???", "If Left Had\nBeen Done At\nAlbuquerque"], 
["Platonic\nSolids", "Meetaechren's", "???", "All\nSides Are\nBeing\nEqual"], 
["Ghost\nIn The\nMachine", "And A\nBigger Ship!", "???", "Spin\nThe Wheel\nWithout\nBrutality"], 
["Tempest", "After\nGaining\nIndependence", "???", "Slide\nAmong\n Impetus of\nCollision"], 
["Abandon\nHope", "Believed\nIn Firmly As\nAustralia", "???", "Eating\nCarpet Strictly\nProhibited"]
]

var custom_label_data : Array

const right_click = [
"Right Click",
"Right Click",
"???",
"Depress\nFirmly The\nNorth-East\nControl"
]

const const_colors = [
[1, 1, 1], # Tutorial
[0, 0, 0], # Moon
[0.75, 0.75, 1], # Whirlpool
[1, 1, 0.5], # Yin Yang
[1, 0, 0], # Red Eye
[0.75, 1, 0.75], # Creatures
[1, 1, 0.75], # Shell
[1, 1, 1], # Galaxy
[0, 0, 0], # Metatron
[0.75, 0.25, 0], # Engine
[1, 1, 1], # Nebula
[1, 1, 1]  # Pandemonium
]



var switch : bool = false
var index : int = 0 
var lang : int = 0

var title_screen
func _ready() -> void: 
	title_screen = get_parent()
	
	lang = Persist.load_lang()
	custom_label_data = Persist.load_label()


# This is a seperate function for lack of constructor arguments in GDScript.
func review_color() -> void: 
	if (index == const_labels.size()): $Label.self_modulate = Color(custom_label_data[0], custom_label_data[1], custom_label_data[2])
	else: $Label.self_modulate = Color(const_colors[index][0], const_colors[index][1], const_colors[index][2])

func _on_mouse_entered() -> void: switch = true; update_label()
func _on_mouse_exited() -> void: switch = false; update_label()

func review_lang() -> void: lang = Persist.load_lang(); update_label()

func update_label() -> void: 
	if switch:
		if   (index == 0):                   $Label.text = right_click[lang]
		elif (index == const_labels.size()): $Label.text = custom_label_data[3]
		else:                                $Label.text = const_labels[index][lang]
	else: 
		if   (index == 0):                   $Label.text = const_labels[index][lang]
		else:                                $Label.text = ""

func _on_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_pressed("left_click"): title_screen.button_left_clicked(index)
	if Input.is_action_pressed("right_click"): title_screen.button_right_clicked(index)
