class_name Hability extends Node
## Classe abstrata hability, um comando que executa lógica \n
## do que o jogador pode fazer.

var hability_name: StringName
@export var cooldown_time: float

func execute() -> void:
	assert(false, "execute() não implementado em " + get_script().resource_path)  # necessário pro type checker


func finish() -> void:
	assert(false, "finish() não implementado em " + get_script().resource_path)
