## Estado da ação de surf. Entra em Idle se a stamina acabar ou
## se o jogador soltar o botão de ação
class_name Surf extends State

func _ready() -> void:
	state_name = PlayerState.FIRST_HABILITY


func physics_update(_delta: float) -> void:	
	if Input.is_action_just_released(Controls.FIRST_HABILITY_INPUT):
		finished.emit(PlayerState.IDLE)


func _on_relay_out_of_stamina() -> void:
	finished.emit(PlayerState.IDLE)


func enter(_previous_state_path: String, _data := {}) -> void:
	print("Entrando em surf...")


func exit() -> void:
	print("Saindo do surf...")
