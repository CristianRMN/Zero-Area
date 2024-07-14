extends Node2D

@onready var player = $Player 
@onready var life = $vidaTerapagos/ProgressBar
@onready var señalxManzana = $manzanaRecuperaTodaVida/pulsaX
@onready var señalkManzana = $manzanaRecuperaTodaVida/pulsaK
@onready var bolaPincho1 = $zonaPinchosEstaticos1
@onready var bolaPincho2 = $zonaPinchosEstaticos2
@onready var bolaPincho3 = $zonaPinchosEstaticos3
@onready var bolaPinchosMagica1 = $bolaPinchoPecharuntVertical
@onready var bolaPinchosMagica2 = $bolaPinchoPecharuntVertical2
@onready var bolaPinchosMagica3 = $bolaPinchoPecharuntVertical3


var initial_position = Vector2()  # Variable para almacenar la posición inicial

func _ready():
	# Guardar la posición inicial del jugador
	initial_position = player.global_position


	# Restaurar la posición del jugador si se ha almacenado una posición
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		# Resetea la posición para que no interfiera con futuros cambios de escena
		Global.player_position = Vector2()
	
	bolaPincho1.connect("body_entered", Callable(self, "_on_bola_pincho_on_body_entered"))
	bolaPincho2.connect("body_entered", Callable(self, "_on_bola_pincho_on_body_entered"))
	bolaPincho3.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))
	
	bolaPinchosMagica1.connect("body_entered", Callable(self, "_on_bola_pincho_magica_on_body_entered"))
	bolaPinchosMagica2.connect("body_entered", Callable(self, "_on_bola_pincho_magica_on_body_entered"))
	bolaPinchosMagica3.connect("body_entered", Callable(self, "on_bola_pincho_magica_on_body_entered"))
	
	

func _physics_process(delta):
	# Verificar si el jugador ha caído por debajo de un umbral
	if player.global_position.y > 500: 
		respawn_player()
	
	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalkManzana) and señalkManzana.visible:
			life.heal(100)
			señalkManzana.visible = false  
		elif is_instance_valid(señalxManzana) and señalxManzana.visible:
			life.heal(100)
			señalxManzana.visible = false 

		
		


func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)
	

func _on_bola_pincho_on_body_entered(body):
	if body.name == "Player":
		life.damage(20)

func _on_bola_pincho_magica_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

	


	
	
