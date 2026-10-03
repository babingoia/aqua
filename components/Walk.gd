## Componente Pura com alguns métodos template. O método de entrada nesse caso é o
## physics process que se executa sozinho.
class_name Walk extends Node

# Variáveis Públicas
## Trava o loop de andar independente de qualquer coisa.
var walking_loop: bool = false

# Variáveis internas
var _input_direction: Vector2

# Sinais
## Sinal que indica como a componente está se comportando. Envia Response.FAILED quando
## o movimento não deveria acontecer e Response.RUNNING enquanto o movimento ocorre.
signal status(status: StringName, kwargs: Dictionary)


## Método template. Por padrão pega o input com controle mas pode ser sobrescrito.
func get_input():
	_input_direction = Input.get_vector(
	Controls.LEFT, 
	Controls.RIGHT, 
	Controls.UP, 
	Controls.DOWN
	)


func _physics_process(_delta: float) -> void:
	if not walking_loop:
		self.status.emit(Response.FAILED, {})
		return
	
	get_input()
	
	if _input_direction == Vector2.ZERO:
		self.status.emit(Response.FAILED, {})
		return
	
	self.status.emit(Response.RUNNING, {})
