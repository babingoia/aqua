class_name HabilityAttack extends Hability



func _ready() -> void:
	state_name = "Attack"
	anim_name = "Attack"


func execute(character: Character, delta: float) -> HabilityResponse:
	var response: HabilityResponse = HabilityResponse.new()
	response.status = Response.COMPLETED
	return response 


func finish(character: Character, delta: float) -> void:
	pass
