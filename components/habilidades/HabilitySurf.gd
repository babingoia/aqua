## Habilidade que trava o movimento em uma direção e adiciona curva suave com
## aceleração tangente e centrípeta simulando um MCUV. Os inputs são dinânimos,
## fazendo com que a curva aconteça dependente da direção do movimento.
class_name HabilitySurf extends Hability

@export var velocity_multiplier: float
@export var turn_speed: float
@export var target: CharacterBody2D
@export var cost: float
@export var cooldown: float = 2
var velocity_request: VelocityRequestDTO = VelocityRequestDTO.new()
var cooldown_timer: Timer = Timer.new()
var velocity: Vector2
var is_axis_got: bool = false
var input_direction_x: float
var input_direction_y: float


func _ready() -> void:
	hability_name = HabilityNames.SURF
	
	add_child(cooldown_timer)
	cooldown_timer.wait_time = cooldown
	cooldown_timer.one_shot = true


func execute() -> void:
	if not cooldown_timer.is_stopped():
		return

	#Movimentação
	if is_axis_got == false:
		print("Iniciando axis_got...")
		input_direction_x = Input.get_axis(Controls.LEFT, Controls.RIGHT)
		input_direction_y = Input.get_axis(Controls.UP, Controls.DOWN)
		
		velocity_request.type = VelocityRequests.RESET
		event_bus.velocity_change_request.emit(velocity_request, {})
		event_bus.walk_lock_request.emit({})
		
		var stamina_request = StaminaRequestDTO.new()
		stamina_request.type = StaminaRequests.DECREASE_OVER_TIME
		stamina_request.amount = cost
		event_bus.stamina_change_request.emit(stamina_request, {})
		
		is_axis_got = true
	
	elif input_direction_x == 0 and input_direction_y == 0:
		print("Habilidade Falhou...")
		event_bus.hability_status.emit(Response.FAILED, {})
		
		var request = StaminaRequestDTO.new()
		request.type = StaminaRequests.RESET
		event_bus.stamina_change_request.emit(request, {})
		
		return
	
	else:
		
		if Input.is_action_pressed(Controls.UP) and input_direction_x != 0:
			input_direction_y -= turn_speed
		if Input.is_action_pressed(Controls.DOWN) and input_direction_x != 0:
			input_direction_y += turn_speed
		if Input.is_action_pressed(Controls.RIGHT) and input_direction_y != 0:
			input_direction_x += turn_speed
		if Input.is_action_pressed(Controls.LEFT) and input_direction_y != 0:
			input_direction_x -= turn_speed
	
	target.velocity.x = velocity.x + velocity_multiplier * input_direction_x
	target.velocity.y = velocity.y + velocity_multiplier * input_direction_y
	
	target.move_and_slide()


func finish() -> void:
	is_axis_got = false
	input_direction_x = 0
	input_direction_y = 0
	
	var stamina_request = StaminaRequestDTO.new()
	stamina_request.type = StaminaRequests.RESET
	event_bus.stamina_change_request.emit(stamina_request, {})
	
	event_bus.walk_unlock_request.emit({})
	cooldown_timer.start(cooldown)


func _on_event_bus_velocity_changed(value: Vector2, _kwargs: Dictionary) -> void:
	velocity = value
