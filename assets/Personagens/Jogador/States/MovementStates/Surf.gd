class_name Surf extends PlayerState

	
func physics_update(_delta: float) -> void:	
	
	var response: HabilityResponse = hability.execute(character, _delta)
	
	match response.status:
		Response.FAILED, Response.CANCELLED:
			hability.finish(character, _delta)
			finished.emit(WALKING)
		Response.RUNNING:
			pass
		_:
			assert(false, "Resposta não identificada")	


func enter(previous_state_path: String, data := {}) -> void:
	print("Entrando em Surf")
	character.animation_player.play(anim_first_hability)
