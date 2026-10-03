class_name PlayerVelocityAdapter extends Velocity


func _on_relay_modify_velocity(request: VelocityRequestDTO) -> void:
	match request.type:
		VelocityRequests.ADD_FORCE:
			if request.id == null or request.id in velocity_forces.keys():
				printerr("Request ADD_FORCE invalid id.")
				return
			if request.amount == Vector2.ZERO or request.amount == null:
				printerr("Request ADD_FORCE invalid amount.")
				return
			add_force(request.id, request.amount)
		VelocityRequests.DIRECTION:
			set_direction(request.amount)
		VelocityRequests.REMOVE_FORCE:
			remove_force(request.id)
		VelocityRequests.RESET:
			reset_velocity()
		VelocityRequests.ROTATION:
			var amount: float = request.amount.x
			set_rotation(amount)
		VelocityRequests.ZERO:
			lock_velocity()
