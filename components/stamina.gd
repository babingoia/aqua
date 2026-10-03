## Componente puro que gerencia a stamina.
class_name Stamina extends Node

#Signals
signal out_of_stamina()

# Valores internos
@export var actual_stamina: float
@export var regen_rate: float
var max_stamina: float
var decrease_amount: float

# Triggers
var is_decreasing: bool = false


func _ready() -> void:
	max_stamina = actual_stamina


func _physics_process(delta: float) -> void:
	if decrease_over_time:
		print("Stamina Decreasing...")
		print(actual_stamina)
		actual_stamina -= decrease_amount * delta
	
	if actual_stamina <= 0:
			actual_stamina = 0
			is_decreasing = false
			out_of_stamina.emit()
			return
		
	if actual_stamina < max_stamina:
		actual_stamina += regen_rate * delta


func decrease_over_time(amount: float) -> void:
	is_decreasing = true
	decrease_amount = amount


func reset() -> void:
	is_decreasing = false
