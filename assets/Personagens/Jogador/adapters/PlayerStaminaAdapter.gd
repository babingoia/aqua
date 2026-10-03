class_name PlayerStaminaAdapter extends Stamina

@export var relay: PlayerRelay


func _on_relay_modify_stamina(request: StaminaRequestDTO) -> void:
	match request.type:
		StaminaRequests.DECREASE_OVER_TIME:
			decrease_over_time(request.amount)
		StaminaRequests.RESET:
			reset()
		_:
			printerr("Request de stamina não identificada.")
