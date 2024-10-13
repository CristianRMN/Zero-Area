extends Area2D

var previus_scene_path = "res://scenes/world9-10/world_9_10_secret_scene.tscn"
var target_position = Vector2(442, 116)
@onready var señalSalir = $salir
@onready var areaSalir = self

func _ready():
	señalSalir.visible = false
	self.connect("body_entered",Callable(self, "on_body_entered"))
	self.connect("body_exited",Callable(self, "on_body_exited"))


func _process(delta):
	if señalSalir.visible and Input.is_action_just_pressed("abrirLoQueSea"):
		get_tree().change_scene_to_file(previus_scene_path)
		Global.player_position = target_position

func on_body_entered(body):
	if body.name == "Player":
		señalSalir.visible = true

func on_body_exited(body):
	if body.name == "Player":
		señalSalir.visible = false



