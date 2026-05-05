class_name ConchaStates extends State

@export var animation_player: AnimationPlayer

func _ready() -> void:
	await owner.ready
