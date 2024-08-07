extends CharacterBody2D

@onready var areaEntrar = $zonaEntrar
@onready var señalEntrar = $zonaEntrar/entra
var scene_secret_tree = "res://scenes/world4-10/arbol_secreto.tscn"

func _ready():
	areaEntrar.connect("body_entered", Callable(self, "_on_body_entered"))
	areaEntrar.connect("body_exited", Callable(self, "_on_body_exited"))
	señalEntrar.visible = false
	
func _physics_process(delta):
	if (señalEntrar.visible) and Input.is_action_just_pressed("abrirLoQueSea"):
		get_tree().change_scene_to_file(scene_secret_tree)


func _on_body_entered(body):
	if body.name == "Player":
		señalEntrar.visible = true
		
func _on_body_exited(body):
	if body.name == "Player":
		señalEntrar.visible = false
