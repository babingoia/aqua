# Classe abstrata de Estado
class_name State extends Node
var hability: Hability = NullHability.new()
var character: Character

# Ativada quando o estado é finalizado
signal finished(next_state_path: String, data: Dictionary);

# Chamada pela maquina de estados para controlar inputs
func handle_input(_event: InputEvent) -> void:
	pass
	
# Chamada pela maquina de estados no game_loop
func update(_delta: float) -> void:
	pass
	
# Chamada pela maquina de estados no tick de física
func physics_update(_delta: float) -> void:
	hability.execute(character, _delta)

# Chamada pela maquina de estados quando o estado é inicializado
# pela primeira vez
func enter(previous_state_path: String, data := {}) -> void:
	print("Entrando no estado:" + str(get_path()))
	
	
# Chamada pela maquina de estados antes do estado ser trocado
func exit() -> void:
	print("Saindo do estado:" + str(get_path()))
	
