class_name Walk extends Node


var velocity: Vector2
var walking_loop: bool = false
@export var event_bus: EventBus
@export var target: CharacterBody2D


func _physics_process(_delta: float) -> void:
	if not walking_loop:
		return
	
	var input_direction := Input.get_vector(
		Controls.LEFT, 
		Controls.RIGHT, 
		Controls.UP, 
		Controls.DOWN
	)

	if input_direction == Vector2.ZERO:
		target.velocity = Vector2.ZERO
		return
		
	target.velocity = velocity * input_direction
	
	target.move_and_slide()


func _on_event_bus_velocity_changed(value: Vector2, _kwargs: Dictionary) -> void:
	velocity = value


func _on_event_bus_state_changed(state_name: String, _kwargs: Dictionary) -> void:
	if state_name == "Walking":
		walking_loop = true
		event_bus.velocity_change_request.emit(VelocityRequests.RESET, {})
	else:
		walking_loop = false
