extends Area2D

@export var next_scene_path = "res://scenes/world3-10/wordl_3_10_cueva_cofre_scene_4_5.tscn"  

func _ready():
	# Conectar la señal body_entered
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		change_scene()

func change_scene():
	# Cambia a la nueva escena
	get_tree().change_scene_to_file(next_scene_path)
