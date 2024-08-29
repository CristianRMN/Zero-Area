extends Node2D

var previus_scene_path = "res://scenes/world6-10/world_6_10_final_scene.tscn"

@onready var mariposa1 = $mariposa/AnimationPlayer
@onready var mariposa2 = $mariposa2/AnimationPlayer

@onready var vueltaEscenaSaltoIzquierda = $vueltaEscenaFinalDesdeEscenaSecretaSaltoIzquierda
@onready var vueltaEscenaBloque1 = $vueltaEscenaFinalDesdeEscenaSecretaBloque1
@onready var vueltaEscenaMedio = $vueltaEscenaFinalDesdeEscenaSecretaMedioBloques
@onready var vueltaEscenaBloque2 = $vueltaEscenaFinalDesdeEscenaSecretaBloque2
@onready var vueltaEscenaSaltoDerecha = $vueltaEscenaFinalDesdeEscenaSecretasaltoDerecha

func _ready():
	mariposa1.play("volandoArriba")
	mariposa2.play("volandoArriba")
	vueltaEscenaSaltoIzquierda.connect("body_entered", Callable(self, "on_vuelta_salto_izquierda_on_body_entered"))
	vueltaEscenaBloque1.connect("body_entered", Callable(self, "on_vuelta_bloque1_on_body_entered"))
	vueltaEscenaMedio.connect("body_entered", Callable(self, "on_vuelta_medio_on_body_entered"))
	vueltaEscenaBloque2.connect("body_entered", Callable(self, "on_vuelta_bloque2_on_body_entered"))
	vueltaEscenaSaltoDerecha.connect("body_entered", Callable(self, "on_vuelta_salto_derecha_on_body_entered"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_vuelta_salto_izquierda_on_body_entered(body):
	if body.name == "Player":
		change_scene_salto_izquierda()

func on_vuelta_bloque1_on_body_entered(body):
	if body.name == "Player":
		change_scene_bloque1()

func on_vuelta_medio_on_body_entered(body):
	if body.name == "Player":
		change_scene_medio()


func on_vuelta_bloque2_on_body_entered(body):
	if body.name == "Player":
		change_scene_bloque2()

func on_vuelta_salto_derecha_on_body_entered(body):
	if body.name == "Player":
		change_scene_salto_derecha()

func change_scene_salto_izquierda():
	var target_position = Vector2(-277, -425)
	get_tree().change_scene_to_file(previus_scene_path)
	Global.player_position = target_position

func change_scene_bloque1():
	var target_position = Vector2(-204, -426)
	get_tree().change_scene_to_file(previus_scene_path)
	Global.player_position = target_position

func change_scene_medio():
	var target_position = Vector2(-137, -425)
	get_tree().change_scene_to_file(previus_scene_path)
	Global.player_position = target_position

func change_scene_bloque2():
	var target_position = Vector2(-73, -424)
	get_tree().change_scene_to_file(previus_scene_path)
	Global.player_position = target_position

func change_scene_salto_derecha():
	var target_position = Vector2(29, -424)
	get_tree().change_scene_to_file(previus_scene_path)
	Global.player_position = target_position
