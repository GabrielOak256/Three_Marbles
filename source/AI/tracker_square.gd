extends Area2D

# Holds a list of every marble in its space by their color.
var ledger : Array = [[], [], [], [], [], [], [], [], [], []] # Marble ledger[Settings.colors.size()][] = {}

func _on_body_entered(body: Node2D) -> void: 
	if ("color" in body): 
		ledger[body.color].append(body)
		body.color_changed.connect(_marble_color_changed)

func _on_body_exited(body: Node2D)  -> void: 
	if ("color" in body): 
		ledger[body.color].erase(body)
		body.color_changed.disconnect(_marble_color_changed)



func _marble_color_changed(marble) -> void: 
	for color_ledger in ledger:
		if marble in color_ledger:
			color_ledger.erase(marble)
	ledger[marble.color].append(marble)
