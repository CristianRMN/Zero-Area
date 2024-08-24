extends Node2D

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2() 

#lianas
@onready var señalAgarre = $lianas/agarrarse
@onready var zonaAreaAgarreLianas = $lianas
@onready var colisiones = $lianas/colisionesEnLiana
@onready var spriteLiana = $lianas/SpritesLianas
@onready var marcaIzquierdaLiana = $lianas/Marker2D
@onready var marcaDerechaLiana = $lianas/Marker2D2
@onready var areaDerechaVine = $lianas/areaDerechaLiana
@onready var señalAgarreDerecha = $lianas/areaDerechaLiana/agarrarse
@onready var colisionLianaAgarreIzquierda = $lianas/CollisionShape2D
@onready var colisionLianaAgarreDerecha = $lianas/areaDerechaLiana/CollisionShape2D
@onready var zonaMarcaSaltoIzquierda = $lianas/saltoIzquierda
@onready var zonaMarcaSaltoDerecha = $lianas/saltoDerecha

#ventiladores
@onready var ventilador1 = $ventiladoresMortales
@onready var ventilador1Anim = $ventiladoresMortales/AnimationPlayer
@onready var ventilador2 = $ventiladoresMortales2
@onready var ventilador2Anim = $ventiladoresMortales2/AnimationPlayer

#bloqueAmarillo
@onready var bloqueAmarillo1 = $bloqueAmarilloCaidaRapida/zonaMuerte
@onready var bloqueAmarillo2 = $bloqueAmarilloCaidaRapida2/zonaMuerte
@onready var zonaColisionSueloBloqueAmarillo = $zonaColisionBloqueAmarillo
var insideZonaColisionSueloAmarillo = false
var insideZonaColisionBloqueAmarillo = false

#enemigos
@onready var serpiente1 = $enemigoSerpiente
@onready var puerco1 = $enemigoPuerco
@onready var hipopotamo = $hipopotamo

#comida
@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX
@onready var señalKnaranja = $"naranjaRecuperaVida/señalComerK"
@onready var señalXnaranja = $"naranjaRecuperaVida/señalComerX"



var jumpFromVineY = 20
var jumpFromVineX = 30
var directionJumpFromVine = 1



var inSideRightVine = false
var inSideLeftVine = false
var grabLine = false
var leftAreaVine = false
var rightAreaVine = false

@onready var mariposa1 = $mariposa/AnimationPlayer
@onready var mariposa2 = $mariposa2/AnimationPlayer

func _ready():
	initial_position = player.global_position
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		Global.player_position = Vector2()

	mariposa1.play("volandoArriba")
	mariposa2.play("volandoArriba")

	señalAgarre.visible = false
	señalAgarreDerecha.visible = false
	zonaAreaAgarreLianas.connect("body_entered", Callable(self, "on_señal_agarre_liana_on_body_entered"))
	zonaAreaAgarreLianas.connect("body_exited", Callable(self, "on_señal_agarre_liana_on_body_exited"))
	areaDerechaVine.connect("body_entered", Callable(self, "on_señal_agarre_liana_derecha_on_body_entered"))
	areaDerechaVine.connect("body_exited", Callable(self, "on_señal_agarre_liana_derecha_on_body_exited"))
	disableInitialColisions()

	ventilador1.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador2.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))

	bloqueAmarillo1.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo2.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))

	bloqueAmarillo1.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))
	bloqueAmarillo2.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))

	zonaColisionSueloBloqueAmarillo.connect("body_entered", Callable(self, "on_suelo_amarillo_on_body_entered"))
	zonaColisionSueloBloqueAmarillo.connect("body_exited", Callable(self, "on_suelo_amarillo_on_body_exited"))

	serpiente1.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	puerco1.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	hipopotamo.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))


func _process(delta):
	if player.global_position.y > 500: 
		respawn_player()
	grabVine()
	moveLeftRightVine()
	damageBloqueAmarillo()

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKManzana) and señalKManzana.visible:
			life.heal(20)
			señalKManzana.visible = false  
		elif is_instance_valid(señalxManzana) and señalxManzana.visible:
			life.heal(20)
			señalxManzana.visible = false 

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKnaranja) and señalKnaranja.visible:
			life.heal(18)
			señalKnaranja.visible = false  
		elif is_instance_valid(señalXnaranja) and señalXnaranja.visible:
			life.heal(18)
			señalXnaranja.visible = false 


func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)

func on_señal_agarre_liana_on_body_entered(body):
	if body.name == "Player":
		leftAreaVine = true
		señalAgarre.visible = true

func on_señal_agarre_liana_on_body_exited(body):
	if body.name == "Player":
		leftAreaVine = false
		señalAgarre.visible = false


func on_señal_agarre_liana_derecha_on_body_entered(body):
	if body.name == "Player":
		rightAreaVine = true
		señalAgarreDerecha.visible = true

func on_señal_agarre_liana_derecha_on_body_exited(body):
	if body.name == "Player":
		rightAreaVine = false
		señalAgarreDerecha.visible = false

func grabVine():
	if señalAgarre.visible and leftAreaVine and Input.is_action_just_pressed("abrirLoQueSea"):
		player.rotation = 86.5
		player.global_position = marcaIzquierdaLiana.position
		activateColisions()
		inSideLeftVine = true
		inSideRightVine = false
		colisionLianaAgarreIzquierda.disabled = true
		colisionLianaAgarreDerecha.disabled = true
		
	if señalAgarreDerecha.visible and rightAreaVine and Input.is_action_just_pressed("abrirLoQueSea"):
		player.global_position = marcaDerechaLiana.position
		player.rotation = -86.5
		activateColisions()
		inSideLeftVine = false
		inSideRightVine = true
		colisionLianaAgarreIzquierda.disabled = true
		colisionLianaAgarreDerecha.disabled = true

func moveLeftRightVine():
	if inSideLeftVine and Input.is_action_pressed("caminar_izquierda") and Input.is_action_pressed("ui_accept"):
		disableInitialColisions()
		player.position = zonaMarcaSaltoIzquierda.position
		player.rotation = 0
		jumpVineLeft()
	if inSideLeftVine and Input.is_action_just_pressed("caminar_derecha"):
		player.global_position = marcaDerechaLiana.position
		player.rotation = -86.5
		inSideLeftVine = false
		inSideRightVine = true


	if inSideRightVine and Input.is_action_pressed("caminar_derecha") and Input.is_action_pressed("ui_accept"):
		disableInitialColisions()
		player.position = zonaMarcaSaltoDerecha.position
		player.rotation = 0
		jumpVineRight()
	if inSideRightVine and Input.is_action_just_pressed("caminar_izquierda"):
		player.global_position = marcaIzquierdaLiana.position
		player.rotation = 86.5
		inSideLeftVine = true
		inSideRightVine = false

func disableInitialColisions():
	for collision_shape in $lianas/colisionesEnLiana.get_children():
		if collision_shape is CollisionShape2D:
			collision_shape.disabled = true

func activateColisions():
	for collision_shape in $lianas/colisionesEnLiana.get_children():
		if collision_shape is CollisionShape2D:
			collision_shape.disabled = false

func jumpVineLeft():
	player.velocity.y -= jumpFromVineY
	player.velocity.x -= jumpFromVineX
	colisionLianaAgarreIzquierda.disabled = false
	colisionLianaAgarreDerecha.disabled = false
	inSideLeftVine = false
	inSideRightVine = false

func jumpVineRight():
	player.velocity.y -= jumpFromVineY
	player.velocity.x += jumpFromVineX
	colisionLianaAgarreIzquierda.disabled = false
	colisionLianaAgarreDerecha.disabled = false
	inSideLeftVine = false
	inSideRightVine = false

func _on_ventilador_on_body_entered(body):
	if body.name == "Player":
		if ventilador1Anim.is_playing():
			life.damage(100)
		elif ventilador2Anim.is_playing():
			life.damage(100)

func on_bloque_amarillo_on_body_entered(body):
	if body.name == "Player":
		insideZonaColisionBloqueAmarillo = true

func on_bloque_amarillo_on_body_exited(body):
	if body.name == "Player":
		insideZonaColisionBloqueAmarillo = false


func on_suelo_amarillo_on_body_entered(body):
	if body.name == "Player":
		insideZonaColisionSueloAmarillo = true

func on_suelo_amarillo_on_body_exited(body):
	if body.name == "Player":
		insideZonaColisionSueloAmarillo = false

func damageBloqueAmarillo():
	if insideZonaColisionBloqueAmarillo and insideZonaColisionSueloAmarillo:
		animPlayer.play("aplastado")
		life.damage(50)
		insideZonaColisionSueloAmarillo = false
		insideZonaColisionBloqueAmarillo = false

func _on_serpiente_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)

func on_puerco_on_body_entered(body):
	if body.name == "Player":
		life.damage(20)

func on_hipopotamo_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)
