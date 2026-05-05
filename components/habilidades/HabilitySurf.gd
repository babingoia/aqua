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
	

func execute(caster: Character, delta:float) -> void:
	
	if is_axis_got == false:
		input_direction_x = Input.get_axis(Controls.LEFT, Controls.RIGHT)
		input_direction_y = Input.get_axis(Controls.UP, Controls.DOWN)
		is_axis_got = true
	
	else:
		
		if Input.is_action_pressed(Controls.UP) and input_direction_x != 0:
			input_direction_y -= turn_speed
		if Input.is_action_pressed(Controls.DOWN) and input_direction_x != 0:
			input_direction_y += turn_speed
		if Input.is_action_pressed(Controls.RIGHT) and input_direction_y != 0:
			input_direction_x += turn_speed
		if Input.is_action_pressed(Controls.LEFT) and input_direction_y != 0:
			input_direction_x -= turn_speed
	
	
	print("x:" + str(input_direction_x))
	print("y:" + str(input_direction_y))
	caster.velocity.x = caster.velocidade.velocidade * input_direction_x * velocity_multiplier
	caster.velocity.y = caster.velocidade.velocidade * input_direction_y * velocity_multiplier
	
	
	caster.stamina.decreasse_over_time(cost, delta)
	caster.move_and_slide()


func finish(caster: Character, delta: float) -> void:
	is_axis_got = false
	input_direction_x = 0
	input_direction_y = 0
	
