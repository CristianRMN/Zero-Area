extends Node2D

@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var mariposa1 = $mariposa/AnimationPlayer

@onready var señalKPlatano = $platano_recupera_vida/BananaKeyboardK
@onready var señalxPlatano = $platano_recupera_vida/BananaKeyboardX

@onready var señalKPlatano2 = $platano_recupera_vida2/BananaKeyboardK
@onready var señalxPlatano2 = $platano_recupera_vida2/BananaKeyboardX

@onready var araña1 = $"EnemigoAraña"
@onready var mono1 = $enemigoMono
@onready var puerco1 = $enemigoPuerco

var initial_position = Vector2()  # Variable para almacenar la posición inicial

func _ready():
	# Guardar la posición inicial del jugador
	initial_position = player.global_position
	mariposa1.play("volandoDiagonalSuperiorIzquierda")
	araña1.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	mono1.connect("body_entered", Callable(self, "_on_enemigo_mono_on_body_entered"))
	puerco1.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))


	# Restaurar la posición del jugador si se ha almacenado una posición
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		# Resetea la posición para que no interfiera con futuros cambios de escena
		Global.player_position = Vector2()

func _physics_process(delta):
	# Verificar si el jugador ha caído por debajo de un umbral
	if player.global_position.y > 500: 
		respawn_player()

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKPlatano) and señalKPlatano.visible:
			life.heal(18)
			señalKPlatano.visible = false  
		elif is_instance_valid(señalxPlatano) and señalxPlatano.visible:
			life.heal(18)
			señalxPlatano.visible = false 

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKPlatano2) and señalKPlatano2.visible:
			life.heal(18)
			señalKPlatano2.visible = false  
		elif is_instance_valid(señalxPlatano2) and señalxPlatano2.visible:
			life.heal(18)
			señalxPlatano2.visible = false 



func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)

func _on_enemigo_araña_on_body_entered(body):
	if body.name == "Player":
		life.damage(8)

func _on_enemigo_mono_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)

func on_puerco_on_body_entered(body):
	if body.name == "Player":
		life.damage(20)




