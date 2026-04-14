class_name Idle extends PlayerState


# Chamada pela maquina de estados para controlar inputs
func handle_input(_event: InputEvent) -> void:
	pass
	
# Chamada pela maquina de estados no game_loop
func update(_delta: float) -> void:
	pass
	
# Chamada pela maquina de estados no tick de física
func physics_update(_delta: float) -> void:
	super.physics_update(_delta)
	if Input.is_action_just_pressed(UP) or Input.is_action_just_pressed(DOWN) or Input.is_action_just_pressed(RIGHT) or Input.is_action_just_pressed(LEFT):
		finished.emit(WALKING)
	
# Chamada pela maquina de estados quando o estado é inicializado
# pela primeira vez
func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path)
	player.velocity.x = 0.0
	player.animation_player.play('idle')
	
# Chamada pela maquina de estados antes do estado ser trocado
func exit() -> void:
	printerr("Saindo do estado:" + str(get_path()))
	pass
