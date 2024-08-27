extends Node2D

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2() 

#variables del bloque
@onready var bloque = $bloqueMover
@onready var areaEmpuje = $bloqueMover/zonaEmpuje
@onready var señalEmpuje = $"bloqueMover/zonaEmpuje/señalEmpuja"
@onready var areaFueraEmpuje = $"desconexionSeñalesBloqueCaida"
@onready var zonaEmpujeCayoSeñal = $"bloqueMover/zonaEmpujeCaida/señalEmpuja"
@onready var zonaEmpujeCayo = $bloqueMover/zonaEmpujeCaida
@onready var colisionZonaEmpuje1 = $bloqueMover/zonaEmpuje/CollisionShape2D
@onready var mariposa1 = $mariposa/AnimationPlayer

#comida
@onready var señalKPlatano = $platano_recupera_vida/BananaKeyboardK
@onready var señalxPlatano = $platano_recupera_vida/BananaKeyboardX

#enemigo
@onready var hipopotamo = $hipopotamo
@onready var murcielago1 = $murcielago

#bloqueAmarillo
@onready var bloqueAmarillo1 = $bloqueAmarilloCaidaRapida/zonaMuerte
@onready var bloqueAmarillo2 = $bloqueAmarilloCaidaRapida2/zonaMuerte
@onready var zonaColisionSueloBloqueAmarillo = $zonaColisionSueloBloqueAmarillo
var insideZonaColisionSueloAmarillo = false
var insideZonaColisionBloqueAmarillo = false

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
@onready var marcaIzquierdaLianaParche = $marcaIzquierdaLianaParche
@onready var marcaDerechaLianaParche = $marcaDerechaLianaParche
@onready var zonaMarcaSaltoIzquierdaParche = $saltoIzquierdaLianaParche
@onready var zonaMarcaSaltoDerechaParche = $saltoDerechaLianaParche

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


var speed = 15
var elBloqueCayo = false

func _ready():
#respawn del jugador
	initial_position = player.global_position
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		Global.player_position = Vector2()
	
	#conexioneslianas
	señalAgarre.visible = false
	señalAgarreDerecha.visible = false
	zonaAreaAgarreLianas.connect("body_entered", Callable(self, "on_señal_agarre_liana_on_body_entered"))
	zonaAreaAgarreLianas.connect("body_exited", Callable(self, "on_señal_agarre_liana_on_body_exited"))
	areaDerechaVine.connect("body_entered", Callable(self, "on_señal_agarre_liana_derecha_on_body_entered"))
	areaDerechaVine.connect("body_exited", Callable(self, "on_señal_agarre_liana_derecha_on_body_exited"))
	disableInitialColisions()

	#conexiones del bloque para empujar
	señalEmpuje.visible = false
	zonaEmpujeCayoSeñal.visible = false
	areaEmpuje.connect("body_entered", Callable(self, "_on_body_entered"))
	areaEmpuje.connect("body_exited", Callable(self, "_on_body_exited"))
	areaFueraEmpuje.connect("body_entered", Callable(self, "_on_area_cayo_on_body_entered"))
	
	zonaEmpujeCayo.connect("body_entered", Callable(self, "_on_zona_empuje_caida_on_body_entered"))
	zonaEmpujeCayo.connect("body_exited", Callable(self, "_on_zona_empuje_caida_on_body_exited"))

#conexiones bloqueAmarillo
	bloqueAmarillo1.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo2.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))

	bloqueAmarillo1.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))
	bloqueAmarillo2.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))

	zonaColisionSueloBloqueAmarillo.connect("body_entered", Callable(self, "on_suelo_amarillo_on_body_entered"))
	zonaColisionSueloBloqueAmarillo.connect("body_exited", Callable(self, "on_suelo_amarillo_on_body_exited"))

#conexionesEnemigos
	hipopotamo.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))
	murcielago1.connect("body_entered", Callable(self, "on_murcielago_on_body_entered"))

#mariposas
	mariposa1.play("volandoRectoIzquierda")

	


func _on_body_entered(body):
	if body.name == "Player" and elBloqueCayo == false:
		señalEmpuje.visible = true
		
func _on_body_exited(body):
	if body.name == "Player" and elBloqueCayo == false:
		señalEmpuje.visible = false

func _on_area_cayo_on_body_entered(body):
	if body.name == "bloqueMover":
		print("Estoy dentro")
		señalEmpuje.visible = false
		elBloqueCayo = true
		colisionZonaEmpuje1.disabled = true

func _on_zona_empuje_caida_on_body_entered(body):
	if body.name == "Player" and elBloqueCayo:
		zonaEmpujeCayoSeñal.visible = true
		
func _on_zona_empuje_caida_on_body_exited(body):
	if body.name == "Player" and elBloqueCayo:
		zonaEmpujeCayoSeñal.visible = false

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


func on_hipopotamo_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

func on_murcielago_on_body_entered(body):
	if body.name == "Player":
		life.damage(12)

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

func _physics_process(delta):
	if señalEmpuje.visible and Input.is_action_pressed("abrirLoQueSea"):
		bloque.position.x += speed * delta
	if player.global_position.y > 500: 
		respawn_player()
	grabVine()
	moveLeftRightVine()
	damageBloqueAmarillo()

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKPlatano) and señalKPlatano.visible:
			life.heal(18)
			señalKPlatano.visible = false  
		elif is_instance_valid(señalxPlatano) and señalxPlatano.visible:
			life.heal(18)
			señalxPlatano.visible = false 

	if zonaEmpujeCayoSeñal.visible and Input.is_action_pressed("abrirLoQueSea"):
		bloque.position.x += speed * delta
