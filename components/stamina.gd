## Componente que gerencia a stamina.
class_name Stamina extends Node

# Valores internos
@export var event_bus: EventBus
@export var actual_stamina: float

var max_stamina: float

var decrease_amount: float
@export var regen_rate: float

# Triggers
var decrease_over_time: bool = false


func _ready() -> void:
	max_stamina = actual_stamina


func _physics_process(delta: float) -> void:
	if decrease_over_time:
		actual_stamina -= decrease_amount * delta
		if actual_stamina <= 0:
			actual_stamina = 0
			decrease_over_time = false
			event_bus.out_of_stamina.emit(Response.FAILED)
			return
		
	if actual_stamina < max_stamina:
		actual_stamina += regen_rate * delta


func _on_event_bus_stamina_change_request(request: StaminaRequestDTO, _kwargs: Dictionary) -> void:
	match request.request:
		StaminaRequests.DECREASE_OVER_TIME:
			decrease_over_time = true
			decrease_amount = request.amount
		StaminaRequests.RESET:
			decrease_over_time = false
		_:
			push_warning("Requisição para Stamina não identificada")
