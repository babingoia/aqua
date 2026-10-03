## Classe componente pura. Expõe métodos que podem ser sobrescritos depois
## via adapters.
## Habilidade que trava o movimento em uma direção e adiciona curva suave com
## aceleração centrípeta simulando um MCU. Os inputs são dinânimos,
## fazendo com que a curva aconteça dependente da direção do movimento.
## Classe responsavel somente pela mecânica do movimento, expondo atributos
## de velocidade e rotação através de signals dinamicamente.
class_name HabilitySurf extends Hability

#Sinais
signal status(response: String, kwargs: Dictionary)
signal velocity_changed(value: Vector2, kwargs: Dictionary)
signal rotation_changed(value: float, kwargs: Dictionary)

#Exports
@export var velocity: Vector2 = Vector2.ZERO:
	set(new_value):
		velocity = new_value
		velocity_changed.emit(new_value, {})
@export var velocity_multiplier: float
@export var rotation_speed: float

#Variaveis internas
var _is_direction_got: bool = false
var _input_direction: Vector2
var _rotation_direction: float:
	set(new_value):
		_rotation_direction = new_value
		rotation_changed.emit(new_value, {})


func _ready() -> void:
	hability_name = HabilityNames.SURF


## Método que define a rotação da habilidade através do Input do usuário.
## Instrução de sobrescrita. 
func _set_rotation() -> void:
	if _input_direction.x != 0:
		if Input.is_action_pressed(Controls.UP):
			_rotation_direction = rotation_speed * _input_direction.x
		elif Input.is_action_pressed(Controls.DOWN):
			_rotation_direction = -rotation_speed * _input_direction.x
				
	if _input_direction.y != 0:
		if Input.is_action_pressed(Controls.LEFT):
			_rotation_direction = rotation_speed * _input_direction.x
		elif Input.is_action_pressed(Controls.RIGHT):
			_rotation_direction = -rotation_speed * _input_direction.x


## Método que define a direção inicial que a força aponta. Pega a direção do
## primeiro input e trava a escolha.
## Instrução de sobrescita.
func _get_direction() -> void:
	_input_direction = Input.get_vector(
		Controls.LEFT, 
		Controls.RIGHT, 
		Controls.UP, 
		Controls.DOWN
	)
	
	if _input_direction == Vector2.ZERO:
		status.emit(Response.FAILED, {})
		return
		
	_is_direction_got = true


## Método do tipo RUNNING que exige execução contínua.
## Inicia a execução da habilidade mas não contém lógica propriamente, apenas
## uma sequência de métodos para serem executados e lógica imutável.
func execute() -> void:
	if _is_direction_got == false:
		_get_direction()
	else:
		_set_rotation()
		status.emit(Response.RUNNING, {})


## Termina de forma segura a execução da habilidade, resetando efeitos colaterais.
## Pode ser sobrescrito mas com Super necessário.
func finish() -> void:
	_is_direction_got = false
	_input_direction = Vector2.ZERO
	status.emit(Response.INTERRUPTED, {})
