extends Node2D

#esta miel recupera 5 de vida durante unos segundos

@onready var señalComer1 = $"Area2D/comeK"
@onready var señalComer2 = $"Area2D/comeX"
@onready var areaMiel = $Area2D
const finish_miel = 10
var start_eat_miel = 0


func _ready():
	# Conectar señales de entrada y salida
	areaMiel.connect("body_entered", Callable(self, "_on_body_entered"))
	areaMiel.connect("body_exited", Callable(self, "_on_body_exited"))
	señalComer1.visible = false
	señalComer2.visible = false


func _on_body_entered(body):
	if body.name == "Player":
		señalComer1.visible = true
		señalComer2.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		señalComer1.visible = false
		señalComer2.visible = false

func _process(delta):
	if (señalComer1.visible or señalComer2.visible) and Input.is_action_just_pressed("alimentacion"):
		start_eat_miel += 1
		if finish_miel <= start_eat_miel:
			call_deferred("queue_free")
			start_eat_miel = 0
		

