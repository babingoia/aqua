## Gerencia o movimento de um [target] por reação de requests lançadas no EventBus.
## aplicando [move_slide] de um [CharacterBody2D].
class_name Velocity extends Node

# Sinais
signal velocity_changed(value: Vector2, kwargs: Dictionary[Variant,Variant])
signal rotation_changed(value: float, kwargs: Dictionary)

# Variaveis
@export var target: CharacterBody2D
@export var base_velocity: float
var _rotation: float:
	set(new_value):
		if _rotation != new_value:
			_rotation = new_value
			rotation_changed.emit(_rotation)
var velocity_forces: Dictionary[String, Vector2]
var actual_velocity: Vector2:
	set(new_value):
		if actual_velocity != new_value:
			actual_velocity = new_value
			velocity_changed.emit(actual_velocity)
var movement_direction: Vector2


func _ready() -> void:
	actual_velocity = Vector2.ZERO


func _physics_process(delta: float) -> void:
	if _rotation != 0:
		target.rotation += _rotation * delta
	if movement_direction != Vector2.ZERO:
		target.velocity = actual_velocity * delta
		target.move_and_slide()


func _define_actual_velocity():
	actual_velocity = Vector2(base_velocity,base_velocity)
	for velocity_force in velocity_forces.values():
		actual_velocity *= velocity_force


func set_rotation(value: float) -> void:
	_rotation = value
	rotation_changed.emit(_rotation)


func set_direction(value: Vector2):
	movement_direction = value


func lock_velocity():
	actual_velocity = Vector2.ZERO
	movement_direction = Vector2.ZERO


func reset_velocity():
	movement_direction = Vector2.ZERO
	_define_actual_velocity()


func add_force(id: String, value: Vector2):
	velocity_forces[id] = value
	_define_actual_velocity()


func remove_force(id: String):
	velocity_forces.erase(id)
	_define_actual_velocity()
