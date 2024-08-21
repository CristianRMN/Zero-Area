extends Node2D


func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("abrirLoQueSea"):
		get_tree().change_scene_to_file("res://scenes/world6-10/world_6_10_scene_1_5.tscn")
