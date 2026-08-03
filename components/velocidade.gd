class_name Velocidade extends Node

@export var base_velocity: float
var actual_velocity: Vector2
@export var event_bus: EventBus


func _ready() -> void:
	actual_velocity = Vector2(base_velocity,base_velocity)


func _on_event_bus_velocity_change_request(request: StringName, _kwargs: Dictionary) -> void:
	print("Velocity request got...")
	match request:
		VelocityRequests.ZERO:
			print("Velocity going zero...")
			actual_velocity = Vector2.ZERO
		VelocityRequests.RESET:
			print("Velocity reseting...")
			actual_velocity = Vector2(base_velocity,base_velocity)
		_:
			push_warning("Requisição de velocidade desconhecida.")
			
	event_bus.velocity_changed.emit(actual_velocity, {})
