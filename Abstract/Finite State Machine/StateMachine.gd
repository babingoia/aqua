# Class abstrata da maquina de estados
class_name StateMachine extends Node

# Estado inicial da Máquina de Estados
@export var initial_state: State = null 

# Estado atual da máquina de estados
@onready var state: State = (func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)
	).call()

# Se conecta a todos os signals de finished dos estados da node tree
func _ready() -> void:
	print("Iniciando State Machine", state)
	for state_node: State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)

	await  owner.ready
	state.enter("")

# Aplica a transição de um estado para outro
func _transition_to_next_state(target_state_path: String, data: Dictionary = {}) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + "Tentando ir para estado:" + target_state_path + "mas o estado não existe.")
		return
	
	var previous_state_path := state.name
	state.exit()
	state = get_node(target_state_path)
	state.enter(previous_state_path, data)

# Passa pra frente o loop do jogo pro estado
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

func _process(delta: float) -> void:
	state.update(delta)
	
