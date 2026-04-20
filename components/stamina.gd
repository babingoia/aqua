class_name Stamina extends Node


@export var actual_stamina: float
@export var regen_rate: float
var max_stamina: int


func _ready() -> void:
	max_stamina = actual_stamina


func debug(rate: float) -> void:
	print("Stamina:" + str(actual_stamina) + "/" + str(max_stamina))
	print("Stamina mudando..." + str(rate))


func decreasse_over_time(decrese_value: int, delta: float) -> void:
	actual_stamina -= decrese_value * delta


func stamin_regen(delta: float) -> void:
	actual_stamina += regen_rate * delta


func _physics_process(delta: float) -> void:
	if actual_stamina < max_stamina:
		stamin_regen(delta)
		
