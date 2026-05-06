class_name HabilityWalk extends Hability

var input_direction_x: float
var input_direction_y: float


func _ready() -> void:
	state_name = ''
	anim_name = 'Walk'
	cost = 0
	cost_type = ''


func execute(character: Character, delta: float) -> HabilityResponse:
	var response: HabilityResponse = HabilityResponse.new()
	
	input_direction_x = Input.get_axis(Controls.LEFT, Controls.RIGHT)
	input_direction_y = Input.get_axis(Controls.UP, Controls.DOWN)
	
	if input_direction_x == 0 and input_direction_y == 0:
		response.status = Response.CANCELLED
		return response
		
	
	character.velocity.x = character.velocidade.velocidade * input_direction_x
	character.velocity.y = character.velocidade.velocidade * input_direction_y
	
	character.move_and_slide()
	
	response.status = Response.RUNNING
	return response


func finish(character: Character, delta: float) -> void:
	pass
