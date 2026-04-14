class_name Walking extends PlayerState

# Chamada pela maquina de estados para controlar inputs
func handle_input(_event: InputEvent) -> void:
	pass
	
# Chamada pela maquina de estados no game_loop
func update(_delta: float) -> void:
	pass
	
# Chamada pela maquina de estados no tick de física
func physics_update(_delta: float) -> void:
	var input_direction_x := Input.get_axis(LEFT, RIGHT)
	var input_direction_y := Input.get_axis(UP, DOWN)
	
	player.velocity.x = player.velocidade.velocidade * input_direction_x
	player.velocity.y = player.velocidade.velocidade * input_direction_y
	
	player.move_and_slide()
	
	if is_equal_approx(input_direction_x, 0.0) and is_equal_approx(input_direction_y, 0.0):
		finished.emit(IDLE)	

# Chamada pela maquina de estados quando o estado é inicializado
# pela primeira vez
func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path)
	player.animation_player.play("walking")
	
# Chamada pela maquina de estados antes do estado ser trocado
func exit() -> void:
	super.exit()
