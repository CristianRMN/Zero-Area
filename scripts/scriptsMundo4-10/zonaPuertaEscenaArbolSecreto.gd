extends Area2D

var previus_scene_path = "res://scenes/world4-10/world_4_10_scene_4_5.tscn"
var target_position = Vector2(510,-370)
@onready var señalAbrir = $salirPuerta
@onready var player = get_parent().get_node("Player")  # Asegúrate de ajustar el path si es necesario





func _ready():
	# Conectar la señal body_entered
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	señalAbrir.visible = false


func _process(delta):
	if (señalAbrir.visible) and Input.is_action_just_pressed("abrirLoQueSea"):
		señalAbrir.visible = false
		change_scene()


func _on_body_entered(body):
	if body.name == "Player":
		señalAbrir.visible = true
		
func _on_body_exited(body):
	if body.name == "Player":
		señalAbrir.visible = false

func change_scene():
	get_tree().change_scene_to_file(previus_scene_path)
	Global.player_position = target_position

