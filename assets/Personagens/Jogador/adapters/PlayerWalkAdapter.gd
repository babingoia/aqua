class_name PlayerWalkAdapter extends Walk

var _velocity_request: VelocityRequestDTO = VelocityRequestDTO.new()
@export var relay: PlayerRelay

## Ponto de entrada do que acontece com status.
func _on_status(status: StringName, _kwargs: Dictionary) -> void:
	match status:
		Response.FAILED:
			_failed_movement()
		Response.RUNNING:
			_movement_running()
		_:
			printerr("Status de Walk não suportado!")
			return
	
	self.relay.modify_velocity.emit(self._velocity_request)


func _failed_movement() -> void:
	_velocity_request.type = VelocityRequests.RESET


func _movement_running() -> void:
	_velocity_request.type = VelocityRequests.DIRECTION
	_velocity_request.amount = self._input_direction


## Precisa estar no método concreto, não aqui na componente pura.
func _on_event_bus_state_changed(state_name: String, _kwargs: Dictionary) -> void:
	if state_name == PlayerState.WALKING:
		print("Walking initiated...")
		walking_loop = true
		self.stoped_walking.emit({})
	else:
		walking_loop = false
