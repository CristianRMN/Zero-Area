extends Area2D

@export var next_scene_path = "res://scenes/world9-10/world_9_10_scene_3_5.tscn"

  

func _ready():
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		change_scene()

func change_scene():
	get_tree().change_scene_to_file(next_scene_path)

