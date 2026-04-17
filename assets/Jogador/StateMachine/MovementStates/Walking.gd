class_name Walking extends PlayerState

	
func physics_update(_delta: float) -> void:
	var input_direction_x := Input.get_axis(Controls.LEFT, Controls.RIGHT)
	var input_direction_y := Input.get_axis(Controls.UP, Controls.DOWN)
	
	character.velocity.x = character.velocidade.velocidade * input_direction_x
	character.velocity.y = character.velocidade.velocidade * input_direction_y
	
	character.move_and_slide()
	
	if is_equal_approx(input_direction_x, 0.0) and is_equal_approx(input_direction_y, 0.0):
		finished.emit(IDLE)	
	elif Input.is_action_just_pressed(Controls.FIRST_HABILITY_INPUT):
		finished.emit(first_hability)


func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path)
	character.animation_player.play("walking")
	
