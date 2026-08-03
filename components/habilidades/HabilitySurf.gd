class_name HabilitySurf extends Hability

@export var velocity_multiplier: float
@export var turn_speed: float
@export var target: CharacterBody2D
@export var cost: float
var velocity: Vector2
var is_axis_got: bool = false
var input_direction_x: float
var input_direction_y: float


func _ready() -> void:
	hability_name = "Surf"


func execute() -> void:
	
	#Movimentação
	if is_axis_got == false:
		input_direction_x = Input.get_axis(Controls.LEFT, Controls.RIGHT)
		input_direction_y = Input.get_axis(Controls.UP, Controls.DOWN)
		
		event_bus.velocity_change_request.emit(VelocityRequests.RESET, {})
		
		var stamina_request = StaminaRequestDTO.new()
		stamina_request.request = StaminaRequests.DECREASE_OVER_TIME
		stamina_request.amount = cost
		event_bus.stamina_change_request.emit(stamina_request, {})
		
		is_axis_got = true
	
	elif input_direction_x == 0 and input_direction_y == 0:
		event_bus.hability_status.emit(Response.FAILED, {})
		
		var request = StaminaRequestDTO.new()
		request.request = StaminaRequests.RESET
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
	
	var input_vector: Vector2 = Input.get_vector(
		Controls.LEFT,
		Controls.RIGHT,
		Controls.UP,
		Controls.DOWN
	)
	
	target.velocity = velocity * velocity_multiplier * input_vector
	
	target.move_and_slide()


func finish() -> void:
	is_axis_got = false
	input_direction_x = 0
	input_direction_y = 0
	
	var stamina_request = StaminaRequestDTO.new()
	stamina_request.request = StaminaRequests.RESET
	event_bus.stamina_change_request.emit(stamina_request, {})


func _on_event_bus_velocity_changed(value: Vector2, _kwargs: Dictionary) -> void:
	velocity = value
