# Classe base que guarda nomes importantes
class_name PlayerState extends State

# Nomes estados
const IDLE: String = "Idle"
const WALKING: String = "Walking"
var first_hability: String
var second_hability: String
var third_hability: String


func _ready() -> void:
	await owner.ready
	character = owner as Player
	
	first_hability = character.stats.first_hability.state_name
	second_hability = character.stats.second_hability.state_name
	third_hability = character.stats.third_hability.state_name

	assert(character != null,
	 "O PlayerState precisa estar ligado a um Player") 
