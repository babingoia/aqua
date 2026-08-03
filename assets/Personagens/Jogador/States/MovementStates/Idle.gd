## State padrão de movimentação que trava a velocidade do personagem e gerencia as
## transições.
class_name Idle extends State

var velocity_request: VelocityRequestDTO = VelocityRequestDTO.new()


func _ready() -> void:
	state_name = 'Idle'


func physics_update(_delta: float) -> void:
	var input_vec := Input.get_vector(
		Controls.LEFT,
		Controls.RIGHT,
		Controls.UP,
		Controls.DOWN)
		
	if input_vec != Vector2.ZERO:
		finished.emit(PlayerState.WALKING)
	

func enter(_previous_state_path: String, _data := {}) -> void:
	event_bus.state_changed.emit(state_name, {})
	
	velocity_request.type = VelocityRequests.ZERO
	event_bus.velocity_change_request.emit(velocity_request, {})
	
