class_name Player extends CharacterBody2D

#Composição
@onready var vida: Vida = $Vida
@onready var velocidade: Velocidade = $Velocidade
@onready var stamina: Stamina = $Stamina
@onready var almas: Almas = $Almas
@onready var movement_state_machine = $StateMachine
@onready var animation_player = $AnimationPlayer
