extends Area2D

var previus_scene_path = "res://scenes/world4-10/world_4_10_scene_3_5.tscn"
var target_position = Vector2(600,70)
@onready var player = get_parent().get_node("Player")  # Asegúrate de ajustar el path si es necesario
  

func _ready():
	# Conectar la señal body_entered
	self.body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	if body.name == "Player":
		change_scene()

func change_scene():
	get_tree().change_scene_to_file(previus_scene_path)
	Global.player_position = target_position

