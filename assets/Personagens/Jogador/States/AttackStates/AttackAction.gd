class_name AttackAction extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	print("Atacando...")


func update(_delta: float) -> void:
	var response: HabilityResponse = hability.execute(character, _delta)
	
	match response:
		Response.RUNNING:
			pass
		_:
			hability.finish(character, _delta)
			finished.emit(IDLE)
			
		

func physics_update(_delta: float) -> void:
	pass
