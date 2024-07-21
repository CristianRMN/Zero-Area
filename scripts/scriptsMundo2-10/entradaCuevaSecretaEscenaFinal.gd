extends Area2D

@export var next_scene_path = "res://scenes/world2-10/secret_cave.tscn"

  

func _ready():
	# Conectar la señal body_entered
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		change_scene()

func change_scene():
	# Cambia a la nueva escena
	get_tree().change_scene_to_file(next_scene_path)

