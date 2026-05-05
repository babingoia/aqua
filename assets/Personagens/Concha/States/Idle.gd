class_name ConchaIdle extends ConchaStates


# Chamada pela maquina de estados para controlar inputs
func handle_input(_event: InputEvent) -> void:
	super.handle_input(_event)
	
# Chamada pela maquina de estados no game_loop
func update(_delta: float) -> void:
	super.update(_delta)
	
# Chamada pela maquina de estados no tick de física
func physics_update(_delta: float) -> void:
	super.physics_update(_delta)

# Chamada pela maquina de estados quando o estado é inicializado
# pela primeira vez
func enter(previous_state_path: String, data := {}) -> void:
	super.enter(previous_state_path)
	
# Chamada pela maquina de estados antes do estado ser trocado
func exit() -> void:
	super.exit()
