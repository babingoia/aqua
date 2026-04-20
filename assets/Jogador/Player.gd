class_name Player extends Character

#Composição
@onready var movement_state_machine: StateMachine = $MovementStateMachine
@onready var attack_state_machine: StateMachine = $AttackStateMachine
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var stats: Character = $Stats


func _ready() -> void:
	vida = stats.vida
	velocidade = stats.velocidade
	stamina = stats.stamina
	almas = stats.almas
