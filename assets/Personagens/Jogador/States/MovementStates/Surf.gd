## Estado da ação de surf.
class_name Surf extends State

func _ready() -> void:
	state_name = PlayerState.FIRST_HABILITY


func physics_update(_delta: float) -> void:	
	if Input.is_action_just_released(Controls.FIRST_HABILITY_INPUT):
		finished.emit(PlayerState.IDLE_ACTION)


func enter(_previous_state_path: String, _data := {}) -> void:
	print("Entrando em surf...")
	event_bus.action_state_changed.emit(state_name, {})


func _on_event_bus_out_of_stamina(response: String, _kwargs: Dictionary) -> void:
	finished.emit(PlayerState.IDLE_ACTION)
