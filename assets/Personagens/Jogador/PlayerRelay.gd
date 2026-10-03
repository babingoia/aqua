## Classe que amontua signals concretos para manipulação interna na interface
## do godot em um character.
class_name PlayerRelay extends Node

# Declarações
signal modify_stamina(request: StaminaRequestDTO)
signal modify_velocity(request: VelocityRequestDTO)
signal movement_state_changed(state_name: StateDTO)
signal action_state_changed(state_name: StateDTO)
signal out_of_stamina()
signal velocity_changed(value: Vector2)
signal rotation_changed(value: float)
signal active_hability_changed(hability_name: StringName)


#Implementações
func _on_hability_surf_modify_stamina(request: StaminaRequestDTO, _kwargs: Dictionary) -> void:
	modify_stamina.emit(request)


func _on_hability_surf_modify_velocity(request: VelocityRequestDTO, _kwargs: Dictionary) -> void:
	modify_velocity.emit(request)


func _on_movement_state_machine_state_changed(data: StateDTO) -> void:
	movement_state_changed.emit(data)


func _on_action_state_machine_state_changed(data: StateDTO) -> void:
	action_state_changed.emit(data)


func _on_stamina_out_of_stamina() -> void:
	out_of_stamina.emit()


func _on_velocidade_rotation_changed(value: float, _kwargs: Dictionary) -> void:
	rotation_changed.emit(value)

func _on_velocidade_velocity_changed(value: Vector2, _kwargs: Dictionary) -> void:
	velocity_changed.emit(value)


func _on_habilidades_active_hability_changed(hability_name: StringName) -> void:
	active_hability_changed.emit(hability_name)
