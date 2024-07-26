extends CharacterBody2D


@onready var areaCorte = $Area2D
@onready var señalCortar = $Area2D/corta



func _ready():
	# Conectar señales de entrada y salida
	areaCorte.connect("body_entered", Callable(self, "_on_body_entered"))
	areaCorte.connect("body_exited", Callable(self, "_on_body_exited"))
	señalCortar.visible = false


func _on_body_entered(body):
	if body.name == "Player":
		señalCortar.visible = true


func _on_body_exited(body):
	if body.name == "Player":
		señalCortar.visible = false





