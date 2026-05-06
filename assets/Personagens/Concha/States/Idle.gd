class_name ConchaIdle extends ConchaStates


func enter(previous_state_path: String, data := {}) -> void:
	print("Entrando em Concha IDLE")
	character.animation_player.play(ANIM_IDLE)
