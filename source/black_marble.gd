class_name Black_Marble extends Marble
# The lines of code below, or a slightly less refined version were the other main topic of your first all-nighter.
# And you started the Grid_Tracker as the sun came up. It was early November / late October 2024.


var moving : bool = false

# This function doesn't exist in parent.
func _ready() -> void: $Timer.start(randf_range(2.0, 6.0)) # How long will it hold the first time?

# This function overwrites the version in parent.
func _integrate_forces(state) -> void: if moving: state.apply_force(direction * game_board.marble_speed[color])

# This function overwrites the version in parent. 
func decide_direction() -> Vector2: return Vector2(randf_range(-1.0, 1.0), randf_range(-1.0, 1.0)).normalized()


func _on_timer_timeout() -> void:
	if moving:
		moving = false
		$Timer.start(randf_range(2.0, 6.0)) # How long will it hold?
		set_linear_velocity(get_linear_velocity() * 0.25)
	else: # if(!moving)
		moving = true
		$Timer.start(randf_range(0.5, 1.5)) # How long will it move?
		direction = decide_direction()
