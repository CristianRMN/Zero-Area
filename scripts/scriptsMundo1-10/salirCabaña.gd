extends Area2D

@onready var señalSalir = $"salirDeLaCabaña"


func _ready():
	# Conectar señales de entrada y salida
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	señalSalir.visible = false

func _on_body_entered(body):
	if body.name == "Player":
		señalSalir.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		señalSalir.visible = false

func _process(delta):
	if señalSalir.visible and Input.is_action_just_pressed("abrirLoQueSea"):
		señalSalir.visible = false
		get_tree().change_scene_to_file("res://scenes/world1-10/world_1_10.Scene3-5.tscn")
