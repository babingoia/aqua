class_name Walking extends PlayerState

	
func physics_update(_delta: float) -> void:

	var response: HabilityResponse = hability.execute(character, _delta)
	
	match response.status:
		Response.CANCELLED:
			finished.emit(IDLE)
		Response.RUNNING:
			pass
		_:
			assert(false, "Resposta não identificada")	
			
	if Input.is_action_just_pressed(Controls.FIRST_HABILITY_INPUT):
		finished.emit(first_hability)


func enter(previous_state_path: String, data := {}) -> void:
	# print("Entrando em Walking")
	character.animation_player.play("walking")
	
