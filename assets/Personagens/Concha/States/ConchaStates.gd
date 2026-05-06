class_name ConchaStates extends State

# Animações
const ANIM_IDLE: String = "Idle"

# Estados
const STATE_IDLE: String = "Idle"


func _ready() -> void:
	await owner.ready
	character = owner as Character
	print("Concha:", character)

	assert(character != null,
	 "O PlayerState precisa estar ligado a um Player") 
