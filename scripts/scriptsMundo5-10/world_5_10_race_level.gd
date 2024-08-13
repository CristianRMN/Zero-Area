extends Node2D

@onready var player = $Player 
@onready var life = $CanvasLayer/vidaTerapagos/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer

@onready var ondu = $AmigoOndu
@onready var onduSprite = $AmigoOndu/TodosLosSpritesDeOndu
@onready var onduAnim = $AmigoOndu/AnimationPlayer

@onready var areaInicioHablar = $conversacionOnduInicio
@onready var señalHablar = $conversacionOnduInicio/habla
@onready var conversacionShape = $conversacionOnduInicio/CollisionShape2D

@onready var startRaceAreaInicio = $inicio/areaInicio
@onready var startRaceColisionMeta = $inicio/CollisionShape2D
@onready var startAreaInicioSeñal = $inicio/areaInicio/start
@onready var startAreaInicioShape = $inicio/areaInicio/CollisionShape2D

@onready var nomoverseHastaStart = $notMove/CollisionShape2D

@onready var fuegos1 = $fuegosArtificialesCarrera
@onready var fuegos1Anim = $fuegosArtificialesCarrera/AnimationPlayer
@onready var fuegos2 = $fuegosArtificialesCarrera2
@onready var fuegos2Anim = $fuegosArtificialesCarrera2/AnimationPlayer

@onready var countDownNumbers = $countDownRace/CountdownRace
@onready var countDownAnim = $countDownRace/AnimationPlayer

@onready var finDeLosFuegos = $finFuegos

@onready var zonaDeSaltosOndu = $zonaSaltos
@onready var zonadeCorrerOndu = $zonaCorrer

@onready var zonadeIdleOndu = $zonaIdle
@onready var zonaDeEspera = $zonaEspera
@onready var zonaJump = $zonaJump

@onready var zonaIdleHojas = $zonaIdleHoja
@onready var zonaJumpdesdeHoja = $zonaJumpdesdeHoja

@onready var esperaBloqueAmarillo = $esperaBloqueAmarilloOndu
@onready var wairOrRunAmarillo = $waitOrRunBloqueAmarillo

@onready var correNormalDespuesDeBloque = $correNormaldespuesDeBloques

@onready var esperaBloqueGris = $waitBloqueGris
@onready var correGris = $correBloqueGris

var runnersInPosition = false
var notSpeakWithOndu = false



#variables de ondu
var speed
var jump = 200
const gravity = 9

var direction = 1

#variables de los fuegos
var posicionFuegos = 190
var lanzaFuegos = false
var direction_lanza_fuegos = -1
var explota = false
var animations_finished = 0


#variables de cuenta atras
var startCountdown = false
var finishCountdown = false
var startCount = false

#variables de espera en hojas de ondu
var insideArea = false
var hojaEnPosicion = false

#variables de espera en bloque amarillos
var bloqueEnMuerte = false
var insideAreaBloqueAmarillo = false

#variables de los bloques gris
var bloqueGrisMuerte = false
var insideAreaBloqueGris = false


var up = -10

var is_near_escalera = false

var initial_position = Vector2()  # Variable para almacenar la posición inicial

func _ready():
	Global.level1_10 = true
	Global.giveValueSpeedOndu()
	# Guardar la posición inicial del jugador
	initial_position = player.global_position
	
	nomoverseHastaStart.disabled = true
	
	positionInitOndu()

	areaInicioHablar.connect("body_entered", Callable(self, "_on_conversa_on_body_entered"))
	areaInicioHablar.connect("body_exited", Callable(self, "_on_conversa_on_body_exited"))
	señalHablar.visible = false
	
	startRaceAreaInicio.connect("body_entered", Callable(self, "_on_inicio_carrera_on_body_entered"))
	startRaceAreaInicio.connect("body_exited", Callable(self, "_on_inicio_carrera_on_body_exited"))
	startAreaInicioSeñal.visible = false
	
	finDeLosFuegos.connect("body_entered", Callable(self, "_on_fuegos_on_body_entered"))
	fuegos1Anim.connect("animation_finished", Callable(self, "_on_fuegos_animation_finished"))
	fuegos2Anim.connect("animation_finished", Callable(self, "_on_fuegos_animation_finished"))
	
	countDownAnim.connect("animation_finished", Callable(self, "on_cuentaAtras_animation_finished"))
	
	zonaDeSaltosOndu.connect("body_entered", Callable(self, "on_saltos_ondu_on_body_entered"))
	zonadeCorrerOndu.connect("body_entered", Callable(self, "on_correr_ondu_on_body_entered"))
	
	zonaDeEspera.connect("body_entered", Callable(self, "on_zona_espera_on_body_entered"))
	zonaDeEspera.connect("body_exited", Callable(self, "on_zona_espera_on_body_exited"))
	
	zonadeIdleOndu.connect("body_entered", Callable(self, "on_zona_idle_objeto_on_body_entered"))
	zonadeIdleOndu.connect("body_exited", Callable(self, "on_zona_idle_objeto_on_body_exited"))
	
	zonaJump.connect("body_entered", Callable(self, "on_hoja_posicion_on_body_entered"))
	zonaJump.connect("body_exited", Callable(self, "on_hoja_posicion_on_body_exited"))
	
	zonaIdleHojas.connect("body_entered", Callable(self, "on_zona_idle_hoja_subida_on_body_entered"))
	zonaJumpdesdeHoja.connect("body_entered", Callable(self, "on_zona_jump_desde_hoja_on_body_entered"))
	
	esperaBloqueAmarillo.connect("body_entered", Callable(self, "on_espera_bloque_amarillo_on_body_entered"))
	esperaBloqueAmarillo.connect("body_exited", Callable(self, "on_espera_bloque_amarillo_on_body_exited"))
	
	wairOrRunAmarillo.connect("body_entered", Callable(self, "on_wait_or_run_amarillo_on_body_entered"))
	wairOrRunAmarillo.connect("body_exited", Callable(self, "on_wait_or_run_amarillo_on_body_exited"))
	
	esperaBloqueGris.connect("body_entered", Callable(self, "on_espera_bloque_gris_on_body_entered"))
	esperaBloqueGris.connect("body_exited", Callable(self, "on_espera_bloque_gris_on_body_exited"))
	
	correGris.connect("body_entered", Callable(self, "on_corre_gris_on_body_entered"))
	correGris.connect("body_exited", Callable(self, "on_corre_gris_on_body_exited"))



	
	correNormalDespuesDeBloque.connect("body_entered", Callable(self, "on_corre_normal_on_body_entered"))

	

	
	countDownNumbers.visible = false






	# Restaurar la posición del jugador si se ha almacenado una posición
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		# Resetea la posición para que no interfiera con futuros cambios de escena
		Global.player_position = Vector2()


func positionInitOndu():
	onduSprite.flip_h = true
	onduAnim.play("waitRace")
	
func _on_conversa_on_body_entered(body):
	if body.name == "Player":
		señalHablar.visible = true
		
func _on_conversa_on_body_exited(body):
	if body.name == "Player":
		señalHablar.visible = false
		
func in_starting_position():
	if (señalHablar.visible) and Input.is_action_just_pressed("abrirLoQueSea"):
		onduSprite.flip_h = false
		onduAnim.play("run")
		señalHablar.hide()
		conversacionShape.disabled = true
		notSpeakWithOndu = true

func _on_inicio_carrera_on_body_entered(body):
	if body.name == "Player":
		startAreaInicioSeñal.visible = true
	
	if body.name == "AmigoOndu":
		onduAnim.play("idle")
	runnersInPosition = true
	
func _on_inicio_carrera_on_body_exited(body):
	if body.name == "Player":
		startAreaInicioSeñal.visible = false
		
		
		
		
func AnimationCountDown():
	if startCountdown:
		startAreaInicioSeñal.visible = false
		
		countDownAnim.play("cuentaAtras")
		startCountdown = false
		
func on_cuentaAtras_animation_finished(anim_name):
	countDownNumbers.visible = false
	lanzaFuegos = true


	

func _on_fuegos_on_body_entered(body):
	if body.name == "fuegosArtificialesCarrera":
		explota = true



func AnimationFuegos():
	if explota:
		if explota:
			fuegos1Anim.play("fuegos")
			fuegos2Anim.play("fuegos")
			explota = false  # Evita que la animación se reproduzca más de una vez



func _on_fuegos_animation_finished(anim_name):
	animations_finished += 1
	if animations_finished >= 2:  # Espera a que ambas animaciones terminen
		fuegos1.hide()
		fuegos2.hide()
		animations_finished = 0  # Reinicia el contador para la próxima vez
		startRaceColisionMeta.disabled = true
		nomoverseHastaStart.disabled = true
		startAreaInicioShape.disabled = true
		onduRun()


func startRace():
	if (startAreaInicioSeñal.visible) and runnersInPosition and notSpeakWithOndu and Input.is_action_just_pressed("abrirLoQueSea"):
		nomoverseHastaStart.disabled = false
		countDownNumbers.visible = true
		startCountdown = true
		if finishCountdown:
			lanzaFuegos = true
		

func on_saltos_ondu_on_body_entered(body):
	if body.name == "AmigoOndu":
		onduJump()
		
func on_correr_ondu_on_body_entered(body):
	if body.name == "AmigoOndu":
		onduRun()
		


func onduRun():
	onduAnim.play("run")
	
func onduJump():
	onduAnim.play("jump")

func onduIdle():
	onduAnim.play("idle")
	
func onduJumpToObject():
	onduAnim.play("jumpToObject")
	
func on_zona_espera_on_body_entered(body):
	if body.name == "AmigoOndu":
		insideArea = true


func on_zona_espera_on_body_exited(body):
	if body.name == "AmigoOndu":
		insideArea = false


func jumpOrIdleOndu():
	if insideArea and hojaEnPosicion == false:
		onduIdle()
	if insideArea and hojaEnPosicion:
		onduJumpToObject()
		

func on_hoja_posicion_on_body_entered(body):
	if body.name == "hojaHaciaAbajo":
		hojaEnPosicion = true



func on_hoja_posicion_on_body_exited(body):
	if body.name == "hojaHaciaAbajo":
		hojaEnPosicion = false

func on_zona_idle_hoja_subida_on_body_entered(body):
	if body.name == "AmigoOndu":
		onduIdle()
		
func on_zona_jump_desde_hoja_on_body_entered(body):
	if body.name == "AmigoOndu":
		onduJumpToObject()
		
func on_espera_bloque_amarillo_on_body_entered(body):
	if body.name == "bloqueAmarilloCaidaRapida":
		bloqueEnMuerte = true
		
		
func on_espera_bloque_amarillo_on_body_exited(body):
	if body.name == "bloqueAmarilloCaidaRapida":
		bloqueEnMuerte = false
		
		
func on_wait_or_run_amarillo_on_body_entered(body):
	if body.name == "AmigoOndu":
		insideAreaBloqueAmarillo = true

		
		
func on_wait_or_run_amarillo_on_body_exited(body):
	if body.name == "AmigoOndu":
		insideAreaBloqueAmarillo = false
		
func on_espera_bloque_gris_on_body_entered(body):
	if body.name == "bloqueCaidaGris":
		bloqueGrisMuerte = true
		print("entrebloquegris")

func on_espera_bloque_gris_on_body_exited(body):
	if body.name == "bloqueCaidaGris":
		bloqueGrisMuerte = false
		print("salibloquegris")
		
func on_corre_gris_on_body_entered(body):
	if body.name == "AmigoOndu":
		insideAreaBloqueGris = true
		print("Entre en area gris ondu")

func on_corre_gris_on_body_exited(body):
	if body.name == "AmigoOndu":
		insideAreaBloqueGris = false
		print("sali en area gris ondu")

		
func runBlocks():
	if insideAreaBloqueAmarillo and bloqueEnMuerte:
		onduIdle()
	if insideAreaBloqueAmarillo and bloqueEnMuerte == false:
		Global.sprint = true
		Global.level1_10 = false
		Global.giveValueSpeedOndu()
		onduRun()
	
	
func runBlocksGray():
	if insideAreaBloqueGris and bloqueGrisMuerte:
		onduIdle()
	if insideAreaBloqueGris and bloqueGrisMuerte == false:
		Global.level91_100 = true
		Global.level1_10 = false
		Global.giveValueSpeedOndu()
		onduRun()
	

func on_corre_normal_on_body_entered(body):
	if body.name == "AmigoOndu":
		Global.level1_10 = true
		Global.level91_100 = false
		Global.sprint = false
		Global.giveValueSpeedOndu()
		onduRun()




func _physics_process(delta):
	# Verificar si el jugador ha caído por debajo de un umbral
	if player.global_position.y > 500: 
		respawn_player()
		
	in_starting_position()
	AnimationCountDown()
	if lanzaFuegos:
		fuegos1.position.y += direction_lanza_fuegos * posicionFuegos * delta
		fuegos2.position.y += direction_lanza_fuegos * posicionFuegos * delta
	AnimationFuegos()
	
	startRace()
	jumpOrIdleOndu()
	runBlocks()
	runBlocksGray()

func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)
	


