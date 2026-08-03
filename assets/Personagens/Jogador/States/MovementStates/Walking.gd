class_name Walking extends PlayerState


func _ready() -> void:
	state_name = "Walking"


func physics_update(_delta: float) -> void:
	var input_vec := Input.get_vector(
		Controls.LEFT,
		Controls.RIGHT,
		Controls.UP,
		Controls.DOWN)
		
	if input_vec == Vector2.ZERO:
		finished.emit(IDLE)
	if Input.is_action_just_pressed(Controls.FIRST_HABILITY_INPUT):
		finished.emit(FIRST_HABILITY)


func enter(_previous_state_path: String, _data := {}) -> void:
	print("Entrando em Walking")
	event_bus.state_changed.emit(state_name, {})
	
