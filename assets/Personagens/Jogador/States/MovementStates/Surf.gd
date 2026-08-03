class_name Surf extends PlayerState

	
func physics_update(_delta: float) -> void:	
	if Input.is_action_just_released(Controls.FIRST_HABILITY_INPUT):
		finished.emit(IDLE)


func enter(_previous_state_path: String, _data := {}) -> void:
	event_bus.state_changed.emit(state_name, {})
