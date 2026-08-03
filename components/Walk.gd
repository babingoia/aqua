class_name Walk extends Node

var input_direction: Vector2
var velocity: Vector2
var walking_loop: bool = false
var velocity_request = VelocityRequestDTO.new()
@export var event_bus: EventBus


func _physics_process(_delta: float) -> void:
	if not walking_loop:
		return
	
	input_direction = Input.get_vector(
		Controls.LEFT, 
		Controls.RIGHT, 
		Controls.UP, 
		Controls.DOWN
	)

	if input_direction == Vector2.ZERO:
		velocity_request.type = VelocityRequests.ZERO
		event_bus.velocity_change_request.emit(velocity_request, {})
		return
	
	velocity_request.type = VelocityRequests.DIRECTION
	velocity_request.amount = input_direction
	
	event_bus.velocity_change_request.emit(velocity_request, {})	


func _on_event_bus_velocity_changed(value: Vector2, _kwargs: Dictionary) -> void:
	velocity = value


func _on_event_bus_state_changed(state_name: String, _kwargs: Dictionary) -> void:
	if state_name == PlayerState.WALKING:
		print("Walking initiated...")
		walking_loop = true
		
		velocity_request.type = VelocityRequests.RESET
		
		event_bus.velocity_change_request.emit(velocity_request, {})
	else:
		walking_loop = false


func _on_event_bus_walk_lock_request(_kwargs: Dictionary) -> void:
	print("Locking Walk")
	walking_loop = false


func _on_event_bus_walk_unlock_request(_kwargs: Dictionary) -> void:
	walking_loop = true
	
	velocity_request.type = VelocityRequests.RESET
	event_bus.velocity_change_request.emit(velocity_request, {})
