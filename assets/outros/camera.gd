extends Camera2D

var player: Character
var concha: Character
var player_na_tela: VisibleOnScreenNotifier2D
var concha_na_tela: VisibleOnScreenNotifier2D

@export var zoom_smothness: float = 5
@export var move_speed: float = 0.5
@export var zoom_speed: float = 0.15
@export var min_zoom: float = 0.4
@export var max_zoom: float = 5

var zoom_target: Vector2
var zoom_current: Vector2
var vec_min_zoom: Vector2
var vec_max_zoom: Vector2
var vec_zoom_speed: Vector2 
var map_limits: Rect2


func _ready() -> void:
	await owner.ready
	
	player = get_node("../Player")
	player_na_tela = player.get_node("OnScreen")
	concha = get_node("../Concha")
	concha_na_tela = concha.get_node("OnScreen")
	zoom = Vector2(0.4, 0.4)
	map_limits = get_node("../Limites").get_rect()
	
	print(player_na_tela, concha_na_tela)
	
	limit_enabled = true
	limit_top = map_limits.position.y
	limit_left = map_limits.position.x
	limit_bottom = map_limits.end.y
	limit_right = map_limits.end.x
	
	vec_max_zoom = Vector2(max_zoom, max_zoom)
	vec_min_zoom = Vector2(min_zoom, min_zoom)
	vec_zoom_speed = Vector2(zoom_speed, zoom_speed)
	zoom_target = zoom


func _input(event: InputEvent) -> void:
	if player_na_tela.is_on_screen() and concha_na_tela.is_on_screen():
		
		if event.is_action_pressed(Controls.ZOOM_IN) and zoom < vec_max_zoom:
			zoom_target = clamp(zoom + vec_zoom_speed, vec_min_zoom, vec_max_zoom)
			
		if event.is_action_pressed(Controls.ZOOM_OUT) and zoom > vec_min_zoom:
			zoom_target = clamp(zoom - vec_zoom_speed, vec_min_zoom, vec_max_zoom)


func _process(delta: float) -> void:
	if !player or !concha:
		return
	
	var center: Vector2 = Vector2.ZERO
	
	center += concha.position
	center += player.position
	center /= 2
	
	position = lerp(position, center, move_speed)
	
	if !player_na_tela.is_on_screen() or !concha_na_tela.is_on_screen():
		zoom_target = clamp(zoom - vec_zoom_speed, vec_min_zoom, vec_max_zoom)

	if zoom != zoom_target:
		zoom = lerp(zoom, zoom_target, zoom_smothness * delta)
