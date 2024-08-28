extends Node2D

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2() 

#mariposas
@onready var mariposa1 = $mariposa/AnimationPlayer
@onready var mariposa2 = $mariposa2/AnimationPlayer

#enemigos
@onready var araña1 = $"EnemigoAraña"
@onready var serpiente1 = $enemigoSerpiente
@onready var puerco1 = $enemigoPuerco
@onready var mono1 = $enemigoMono
@onready var hipopotamo1 = $hipopotamo
@onready var serpiente2 = $enemigoSerpiente2
@onready var murcielago1 = $murcielago
@onready var araña2 = $"EnemigoAraña2"
@onready var hipopotamo2 = $hipopotamo2

#bolaPinchos
@onready var bolaPinchos1 = $bolaPinchoPecharuntVertical
@onready var bolaPinchos2 = $bolaPinchoPecharuntVertical2
@onready var bolaPinchos3 = $bolaPinchosHorizontal

#ventiladores
@onready var ventilador1 = $ventiladoresMortales
@onready var ventilador1Anim = $ventiladoresMortales/AnimationPlayer
@onready var ventilador2 = $ventiladoresMortales2
@onready var ventilador2Anim = $ventiladoresMortales2/AnimationPlayer

#bloquesAmarillos
@onready var bloqueAmarillo1 = $bloqueAmarilloCaidaRapida/zonaMuerte
@onready var bloqueAmarillo2 = $bloqueAmarilloCaidaRapida2/zonaMuerte
@onready var bloqueAmarillo3 = $bloqueAmarilloCaidaRapida3/zonaMuerte
@onready var bloqueAmarillo4 = $bloqueAmarilloCaidaRapida4/zonaMuerte

#colision de suelo con el bloque amarillo
@onready var areaSueloBloqueAmarillo = $areaSueloColisionBloqueAmarillo

#bloquesGrises
@onready var bloqueGris1 = $bloqueCaidaGris/areaMuerte
@onready var bloqueGris2 = $bloqueCaidaGris2/areaMuerte

#colision de suelo con el bloque gris
@onready var areaSueloBloqueGris = $areaSueloColisionBloqueGris

#boolenas para verificar si el personaje es o no es aplastado por los bloques
var insideZonaColisionSueloAmarillo = false
var insideZonaColisionBloqueAmarillo = false
var insideZonaColisionSueloGris = false
var insideZonaColisionBloqueGris = false

#zona de las estacas
@onready var estacas = $areaEstacas


#comida
@onready var señalKnaranja = $"naranjaRecuperaVida/señalComerK"
@onready var señalXnaranja = $"naranjaRecuperaVida/señalComerX"
@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX
@onready var señalKPlatano = $platano_recupera_vida/BananaKeyboardK
@onready var señalxPlatano = $platano_recupera_vida/BananaKeyboardX

#lianas1
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

#lianas2
@onready var señalAgarre2 = $lianas2/agarrarse
@onready var zonaAreaAgarreLianas2 = $lianas2
@onready var colisiones2 = $lianas2/colisionesEnLiana
@onready var spriteLiana2 = $lianas2/SpritesLianas
@onready var marcaIzquierdaLiana2 = $lianas2/Marker2D
@onready var marcaDerechaLiana2 = $lianas2/Marker2D2
@onready var areaDerechaVine2 = $lianas2/areaDerechaLiana
@onready var señalAgarreDerecha2 = $lianas2/areaDerechaLiana/agarrarse
@onready var colisionLianaAgarreIzquierda2 = $lianas2/CollisionShape2D
@onready var colisionLianaAgarreDerecha2 = $lianas2/areaDerechaLiana/CollisionShape2D
@onready var zonaMarcaSaltoIzquierda2 = $lianas2/saltoIzquierda
@onready var zonaMarcaSaltoDerecha2 = $lianas2/saltoDerecha



#marcas liana1
@onready var marcaIzquierdaLianaParche = $marcaIzquierdaLiana
@onready var marcaDerechaLianaParche = $marcaDerechaLiana
@onready var zonaMarcaSaltoIzquierdaParche = $zonaSaltoIzquierda
@onready var zonaMarcaSaltoDerechaParche = $zonaSaltoDerecha

#marcas liana2
@onready var marcaIzquierdaLianaParche2 = $marcaIzquierdaLiana2
@onready var marcaDerechaLianaParche2 = $marcaDerechaLiana2
@onready var zonaMarcaSaltoIzquierdaParche2 = $zonaSaltoIzquierda2
@onready var zonaMarcaSaltoDerechaParche2 = $zonaSaltoDerecha2

#variables salto Lianas
var jumpFromVineY = 20
var jumpFromVineX = 30
var directionJumpFromVine = 1

#variables booleanas lianas 1
var inSideRightVine = false
var inSideLeftVine = false
var grabLine = false
var leftAreaVine = false
var rightAreaVine = false

#variables booleanas lianas 2
var inSideRightVine2 = false
var inSideLeftVine2 = false
var grabLine2 = false
var leftAreaVine2 = false
var rightAreaVine2 = false


func _ready():
#posicion del jugador
	initial_position = player.global_position
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		Global.player_position = Vector2()

#conexiones liana 1
	señalAgarre.visible = false
	señalAgarreDerecha.visible = false
	zonaAreaAgarreLianas.connect("body_entered", Callable(self, "on_señal_agarre_liana_on_body_entered"))
	zonaAreaAgarreLianas.connect("body_exited", Callable(self, "on_señal_agarre_liana_on_body_exited"))
	areaDerechaVine.connect("body_entered", Callable(self, "on_señal_agarre_liana_derecha_on_body_entered"))
	areaDerechaVine.connect("body_exited", Callable(self, "on_señal_agarre_liana_derecha_on_body_exited"))
	disableInitialColisions()

#conexiones liana 2
	señalAgarre2.visible = false
	señalAgarreDerecha2.visible = false
	zonaAreaAgarreLianas2.connect("body_entered", Callable(self, "on_señal_agarre2_liana_on_body_entered"))
	zonaAreaAgarreLianas2.connect("body_exited", Callable(self, "on_señal_agarre2_liana_on_body_exited"))
	areaDerechaVine2.connect("body_entered", Callable(self, "on_señal_agarre2_liana_derecha_on_body_entered"))
	areaDerechaVine2.connect("body_exited", Callable(self, "on_señal_agarre2_liana_derecha_on_body_exited"))
	disableInitialColisions2()

#conexiones quitan vida
	bolaPinchos1.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))
	bolaPinchos2.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))
	bolaPinchos3.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))

	ventilador1.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador2.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))

	hipopotamo1.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))
	hipopotamo2.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))
	murcielago1.connect("body_entered", Callable(self, "on_murcielago_on_body_entered"))
	serpiente1.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	serpiente2.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	puerco1.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	araña1.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	araña2.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	mono1.connect("body_entered", Callable(self, "_on_enemigo_mono_on_body_entered"))

#conexiones bloque
	bloqueAmarillo1.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo2.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo3.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo4.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))

	bloqueAmarillo1.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))
	bloqueAmarillo2.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))
	bloqueAmarillo3.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))
	bloqueAmarillo4.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))

	areaSueloBloqueAmarillo.connect("body_entered", Callable(self, "on_suelo_amarillo_on_body_entered"))
	areaSueloBloqueAmarillo.connect("body_exited", Callable(self, "on_suelo_amarillo_on_body_exited"))

	bloqueGris1.connect("body_entered", Callable(self, "on_bloque_gris_on_body_entered"))
	bloqueGris2.connect("body_entered", Callable(self, "on_bloque_gris_on_body_entered"))

	bloqueGris1.connect("body_exited", Callable(self, "on_bloque_gris_on_body_exited"))
	bloqueGris2.connect("body_exited", Callable(self, "on_bloque_gris_on_body_exited"))

	areaSueloBloqueGris.connect("body_entered", Callable(self, "on_suelo_gris_on_body_entered"))
	areaSueloBloqueGris.connect("body_exited", Callable(self, "on_suelo_gris_on_body_exited"))

#conexion estacas
	estacas.connect("body_entered", Callable(self, "_on_area_estacas_on_body_entered"))


#animacion de mariposas
	mariposa1.play("volandoAbajo")
	mariposa2.play("volandoArriba")


func _process(delta):
	if player.global_position.y > 500: 
		respawn_player()
	grabVine()
	moveLeftRightVine()
	grabVine2()
	moveLeftRightVine2()
	damageBloqueGris()
	damageBloqueAmarillo()

#funciones de la comida del jugador
	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKnaranja) and señalKnaranja.visible:
			life.heal(18)
			señalKnaranja.visible = false  
		elif is_instance_valid(señalXnaranja) and señalXnaranja.visible:
			life.heal(18)
			señalXnaranja.visible = false 

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKManzana) and señalKManzana.visible:
			life.heal(20)
			señalKManzana.visible = false  
		elif is_instance_valid(señalxManzana) and señalxManzana.visible:
			life.heal(20)
			señalxManzana.visible = false 

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKPlatano) and señalKPlatano.visible:
			life.heal(18)
			señalKPlatano.visible = false  
		elif is_instance_valid(señalxPlatano) and señalxPlatano.visible:
			life.heal(18)
			señalxPlatano.visible = false 

#funcion respawn del jugador
func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)

#funciones lianas 1
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

#funciones lianas 2
func on_señal_agarre2_liana_on_body_entered(body):
	if body.name == "Player":
		leftAreaVine2 = true
		señalAgarre2.visible = true

func on_señal_agarre2_liana_on_body_exited(body):
	if body.name == "Player":
		leftAreaVine2 = false
		señalAgarre2.visible = false


func on_señal_agarre2_liana_derecha_on_body_entered(body):
	if body.name == "Player":
		rightAreaVine2 = true
		señalAgarreDerecha2.visible = true

func on_señal_agarre2_liana_derecha_on_body_exited(body):
	if body.name == "Player":
		rightAreaVine2 = false
		señalAgarreDerecha2.visible = false

func grabVine2():
	if señalAgarre2.visible and leftAreaVine2 and Input.is_action_just_pressed("abrirLoQueSea"):
		player.rotation = 86.5
		player.global_position = marcaIzquierdaLianaParche2.position
		activateColisions2()
		inSideLeftVine2 = true
		inSideRightVine2 = false
		colisionLianaAgarreIzquierda2.disabled = true
		colisionLianaAgarreDerecha2.disabled = true
		
	if señalAgarreDerecha2.visible and rightAreaVine2 and Input.is_action_just_pressed("abrirLoQueSea"):
		player.global_position = marcaDerechaLianaParche2.position
		player.rotation = -86.5
		activateColisions2()
		inSideLeftVine2 = false
		inSideRightVine2 = true
		colisionLianaAgarreIzquierda2.disabled = true
		colisionLianaAgarreDerecha2.disabled = true

func moveLeftRightVine2():
	if inSideLeftVine2 and Input.is_action_pressed("caminar_izquierda") and Input.is_action_pressed("ui_accept"):
		disableInitialColisions2()
		player.position = zonaMarcaSaltoIzquierdaParche2.position
		player.rotation = 0
		jumpVineLeft2()
	if inSideLeftVine2 and Input.is_action_just_pressed("caminar_derecha"):
		player.global_position = marcaDerechaLianaParche2.position
		player.rotation = -86.5
		inSideLeftVine2 = false
		inSideRightVine2 = true


	if inSideRightVine2 and Input.is_action_pressed("caminar_derecha") and Input.is_action_pressed("ui_accept"):
		disableInitialColisions2()
		player.position = zonaMarcaSaltoDerechaParche2.position
		player.rotation = 0
		jumpVineRight2()
	if inSideRightVine2 and Input.is_action_just_pressed("caminar_izquierda"):
		player.global_position = marcaIzquierdaLianaParche2.position
		player.rotation = 86.5
		inSideLeftVine2 = true
		inSideRightVine2 = false

func disableInitialColisions2():
	for collision_shape in $lianas2/colisionesEnLiana.get_children():
		if collision_shape is CollisionShape2D:
			collision_shape.disabled = true

func activateColisions2():
	for collision_shape in $lianas2/colisionesEnLiana.get_children():
		if collision_shape is CollisionShape2D:
			collision_shape.disabled = false

func jumpVineLeft2():
	player.velocity.y -= jumpFromVineY
	player.velocity.x -= jumpFromVineX
	colisionLianaAgarreIzquierda2.disabled = false
	colisionLianaAgarreDerecha2.disabled = false
	inSideLeftVine2 = false
	inSideRightVine2 = false

func jumpVineRight2():
	player.velocity.y -= jumpFromVineY
	player.velocity.x += jumpFromVineX
	colisionLianaAgarreIzquierda2.disabled = false
	colisionLianaAgarreDerecha2.disabled = false
	inSideLeftVine2 = false
	inSideRightVine2 = false

#funciones de bolas de pinchos y ventiladores
func on_bola_pincho_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

func _on_ventilador_on_body_entered(body):
	if body.name == "Player":
		if ventilador1Anim.is_playing():
			life.damage(100)
		elif ventilador2Anim.is_playing():
			life.damage(100)

#funciones de los enemigos

func on_hipopotamo_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

func on_murcielago_on_body_entered(body):
	if body.name == "Player":
		life.damage(12)


func _on_serpiente_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)

func on_puerco_on_body_entered(body):
	if body.name == "Player":
		life.damage(20)

func _on_enemigo_araña_on_body_entered(body):
	if body.name == "Player":
		life.damage(8)

func _on_enemigo_mono_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)

#funciones de los bloques

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

func on_bloque_gris_on_body_entered(body):
	if body.name == "Player":
		insideZonaColisionBloqueGris = true

func on_bloque_gris_on_body_exited(body):
	if body.name == "Player":
		insideZonaColisionBloqueGris = false


func on_suelo_gris_on_body_entered(body):
	if body.name == "Player":
		insideZonaColisionSueloGris = true

func on_suelo_gris_on_body_exited(body):
	if body.name == "Player":
		insideZonaColisionSueloGris = false

func damageBloqueGris():
	if insideZonaColisionBloqueGris and insideZonaColisionSueloGris:
		animPlayer.play("aplastado")
		life.damage(100)
		insideZonaColisionSueloGris = false
		insideZonaColisionBloqueGris = false

func _on_area_estacas_on_body_entered(body):
	if body.name == "Player":
		life.damage(10)
