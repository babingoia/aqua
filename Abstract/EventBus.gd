## Classe que contem signals relevantes para manipulação interna.
## de um character. É dividido entre sinais de request e de output.
## Request: São sinais emitidos por componentes que precisam de 
## uma mudança que não é de sua competência. 
## Output: São sinais emitidos por componentes como resultado 
## de alguma operação de sua competência.
class_name EventBus extends Node2D

# Sinais de Request (kwargs serve para logging e debug)
signal velocity_change_request(request: StringName, kwargs: Dictionary[Variant,Variant])
signal stamina_change_request(request: StaminaRequestDTO, kwargs: Dictionary[Variant,Variant])


# Sinais de Output
signal hability_status(response: String, kwargs: Dictionary[Variant,Variant])
signal out_of_stamina(response: String, kwargs: Dictionary[Variant,Variant])
signal state_changed(state_name: String, kwargs: Dictionary[Variant,Variant])
signal velocity_changed(value: Vector2, kwargs: Dictionary[Variant,Variant])
