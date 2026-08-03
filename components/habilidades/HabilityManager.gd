## Classe responsável por gerenciar os slots de habilidade do player. Capta
## sinais genéricos do EventBus e os traduz em chamadas diretas de habilidades
## que estão registradas no HabilityManager
class_name HabilityManager extends Node

@export var event_bus: EventBus
@export var movement_state_machine: StateMachine
@export var action_state_machine: StateMachine

@export var first_hability: Hability
@export var second_hability: Hability
@export var third_hability: Hability
var _null_hability: NullHability



# Triggers
var _active_hability: Hability = NullHability.new():
	set(new_hability):
		if new_hability != _active_hability:
			_active_hability.finish()
			_active_hability = new_hability
			
			if _active_hability != _null_hability:
				set_physics_process(true)


func _ready() -> void:
	_null_hability = _active_hability # Se ao contrário, a primeira execução dá erro.
	set_physics_process(false)


func _physics_process(_delta: float) -> void:
	_active_hability.execute()


func _on_event_bus_action_state_changed(state_name: String, _kwargs: Dictionary) -> void:
	match state_name:
		PlayerState.FIRST_HABILITY:
			print("Trocando habilidade ativa para FirstHability...")
			_active_hability = first_hability
		PlayerState.SECOND_HABILITY:
			_active_hability = second_hability
		PlayerState.THIRD_HABILITY:
			_active_hability = third_hability
		_:
			_active_hability = _null_hability


func _on_event_bus_out_of_stamina(response: String, kwargs: Dictionary) -> void:
	print("Canceling hability...")
	_active_hability = _null_hability
