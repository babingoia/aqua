class_name HabilitySurf extends Hability

@export var velocity_multiplier: float
@export var turn_speed: float
var is_axis_got: bool = false
var input_direction_x: float
var input_direction_y: float


func _ready() -> void:
	state_name = "Surf"
	anim_name = "Surf"
	cost_type = "stamina"


func cancel_check(character: Character) -> String:

	if character.stamina.actual_stamina < cost:		
		return Response.FAILED
	
	if Input.is_action_just_released(Controls.FIRST_HABILITY_INPUT):
		return Response.CANCELLED
	
	return ''


func execute(character: Character, delta:float) -> HabilityResponse:
	
	var response: HabilityResponse = HabilityResponse.new()
	
	#Checando se a habilidade pode ser rodada
	response.status = cancel_check(character)
	if response.status != '':
		return response

	
	#Movimentação
	if is_axis_got == false:
		input_direction_x = Input.get_axis(Controls.LEFT, Controls.RIGHT)
		input_direction_y = Input.get_axis(Controls.UP, Controls.DOWN)
		is_axis_got = true
	
	elif input_direction_x == 0 and input_direction_y == 0:
		response.status = Response.FAILED
		return response
	
	else:
		
		if Input.is_action_pressed(Controls.UP) and input_direction_x != 0:
			input_direction_y -= turn_speed
		if Input.is_action_pressed(Controls.DOWN) and input_direction_x != 0:
			input_direction_y += turn_speed
		if Input.is_action_pressed(Controls.RIGHT) and input_direction_y != 0:
			input_direction_x += turn_speed
		if Input.is_action_pressed(Controls.LEFT) and input_direction_y != 0:
			input_direction_x -= turn_speed
	
	
	character.velocity.x = character.velocidade.velocidade * input_direction_x * velocity_multiplier
	character.velocity.y = character.velocidade.velocidade * input_direction_y * velocity_multiplier
	
	
	character.stamina.decreasse_over_time(cost, delta)
	character.move_and_slide()
	
	response.status = Response.RUNNING
	return response


func finish(character: Character, delta: float) -> void:
	is_axis_got = false
	input_direction_x = 0
	input_direction_y = 0
	
