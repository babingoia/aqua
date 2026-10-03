## Classe responsável por gerenciar os slots de habilidade do player. Capta
## sinais genéricos do EventBus e os traduz em chamadas diretas de habilidades
## que estão registradas no HabilityManager
class_name HabilityManager extends Node

signal active_hability_changed(hability_name: StringName)

@export var relay: PlayerRelay
@export var movement_state_machine: StateMachine
@export var action_state_machine: StateMachine

@export var first_hability: Hability
@export var second_hability: Hability
@export var third_hability: Hability
var _null_hability: NullHability = NullHability.new()


# Triggers
var _active_hability: Hability:
	set(new_hability):
		if new_hability != _active_hability:
			if _active_hability != _movement_active_hability:
				_active_hability.finish()
			_active_hability = new_hability
			active_hability_changed.emit(_active_hability.name)

var _movement_active_hability: Hability:
	set(new_hability):
		if new_hability != _movement_active_hability:
			_movement_active_hability.finish()
			_movement_active_hability = new_hability


func _ready() -> void:
	_active_hability = _null_hability # Se ao contrário, a primeira execução dá erro.
	_movement_active_hability = _null_hability


func _physics_process(_delta: float) -> void:
	_active_hability.execute()
	_movement_active_hability.execute()


func _on_relay_action_state_changed(data: StateDTO) -> void:
	match data.state_name:
		PlayerState.FIRST_HABILITY:
			print("Trocando habilidade ativa para FirstHability...")
			_active_hability = first_hability
		PlayerState.SECOND_HABILITY:
			_active_hability = second_hability
		PlayerState.THIRD_HABILITY:
			_active_hability = third_hability
		_:
			_active_hability = _null_hability


func _on_relay_movement_state_changed(data: StateDTO) -> void:
	match data.state_name:
		first_hability.name:
			_movement_active_hability = first_hability 
		second_hability.name:
			_movement_active_hability = second_hability 
		third_hability.name:
			_movement_active_hability = third_hability
		_:
			_movement_active_hability = _null_hability
