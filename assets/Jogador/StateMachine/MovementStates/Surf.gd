class_name Surf extends PlayerState

func _ready() -> void:
	super._ready()
	hability = $%HabilitySurf
	
	
func physics_update(_delta: float) -> void:	
	super.physics_update(_delta)
	
	if character.stamina.actual_stamina < hability.cost:
		hability.finish(character, _delta)
		finished.emit(WALKING)
		return
		
	elif Input.is_action_just_pressed(controls.FIRST_HABILITY_INPUT):
		hability.finish(character, _delta)
		finished.emit(WALKING)
		return


func enter(previous_state_path: String, data := {}) -> void:
	character.animation_player.play("surf")
