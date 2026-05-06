class_name Hability extends Node

#Info
var state_name: String
var anim_name: String
@export var cost: float
var cost_type: String



func execute(character: Character, delta: float) -> HabilityResponse:
	assert(false, "execute() não implementado em " + get_script().resource_path)
	return HabilityResponse.new()  # necessário pro type checker


func finish(character: Character, delta: float) -> void:
	assert(false, "finish() não implementado em " + get_script().resource_path)
