extends Area2D

var next_scene_path = "res://scenes/world9-10/world_9_10_scene_panal_1_2.tscn"
@onready var areaPanalAbeja = self
@onready var señal_entra = $entra

func _ready():
	señal_entra.visible = false
	self.connect("body_entered",Callable(self, "on_body_entered"))
	self.connect("body_exited",Callable(self, "on_body_exited"))

func _process(delta):
	if señal_entra and Input.is_action_just_pressed("abrirLoQueSea"):
		get_tree().change_scene_to_file(next_scene_path)

func on_body_entered(body):
	if body.name == "Player":
		señal_entra.visible = true

func on_body_exited(body):
	if body.name == "Player":
		señal_entra.visible = false
