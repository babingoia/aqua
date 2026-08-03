class_name ConchaIdle extends ConchaStates

func _ready() -> void:
	state_name = "Idle"

func enter(previous_state_path: String, data := {}) -> void:
	event_bus.state_changed.emit(state_name)
