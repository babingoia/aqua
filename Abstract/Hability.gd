class_name Hability extends Node
## Classe abstrata hability, um comando que executa lógica \n
## do que o jogador pode fazer.

@export var event_bus: EventBus
var hability_name: String


func execute() -> void:
	assert(false, "execute() não implementado em " + get_script().resource_path)  # necessário pro type checker


func finish() -> void:
	assert(false, "finish() não implementado em " + get_script().resource_path)
