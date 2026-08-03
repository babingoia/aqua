class_name Idle extends PlayerState


func _ready() -> void:
	state_name = 'Idle'


func physics_update(_delta: float) -> void:
	var input_vec := Input.get_vector(
		Controls.LEFT,
		Controls.RIGHT,
		Controls.UP,
		Controls.DOWN)
		
	if input_vec != Vector2.ZERO:
		finished.emit(WALKING)
	elif Input.is_action_pressed(Controls.FIRST_HABILITY_INPUT):
		finished.emit(FIRST_HABILITY)
	

func enter(_previous_state_path: String, _data := {}) -> void:
	print("Entrando em Idle")
	event_bus.state_changed.emit(state_name, {})
	event_bus.velocity_change_request.emit(VelocityRequests.ZERO, {})
	
