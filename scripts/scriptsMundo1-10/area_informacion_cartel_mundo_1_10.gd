extends Node2D

@onready var label = $Label

func _ready():
	pass

func _process(delta):
	if Input.is_action_just_pressed("abrirLoQueSea"):
		get_tree().change_scene_to_file("res://scenes/world1-10/world_1_10.Scene1-5.tscn")
