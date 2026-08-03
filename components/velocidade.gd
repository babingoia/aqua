## Gerencia a velocidade de um [target] por reação de requests lançadas no EventBus.
## aplicando [move_slide] de um [CharacterBody2D].
class_name Velocidade extends Node

@export var target: CharacterBody2D
@export var base_velocity: float
var actual_velocity: Vector2
var movement_direction: Vector2
@export var event_bus: EventBus


func _ready() -> void:
	actual_velocity = Vector2.ZERO


func _physics_process(_delta: float) -> void:
	if movement_direction != Vector2.ZERO:
		target.velocity = actual_velocity * movement_direction
		target.move_and_slide()


func _on_event_bus_velocity_change_request(request: VelocityRequestDTO, _kwargs: Dictionary) -> void:
	match request.type:
		VelocityRequests.ZERO:
			print("Velocity going zero...")
			actual_velocity = Vector2.ZERO
			movement_direction = Vector2.ZERO
		VelocityRequests.RESET:
			print("Velocity reseting...")
			actual_velocity = Vector2(base_velocity,base_velocity)
			movement_direction = Vector2.ZERO
		VelocityRequests.DIRECTION:
			movement_direction = request.amount 
		_:
			push_warning("Requisição de velocidade desconhecida.")
			
	event_bus.velocity_changed.emit(actual_velocity, {})
