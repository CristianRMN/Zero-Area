extends Node2D

@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var nuevaPosicionHacha = $Player/Marker2D3


@onready var puerco = $enemigoPuerco
@onready var serpiente = $enemigoSerpiente

@onready var armaHacha = $hacha
@onready var armaHachaAnim = $hacha/AnimationPlayer

@onready var arbolCaeArea = $arbolCaido/Area2D
@onready var arbolCaeAnim = $arbolCaido/AnimationPlayer
@onready var arbolCaeColisionShape1 = $arbolCaido/CollisionShape2D
@onready var arbolCaeColisionShape2 = $arbolCaido/CollisionShape2D2
@onready var arbolCaeSignoV = $arbolCaido/Area2D/corta

@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX

@onready var ventilador1 = $ventiladoresMortales
@onready var ventilador2 = $ventiladoresMortales2
@onready var ventilador3 = $ventiladoresMortales3

@onready var ventilador1anim = $ventiladoresMortales/AnimationPlayer
@onready var ventilador2anim = $ventiladoresMortales2/AnimationPlayer
@onready var ventilador3anim = $ventiladoresMortales3/AnimationPlayer

var axeZone = false
var haveTheAxe = false
var cutZone = false



var up = -10

var is_near_escalera = false

var initial_position = Vector2()  # Variable para almacenar la posición inicial

func _ready():
	# Guardar la posición inicial del jugador
	initial_position = player.global_position
	puerco.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	serpiente.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	
	armaHacha.connect("body_entered", Callable(self, "_on_hacha_on_body_entered"))
	armaHacha.connect("body_exited", Callable(self, "_on_hacha_on_body_exited"))
	
	arbolCaeArea.connect("body_entered", Callable(self, "_on_arbol_cae_on_body_entered"))
	arbolCaeArea.connect("body_exited", Callable(self, "_on_arbol_cae_on_body_exited"))

	ventilador1.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador2.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador3.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))


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
		if is_instance_valid(señalKManzana) and señalKManzana.visible:
			life.heal(20)
			señalKManzana.visible = false  
		elif is_instance_valid(señalxManzana) and señalxManzana.visible:
			life.heal(20)
			señalxManzana.visible = false 
		
	if axeZone and Input.is_action_just_pressed("abrirLoQueSea"):
		haveTheAxe = true

	if haveTheAxe:
		armaHacha.global_position = nuevaPosicionHacha.global_position
		
	if haveTheAxe and cutZone and Input.is_action_just_pressed("abrirLoQueSea"):
		armaHachaAnim.play("cortar")
		arbolCaeAnim.play("arbolVaaaa")
		arbolCaeColisionShape1.disabled = true
		arbolCaeColisionShape2.disabled = false
		
	if arbolCaeColisionShape1.disabled:
		cutZone = false
		arbolCaeSignoV.hide()
		if armaHachaAnim.is_playing():
			armaHacha.visible = true
		else:
			armaHacha.visible = false

	


func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)
	
func on_puerco_on_body_entered(body):
	if body.name == "Player":
		life.damage(20)
	

func _on_hacha_on_body_entered(body):
	if body.name == "Player":
		axeZone = true
		
func _on_hacha_on_body_exited(body):
	if body.name == "Player":
		axeZone = false
		
func _on_arbol_cae_on_body_entered(body):
	if body.name == "Player":
		cutZone = true
		
func _on_arbol_cae_on_body_exited(body):
	if body.name == "Player":
		cutZone = false
		
func _on_serpiente_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)
		
func _on_ventilador_on_body_entered(body):
	if body.name == "Player":
		if ventilador1anim.is_playing():
			life.damage(100)
		elif ventilador2anim.is_playing():
			life.damage(100)
		elif ventilador3anim.is_playing():
			life.damage(100)


