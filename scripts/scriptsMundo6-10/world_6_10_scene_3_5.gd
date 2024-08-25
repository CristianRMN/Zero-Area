extends Node2D

@onready var mariposa1 = $mariposa/AnimationPlayer

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

#marcas liana
@onready var marcaIzquierdaLianaParche = $marcaIzquierdaLiana
@onready var marcaDerechaLianaParche = $marcaDerechaLiana
@onready var zonaMarcaSaltoIzquierdaParche = $zonaSaltoIzquierda
@onready var zonaMarcaSaltoDerechaParche = $zonaSaltoDerecha


@onready var bolaPincho1 = $bolaPinchoPecharuntVertical
@onready var bolaPincho2 = $bolaPinchoPecharuntVertical2

@onready var puerco1 = $enemigoPuerco
@onready var hipopotamo = $hipopotamo
@onready var murcielago1 = $murcielago

@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX
@onready var señalKPlatano = $platano_recupera_vida/BananaKeyboardK
@onready var señalxPlatano = $platano_recupera_vida/BananaKeyboardX

#variables salto Lianas
var jumpFromVineY = 20
var jumpFromVineX = 30
var directionJumpFromVine = 1

#variables booleanas lianas
var inSideRightVine = false
var inSideLeftVine = false
var grabLine = false
var leftAreaVine = false
var rightAreaVine = false


func _ready():
	initial_position = player.global_position
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		Global.player_position = Vector2()

	mariposa1.play("volandoDiagonalSuperiorIzquierda")
	señalAgarre.visible = false
	señalAgarreDerecha.visible = false
	zonaAreaAgarreLianas.connect("body_entered", Callable(self, "on_señal_agarre_liana_on_body_entered"))
	zonaAreaAgarreLianas.connect("body_exited", Callable(self, "on_señal_agarre_liana_on_body_exited"))
	areaDerechaVine.connect("body_entered", Callable(self, "on_señal_agarre_liana_derecha_on_body_entered"))
	areaDerechaVine.connect("body_exited", Callable(self, "on_señal_agarre_liana_derecha_on_body_exited"))
	disableInitialColisions()

	bolaPincho1.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))
	bolaPincho2.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))

	puerco1.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	hipopotamo.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))
	murcielago1.connect("body_entered", Callable(self, "on_murcielago_on_body_entered"))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player.global_position.y > 500: 
		respawn_player()
	grabVine()
	moveLeftRightVine()

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKPlatano) and señalKPlatano.visible:
			life.heal(18)
			señalKPlatano.visible = false  
		elif is_instance_valid(señalxPlatano) and señalxPlatano.visible:
			life.heal(18)
			señalxPlatano.visible = false 

		if is_instance_valid(señalKManzana) and señalKManzana.visible:
			life.heal(20)
			señalKManzana.visible = false  
		elif is_instance_valid(señalxManzana) and señalxManzana.visible:
			life.heal(20)
			señalxManzana.visible = false 

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
		player.global_position = marcaIzquierdaLianaParche.position
		activateColisions()
		inSideLeftVine = true
		inSideRightVine = false
		colisionLianaAgarreIzquierda.disabled = true
		colisionLianaAgarreDerecha.disabled = true
		
	if señalAgarreDerecha.visible and rightAreaVine and Input.is_action_just_pressed("abrirLoQueSea"):
		player.global_position = marcaDerechaLianaParche.position
		player.rotation = -86.5
		activateColisions()
		inSideLeftVine = false
		inSideRightVine = true
		colisionLianaAgarreIzquierda.disabled = true
		colisionLianaAgarreDerecha.disabled = true

func moveLeftRightVine():
	if inSideLeftVine and Input.is_action_pressed("caminar_izquierda") and Input.is_action_pressed("ui_accept"):
		disableInitialColisions()
		player.position = zonaMarcaSaltoIzquierdaParche.position
		player.rotation = 0
		jumpVineLeft()
	if inSideLeftVine and Input.is_action_just_pressed("caminar_derecha"):
		player.global_position = marcaDerechaLianaParche.position
		player.rotation = -86.5
		inSideLeftVine = false
		inSideRightVine = true


	if inSideRightVine and Input.is_action_pressed("caminar_derecha") and Input.is_action_pressed("ui_accept"):
		disableInitialColisions()
		player.position = zonaMarcaSaltoDerechaParche.position
		player.rotation = 0
		jumpVineRight()
	if inSideRightVine and Input.is_action_just_pressed("caminar_izquierda"):
		player.global_position = marcaIzquierdaLianaParche.position
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

func on_bola_pincho_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

func on_puerco_on_body_entered(body):
	if body.name == "Player":
		life.damage(20)

func on_hipopotamo_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

func on_murcielago_on_body_entered(body):
	if body.name == "Player":
		life.damage(12)
