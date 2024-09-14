extends Area2D

var previus_scene_path = "res://scenes/world8-10/world_8_10_secret_scene.tscn"

 
func _ready():
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		change_scene()

func change_scene():
	get_tree().change_scene_to_file(previus_scene_path)


