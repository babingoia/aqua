class_name Surf extends PlayerState
@onready var audio_surf: AudioStreamPlayer = $"../../audio_surf"


func _ready() -> void:
	super._ready()
	hability = $%HabilitySurf
	
	
func physics_update(_delta: float) -> void:	
	super.physics_update(_delta)
	
	if character.stamina.actual_stamina < hability.cost:
		hability.finish(character, _delta)
		finished.emit(WALKING)
	
	if Input.is_action_just_pressed(Controls.FIRST_HABILITY_INPUT):
		hability.finish(character, _delta)
		finished.emit(WALKING)
		return


func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path)
	audio_surf.play()
	
func exit() -> void:
	audio_surf.stop()
	
