class_name Player extends Character

#Composição
@onready var movement_state_machine: StateMachine = $StateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	vida = $Vida
	velocidade = $Velocidade
	stamina = $Stamina
	almas = $Almas
