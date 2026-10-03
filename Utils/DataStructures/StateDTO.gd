class_name StateDTO extends Node

var state: State
var state_name: StringName

func _init(value_state = State) -> void:
	state = value_state
	state_name  = state.name
