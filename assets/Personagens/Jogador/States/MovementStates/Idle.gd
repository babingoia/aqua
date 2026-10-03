## State padrão de movimentação que trava a velocidade do personagem e gerencia as
## transições.
class_name Idle extends State

func _ready() -> void:
	state_name = PlayerState.IDLE


func physics_update(_delta: float) -> void:
	var input_vec := Input.get_vector(
		Controls.LEFT,
		Controls.RIGHT,
		Controls.UP,
		Controls.DOWN)
		
	if input_vec != Vector2.ZERO:
		finished.emit(PlayerState.WALKING)


func _on_relay_active_hability_changed(hability_name: StringName) -> void:
		if hability_name == PlayerState.SURF:
			finished.emit(PlayerState.SURF)
