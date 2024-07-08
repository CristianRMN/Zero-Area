extends Area2D

@onready var señalAbrir = $salir


func _ready():
	# Conectar señales de entrada y salida
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	señalAbrir.visible = false

func _on_body_entered(body):
	if body.name == "Player":
		señalAbrir.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		señalAbrir.visible = false

func _process(delta):
	if señalAbrir.visible and Input.is_action_just_pressed("abrirLoQueSea"):
		señalAbrir.visible = false
		get_tree().change_scene_to_file("res://scenes/world1-10/world_1_10.Scene3-5.tscn")
