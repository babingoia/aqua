# Classe base que guarda nomes importantes
class_name PlayerState extends State

# Nomes estados
const IDLE: String = "Idle"
const WALKING: String = "Walking"
var first_hability: String
var second_hability: String
var third_hability: String

# Nomes Animações
const ANIM_IDLE: String = "Idle"
const ANIM_WALKING: String = "Walking"
var anim_first_hability: String
var anim_second_hability: String


func _ready() -> void:
	await owner.ready
	character = owner as Player
	print(character)
	
	first_hability = character.first_hability.state_name
	second_hability = character.second_hability.state_name
	
	anim_first_hability = character.first_hability.anim_name
	anim_second_hability = character.second_hability.state_name

	assert(character != null,
	 "O PlayerState precisa estar ligado a um Player") 
