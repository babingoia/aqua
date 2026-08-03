## State de ação padrão de uma ação, sem nada em execução.
class_name IdleAction extends State

func _ready() -> void:
	state_name = PlayerState.IDLE_ACTION

func update(_delta: float) -> void:
	if Input.is_action_just_pressed(Controls.FIRST_HABILITY_INPUT):
		finished.emit(PlayerState.FIRST_HABILITY)
		
	if Input.is_action_just_pressed(Controls.SECOND_HABILITY_INPUT):
		finished.emit(PlayerState.SECOND_HABILITY)
	

func enter(previous_state_path: String, data := {}) -> void:
	print("Entrando em IdleAction...")
	event_bus.action_state_changed.emit(state_name, {})
