class_name HabilitySurf extends Hability

@export var velocity_multiplier: float
var is_axis_got: bool = false
var input_direction_x: float
var input_direction_y: float


func _ready() -> void:
	state_name = "Surf"
	cost_type = "stamina"
	

func execute(caster: Character, delta:float) -> void:
	if is_axis_got == false:
		input_direction_x = Input.get_axis(Controls.LEFT, Controls.RIGHT)
		input_direction_y = Input.get_axis(Controls.UP, Controls.DOWN)
		is_axis_got = true
	
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
	
