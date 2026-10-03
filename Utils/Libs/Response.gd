class_name Response extends Node
## FAILED: Quando a operação falhou.
## CANCELLED: Quando a operação foi cancelada.
## RUNNING: Quando a operação está em andamento.
## COMPLETED: Quando a operação foi concluida com sucesso.
## INTERRUPTED: Quando a operação foi parada abruptamente.

const RUNNING: StringName     = "RUNNING"
const COMPLETED: StringName   = "COMPLETED"
const FAILED: StringName      = "FAILED"
const INTERRUPTED: StringName = "INTERRUPTED"
const CANCELLED: StringName   = "CANCELLED"
