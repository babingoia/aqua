extends Camera2D

@export var player: Character
@export var concha: Character

var player_na_tela: Dictionary[String, VisibleOnScreenNotifier2D]
var concha_na_tela: Dictionary[String, VisibleOnScreenNotifier2D]

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


func _ready() -> void:
	await owner.ready
	
	player_na_tela = {
	"left": player.get_node("%OnScreenLeft"),
	"right": player.get_node("%OnScreenRight"),
	"up": player.get_node("%OnScreenUp"),
	"down": player.get_node("%OnScreenDown")
}
	concha_na_tela = {
	"left": concha.get_node("%OnScreenLeft"),
	"right": concha.get_node("%OnScreenRight"),
	"up": concha.get_node("%OnScreenUp"),
	"down": concha.get_node("%OnScreenDown")
}

	zoom = Vector2(0.4, 0.4)
	
	print(player_na_tela, concha_na_tela)
	
	vec_max_zoom = Vector2(max_zoom, max_zoom)
	vec_min_zoom = Vector2(min_zoom, min_zoom)
	vec_zoom_speed = Vector2(zoom_speed, zoom_speed)
	zoom_target = zoom


func is_on_screen_dict(target: Dictionary[String, VisibleOnScreenNotifier2D]) -> bool:
	var left: bool = target["left"].is_on_screen()
	var right: bool = target["right"].is_on_screen()
	var up: bool = target["up"].is_on_screen()
	var down: bool = target["down"].is_on_screen()
	
	if left and right and up and down:
		return true
	else:
		return false


func _input(event: InputEvent) -> void:
	if is_on_screen_dict(player_na_tela) and is_on_screen_dict(concha_na_tela):
		 
		if event.is_action_pressed(Controls.ZOOM_IN) and zoom < vec_max_zoom:
			zoom_target = clamp(zoom + vec_zoom_speed, vec_min_zoom, vec_max_zoom)
			
		if event.is_action_pressed(Controls.ZOOM_OUT) and zoom > vec_min_zoom:
			zoom_target = clamp(zoom - vec_zoom_speed, vec_min_zoom, vec_max_zoom)


func _process(delta: float) -> void:
	if !player or !concha:
		return
	
	var center: Vector2 = Vector2.ZERO
	
	center += concha.global_position
	center += player.global_position
	center /= 2
	
	global_position = lerp(global_position, center, move_speed * delta)
	
	if !is_on_screen_dict(player_na_tela) or !is_on_screen_dict(concha_na_tela):
		zoom_target = clamp(zoom - vec_zoom_speed, vec_min_zoom, vec_max_zoom)

	if zoom != zoom_target:
		zoom = lerp(zoom, zoom_target, zoom_smothness * delta)
