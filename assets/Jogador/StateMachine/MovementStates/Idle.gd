class_name Idle extends PlayerState

	
func physics_update(_delta: float) -> void:
	
	if Input.is_action_pressed(Controls.UP) or Input.is_action_pressed(Controls.DOWN) or Input.is_action_pressed(Controls.RIGHT) or Input.is_action_pressed(Controls.LEFT):
		finished.emit(WALKING)
	elif Input.is_action_pressed(Controls.FIRST_HABILITY_INPUT):
		finished.emit(first_hability)
	

func enter(previous_state_path: String, data := {}) -> void:
	character.velocity.x = 0.0
	character.animation_player.play('idle')
	
