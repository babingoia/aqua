extends Camera2D

@export var move_speed: float = 0.5
@export var zoom_speed: float = 0.05
@export var min_zoom: float = 0.4
@export var max_zoom: float = 5
var vec_min_zoom: Vector2
var vec_max_zoom: Vector2
var vec_zoom_speed: Vector2 
var limits: Rect2
var player: Character
var player_na_tela: VisibleOnScreenNotifier2D
var concha: Character
var concha_na_tela: VisibleOnScreenNotifier2D

func _ready() -> void:
	await owner.ready
	
	player = get_node("../Player")
	player_na_tela = player.get_node("OnScreen")
	concha = get_node("../Concha")
	concha_na_tela = concha.get_node("OnScreen")
	zoom = Vector2(0.4, 0.4)
	limits = get_node("../Limites").get_rect()
	
	print(player_na_tela, concha_na_tela)
	
	limit_enabled = true
	limit_top = limits.position.y
	limit_left = limits.position.x
	limit_bottom = limits.end.y
	limit_right = limits.end.x
	
	vec_max_zoom = Vector2(max_zoom, max_zoom)
	vec_min_zoom = Vector2(min_zoom, min_zoom)
	vec_zoom_speed = Vector2(zoom_speed, zoom_speed)
	

func _input(event: InputEvent) -> void:
	if player_na_tela.is_on_screen() and concha_na_tela.is_on_screen():
		
		if event.is_action_pressed(Controls.ZOOM_IN) and zoom < vec_max_zoom:
			zoom = clamp(zoom + vec_zoom_speed, vec_min_zoom, vec_max_zoom)
		
		if event.is_action_pressed(Controls.ZOOM_OUT) and zoom > vec_min_zoom:
			zoom = clamp(zoom - vec_zoom_speed, vec_min_zoom, vec_max_zoom)


func _process(delta: float) -> void:
	if !player or !concha:
		return
	
	var center: Vector2 = Vector2.ZERO
	
	center += concha.position
	center += player.position
	center /= 2
	
	position = lerp(position, center, move_speed)
	
