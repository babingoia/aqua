class_name Walking extends State


func _ready() -> void:
	state_name = "Walking"


func physics_update(_delta: float) -> void:
	var input_vec := Input.get_vector(
		Controls.LEFT,
		Controls.RIGHT,
		Controls.UP,
		Controls.DOWN)
		
	if input_vec == Vector2.ZERO:
		finished.emit(PlayerState.IDLE)


func enter(_previous_state_path: String, _data := {}) -> void:
	event_bus.state_changed.emit(state_name, {})
	
