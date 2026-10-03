## Adaptador de habilidade Surf do player. Implementa cooldown e custo de stamina
## além de criar signals para expor requests de velocidade e stamina para fora. 
class_name PlayerSurfAdapter extends HabilitySurf

@export var cost: float = 0.5
var timer: Timer = Timer.new()

#Adicionar cooldown.

signal modify_velocity(request: VelocityRequestDTO, kwargs: Dictionary[Variant,Variant])
signal modify_stamina(request: StaminaRequestDTO, kwargs: Dictionary[Variant,Variant])


func _ready() -> void:
	super._ready()
	
	hability_name = PlayerState.SURF
	
	super.connect("velocity_changed", _on_velocity_changed)
	super.connect("status", _on_status)
	super.connect("rotation_changed", _on_rotation_changed)
	
	timer.one_shot = true


func _get_direction() -> void:
	if !timer.is_stopped():
		return
		
	super._get_direction()
	
	if _is_direction_got:
		var stamina_request := StaminaRequestDTO.new()
		stamina_request.type = StaminaRequests.DECREASE_OVER_TIME
		stamina_request.amount = cost
		modify_stamina.emit(stamina_request, {})


func finish() -> void:
	super.finish()
	var stamina_request := StaminaRequestDTO.new()
	stamina_request.type = StaminaRequests.RESET
	modify_stamina.emit(stamina_request, {})


func _on_velocity_changed(value: Vector2, kwargs: Dictionary) -> void:
	var velocity_request := VelocityRequestDTO.new()
	velocity_request.type = VelocityRequests.ADD_FORCE
	velocity_request.amount = value
	modify_velocity.emit(velocity_request, kwargs)


func _on_status(response: String, _kwargs: Dictionary) -> void:
	match response:
		Response.RUNNING:
			return
		_:
			timer.start()


func _on_rotation_changed(value: float, kwargs: Dictionary) -> void:
	var velocity_request := VelocityRequestDTO.new()
	velocity_request.type = VelocityRequests.ROTATION
	velocity_request.amount = Vector2(value, value)
	modify_velocity.emit(velocity_request, kwargs)
