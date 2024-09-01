extends Node2D

#retorno a la escena 1
var previus_scene_path = "res://scenes/world7-10/wolrd_7_10_scene_1_5.tscn"

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer

var initial_position = Vector2() 

#comida
@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX


#enemigos
@onready var murcielago1 = $murcielago
@onready var puerco1 = $enemigoPuerco
@onready var araña1 = $"EnemigoAraña"
@onready var hipopotamo1 = $hipopotamo
@onready var mofeta1ContactoSinPedo = $enemigoMofeta
@onready var mofeta1ContactoConPedo = $enemigoMofeta/areaPedo

#caminosTroll
@onready var caminosTroll = $caminosTroll

func _ready():
#posicion del jugador
	initial_position = player.global_position
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		Global.player_position = Vector2()

#conexiones enemigos
	hipopotamo1.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))
	murcielago1.connect("body_entered", Callable(self, "on_murcielago_on_body_entered"))
	puerco1.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	araña1.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	mofeta1ContactoSinPedo.connect("body_entered", Callable(self, "on_mofeta_sin_pedo_on_body_entered"))
	mofeta1ContactoConPedo.connect("body_entered", Callable(self, "on_mofeta_con_pedo_on_body_entered"))

#conexiones caminos
	caminosTroll.connect("body_entered", Callable(self, "on_camino_troll_on_body_entered"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.global_position.y > 500: 
		respawn_player()


	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKManzana) and señalKManzana.visible:
			life.heal(20)
			señalKManzana.visible = false  
		elif is_instance_valid(señalxManzana) and señalxManzana.visible:
			life.heal(20)
			señalxManzana.visible = false 

#funcion respawn del jugador
func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)

#funciones de los enemigos
func on_hipopotamo_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

func on_murcielago_on_body_entered(body):
	if body.name == "Player":
		life.damage(12)



func on_puerco_on_body_entered(body):
	if body.name == "Player":
		life.damage(20)

func _on_enemigo_araña_on_body_entered(body):
	if body.name == "Player":
		life.damage(8)

func on_camino_troll_on_body_entered(body):
	if body.name == "Player":
		returnScene1()

func on_mofeta_sin_pedo_on_body_entered(body):
	if body.name == "Player":
		life.damage(5)

func on_mofeta_con_pedo_on_body_entered(body):
	if body.name == "Player":
		life.damage(25)

func returnScene1():
	get_tree().change_scene_to_file(previus_scene_path)
