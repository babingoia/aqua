class_name IdleAction extends PlayerState





func update(_delta: float) -> void:
	if Input.is_action_just_pressed(Controls.SECOND_HABILITY_INPUT):
		finished.emit(second_hability)
	

func enter(previous_state_path: String, data := {}) -> void:
	print("Entering IdleAction...")
