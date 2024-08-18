extends Node2D

#variables del protagonista
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer

#variables del corredor
@onready var ondu = $AmigoOndu
@onready var onduSprite = $AmigoOndu/TodosLosSpritesDeOndu
@onready var onduAnim = $AmigoOndu/AnimationPlayer

#variables de interaccion de carrera
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

@onready var zonaSuperSaltoOndu = $zonaSuperJumpsOndu

@onready var saltitosOndu = $zonaJumpObjects

@onready var zonaMegaJumps = $zonaMegaJump

@onready var zonaEsperaHojaHorizontal = $zonaEsperaOnduHojaHorizontal
@onready var zonaIdlehojaHorizontal = $zonaIdleHojaHorizontal
@onready var zonaJumpHojaHorizontal = $zonaJumpAHojaHorizontal
@onready var zonaJumpSitioSeguroDeHojaHorizontal = $zonaJumpaSitioSeguroDesdeHojaHorizontal
@onready var onduQuietoEnHohaHorizontal = $idleOnduEnLaHohaHorizontal


@onready var finCarrera = $finishRace/finCarrera
@onready var colisionFinalCarrera = $finishRace/CollisionShape2D
@onready var zonareposoOnduFinCarrera = $zonaInteraccionOnduFinalCarrera
@onready var zonaHablarOnduFinCarrera = $zonaInteraccionOnduFinalCarrera/hablaOnduFinalCarrera
@onready var zonaHablarConOnduFinCarreraProtagonista = $zonaInteraccionOnduFinalCarrera/zonaHablarConOnduFinalCarrera
@onready var zonaHablarConOnduFinCarreraProtagonistaColision = $zonaInteraccionOnduFinalCarrera/zonaHablarConOnduFinalCarrera/CollisionShape2D

@onready var lifePosition = $vidaTerapagos
@onready var camara = $Player/Camera2D

#variables de interaccion con la vida del prota
@onready var bloqueAmarillo1 = $bloqueAmarilloCaidaRapida/zonaMuerte
@onready var bloqueAmarillo2 = $bloqueAmarilloCaidaRapida2/zonaMuerte
@onready var bloqueAmarillo3 = $bloqueAmarilloCaidaRapida3/zonaMuerte
@onready var bloqueAmarillo4 = $bloqueAmarilloCaidaRapida4/zonaMuerte
@onready var bloqueAmarillo5 = $bloqueAmarilloCaidaRapida5/zonaMuerte
@onready var zonaColisionBloqueAmarilloProtagonista = $zonaColisionBloqueAmarillo

@onready var bloqueGris1 = $bloqueCaidaGris/areaMuerte
@onready var bloqueGris2 = $bloqueCaidaGris2/areaMuerte
@onready var bloqueGris3 = $bloqueCaidaGris3/areaMuerte
@onready var bloqueGris4 = $bloqueCaidaGris4/areaMuerte
@onready var zonaColisionBloqueGrisProtagonista = $zonaColisionBloqueGrisProtagonista

@onready var ventilador1 = $ventiladoresMortales
@onready var ventilador2 = $ventiladoresMortales2
@onready var ventilador3 = $ventiladoresMortales3
@onready var ventilador4 = $ventiladoresMortales4

@onready var ventilador1anim = $ventiladoresMortales/AnimationPlayer
@onready var ventilador2anim = $ventiladoresMortales2/AnimationPlayer
@onready var ventilador3anim = $ventiladoresMortales3/AnimationPlayer
@onready var ventilador4anim = $ventiladoresMortales4/AnimationPlayer


@onready var bloqueMovIzquierda = $bloqueMovimientoIzquierda/zonaMuerte
@onready var bloqueMovIzquierda2 = $bloqueMovimientoIzquierda2/zonaMuerte
@onready var bloqueMovIzquierda3 = $bloqueMovimientoIzquierda3/zonaMuerte
@onready var bloqueMovIzquierda4 = $bloqueMovimientoIzquierda4/zonaMuerte
@onready var bloqueMovIzquierda5 = $bloqueMovimientoIzquierda5/zonaMuerte

@onready var bloqueMovDerecha = $bloqueMovimientoDerechaEscena4/zonaMuerte
@onready var bloqueMovDerecha2 = $bloqueMovimientoDerechaEscena5/zonaMuerte
@onready var bloqueMovDerecha3 = $bloqueMovimientoDerechaEscena6/zonaMuerte
@onready var bloqueMovDerecha4 = $bloqueMovimientoDerechaEscena7/zonaMuerte
@onready var bloqueMovDerecha5 = $bloqueMovimientoDerechaEscena8/zonaMuerte

@onready var manzanaRecuperaTodaVidaSeñalK = $manzanaRecuperaTodaVida/pulsaK
@onready var manzanaRecuperaTodaVidaSeñalX = $manzanaRecuperaTodaVida/pulsaX

@onready var enemigoAraña1 = $"EnemigoAraña"
@onready var enemigoAraña2 = $"EnemigoAraña2"

@onready var bolaPinchos1 = $bolaPinchoPecharuntVertical
@onready var bolaPinchos2 = $bolaPinchoPecharuntVertical2
@onready var bolaPinchos3 = $bolaPinchoPecharuntVertical3
@onready var bolaPinchos4 = $bolaPinchoPecharuntVertical4

@onready var enemigoSerpiente1 = $enemigoSerpiente
@onready var enemigoSerpiente2 = $enemigoSerpiente2
@onready var enemigoSerpiente3 = $enemigoSerpiente3

@onready var enemigoMono = $enemigoMono

@onready var enemigoMurciealo1 = $murcielago

@onready var enemigoPuerco = $enemigoPuerco
@onready var enemigoPuerco2 = $enemigoPuerco2

@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX

@onready var señalKnaranja = $"naranjaRecuperaVida/señalComerK"
@onready var señalXnaranja = $"naranjaRecuperaVida/señalComerX"

var insideZonaColisionBloqueAmarilloProtagonista = false
var insideZonaMuerteBloqueAmarilloProtagonista = false

var insideZonaColisionBloqueGrisProtagonista = false
var insideZonaMuerteBloqueGrisProtagonista = false

var insideZonaMuerteBloqueMovIzquierda = false
var insideZonaMuerteBloqueMovDerecha = false

#variables inicioCarrera
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

#variables de espera en hojas horizontales de ondu
var insideAreaHorizontal = false
var hojaHorizontalEnPosicion = false


#variables para manejar al ganador de la carrera
var winnerPlayer = false
var winnerRival = false
var onduEnReposo = false


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
	
	zonaSuperSaltoOndu.connect("body_entered", Callable(self, "on_super_jump_on_body_entered"))
	saltitosOndu.connect("body_entered", Callable(self, "on_saltitos_on_body_entered"))
	zonaMegaJumps.connect("body_entered", Callable(self, "on_mega_jump_on_body_entered"))

	
	correNormalDespuesDeBloque.connect("body_entered", Callable(self, "on_corre_normal_on_body_entered"))
	
	zonaEsperaHojaHorizontal.connect("body_entered", Callable(self, "on_espera_hoja_horizontal_on_body_entered"))
	zonaEsperaHojaHorizontal.connect("body_exited", Callable(self, "on_espera_hoja_horizontal_on_body_exited"))
	
	zonaIdlehojaHorizontal.connect("body_entered", Callable(self, "on_zona_idle_hoja_horizontal_on_body_entered"))
	zonaIdlehojaHorizontal.connect("body_exited", Callable(self, "on_zona_idle_hoja_horizontal_on_body_exited"))

	zonaJumpHojaHorizontal.connect("body_entered", Callable(self, "on_zona_jump_a_hoja_horizontal_on_body_entered"))
	zonaJumpHojaHorizontal.connect("body_exited", Callable(self, "on_zona_jump_a_hoja_horizontal_on_body_exited"))

	zonaJumpSitioSeguroDeHojaHorizontal.connect("body_entered", Callable(self, "on_zona_jump_a_sitio_seguro_on_body_entered"))
	onduQuietoEnHohaHorizontal.connect("body_entered", Callable(self, "on_ondu_quieto_en_la_hoja_on_body_entered"))
	
	finCarrera.connect("body_entered", Callable(self, "on_ganador_carrera_on_body_entered"))
	
	zonareposoOnduFinCarrera.connect("body_entered", Callable(self, "on_reposo_ondu_on_body_entered"))
	
	zonaHablarConOnduFinCarreraProtagonista.connect("body_entered", Callable(self, "on_protagonista_habla_con_ondu_on_body_entered"))
	zonaHablarConOnduFinCarreraProtagonista.connect("body_exited", Callable(self, "on_protagonista_habla_con_ondu_on_body_exited"))
	
	bloqueAmarillo1.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo2.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo3.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo4.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))
	bloqueAmarillo5.connect("body_entered", Callable(self, "on_bloque_amarillo_on_body_entered"))

	bloqueAmarillo1.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))
	bloqueAmarillo2.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))
	bloqueAmarillo3.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))
	bloqueAmarillo4.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))
	bloqueAmarillo5.connect("body_exited", Callable(self, "on_bloque_amarillo_on_body_exited"))
	
	zonaColisionBloqueAmarilloProtagonista.connect("body_entered", Callable(self, "on_zona_colision_bloque_amarillo_protagonista_on_body_entered"))
	zonaColisionBloqueAmarilloProtagonista.connect("body_exited", Callable(self, "on_zona_colision_bloque_amarillo_protagonista_on_body_exited"))
	
	bloqueGris1.connect("body_entered", Callable(self, "on_bloque_gris_on_body_entered"))
	bloqueGris2.connect("body_entered", Callable(self, "on_bloque_gris_on_body_entered"))
	bloqueGris3.connect("body_entered", Callable(self, "on_bloque_gris_on_body_entered"))
	bloqueGris4.connect("body_entered", Callable(self, "on_bloque_gris_on_body_entered"))
	
	bloqueGris1.connect("body_exited", Callable(self, "on_bloque_gris_on_body_exited"))
	bloqueGris2.connect("body_exited", Callable(self, "on_bloque_gris_on_body_exited"))
	bloqueGris3.connect("body_exited", Callable(self, "on_bloque_gris_on_body_exited"))
	bloqueGris4.connect("body_exited", Callable(self, "on_bloque_gris_on_body_exited"))

	zonaColisionBloqueGrisProtagonista.connect("body_entered", Callable(self, "on_zona_colision_bloque_gris_protagonista_on_body_entered"))
	zonaColisionBloqueGrisProtagonista.connect("body_exited", Callable(self, "on_zona_colision_bloque_gris_protagonista_on_body_exited"))
	
	ventilador1.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador2.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador3.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador4.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))

	bloqueMovIzquierda.connect("body_entered", Callable(self, "_on_bloque_izquierda_on_body_entered"))
	bloqueMovIzquierda2.connect("body_entered", Callable(self, "_on_bloque_izquierda_on_body_entered"))
	bloqueMovIzquierda3.connect("body_entered", Callable(self, "_on_bloque_izquierda_on_body_entered"))
	bloqueMovIzquierda4.connect("body_entered", Callable(self, "_on_bloque_izquierda_on_body_entered"))
	bloqueMovIzquierda5.connect("body_entered", Callable(self, "_on_bloque_izquierda_on_body_entered"))

	bloqueMovIzquierda.connect("body_exited", Callable(self, "_on_bloque_izquierda_on_body_exited"))
	bloqueMovIzquierda2.connect("body_exited", Callable(self, "_on_bloque_izquierda_on_body_exited"))
	bloqueMovIzquierda3.connect("body_exited", Callable(self, "_on_bloque_izquierda_on_body_exited"))
	bloqueMovIzquierda4.connect("body_exited", Callable(self, "_on_bloque_izquierda_on_body_exited"))
	bloqueMovIzquierda5.connect("body_exited", Callable(self, "_on_bloque_izquierda_on_body_exited"))

	bloqueMovDerecha.connect("body_entered", Callable(self, "_on_bloque_derecha_on_body_entered"))
	bloqueMovDerecha2.connect("body_entered", Callable(self, "_on_bloque_derecha_on_body_entered"))
	bloqueMovDerecha3.connect("body_entered", Callable(self, "_on_bloque_derecha_on_body_entered"))
	bloqueMovDerecha4.connect("body_entered", Callable(self, "_on_bloque_derecha_on_body_entered"))
	bloqueMovDerecha5.connect("body_entered", Callable(self, "_on_bloque_derecha_on_body_entered"))

	bloqueMovDerecha.connect("body_exited", Callable(self, "_on_bloque_derecha_on_body_exited"))
	bloqueMovDerecha2.connect("body_exited", Callable(self, "_on_bloque_derecha_on_body_exited"))
	bloqueMovDerecha3.connect("body_exited", Callable(self, "_on_bloque_derecha_on_body_exited"))
	bloqueMovDerecha4.connect("body_exited", Callable(self, "_on_bloque_derecha_on_body_exited"))
	bloqueMovDerecha5.connect("body_exited", Callable(self, "_on_bloque_derecha_on_body_exited"))
	
	enemigoAraña1.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	enemigoAraña2.connect("body_entered", Callable(self, "_on_enemigo_araña_on_body_entered"))
	
	bolaPinchos1.connect("body_entered", Callable(self, "_on_bola_pinchos_on_body_entered"))
	bolaPinchos2.connect("body_entered", Callable(self, "_on_bola_pinchos_on_body_entered"))
	bolaPinchos3.connect("body_entered", Callable(self, "_on_bola_pinchos_on_body_entered"))
	bolaPinchos4.connect("body_entered", Callable(self, "_on_bola_pinchos_on_body_entered"))

	enemigoSerpiente1.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	enemigoSerpiente2.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	enemigoSerpiente3.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))

	enemigoMono.connect("body_entered", Callable(self, "_on_enemigo_mono_on_body_entered"))
	enemigoMurciealo1.connect("body_entered", Callable(self, "_on_enemigo_murcielago_on_body_entered"))
	
	enemigoPuerco.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	enemigoPuerco2.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	
	countDownNumbers.visible = false


	
	zonaHablarOnduFinCarrera.visible = false
	Global.keyHideRace = true



	# Restaurar la posición del jugador si se ha almacenado una posición
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		# Resetea la posición para que no interfiera con futuros cambios de escena
		Global.player_position = Vector2()

#funciones de la carrera

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
	
func OnduSuperJump():
	onduAnim.play("super_jump")
	
func onduJumpToObject():
	onduAnim.play("jumpToObject")
	
func onduMegaJump():
	onduAnim.play("mega_jump")
	
func onduDescanso():
	onduAnim.play("finishRace")
	
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


func on_espera_bloque_gris_on_body_exited(body):
	if body.name == "bloqueCaidaGris":
		bloqueGrisMuerte = false

		
func on_corre_gris_on_body_entered(body):
	if body.name == "AmigoOndu":
		insideAreaBloqueGris = true


func on_corre_gris_on_body_exited(body):
	if body.name == "AmigoOndu":
		insideAreaBloqueGris = false


		
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

func on_super_jump_on_body_entered(body):
	if body.name == "AmigoOndu":
		OnduSuperJump()
		
func on_saltitos_on_body_entered(body):
	if body.name == "AmigoOndu":
		onduJumpToObject()
		
func on_mega_jump_on_body_entered(body):
	if body.name == "AmigoOndu":
		onduMegaJump()
		
		
func on_espera_hoja_horizontal_on_body_entered(body):
	if body.name == "AmigoOndu":
		insideAreaHorizontal = true

func on_espera_hoja_horizontal_on_body_exited(body):
	if body.name == "AmigoOndu":
		insideAreaHorizontal = false
		
		
func on_zona_idle_hoja_horizontal_on_body_entered(body):
	if body.name == "hojaBosqueMovimientoHorizontal":
		hojaHorizontalEnPosicion = true
		

func on_zona_idle_hoja_horizontal_on_body_exited(body):
	if body.name == "hojaBosqueMovimientoHorizontal":
		hojaHorizontalEnPosicion = false
		
		
func jumpOrIdleOnduHojaHorizontal():
	if insideAreaHorizontal and hojaHorizontalEnPosicion == false:
		onduIdle()
	if insideAreaHorizontal and hojaHorizontalEnPosicion:
		onduJumpToObject()
		
func on_ondu_quieto_en_la_hoja_on_body_entered(body):
	if body.name == "AmigoOndu":
		onduIdle()

func on_zona_jump_a_sitio_seguro_on_body_entered(body):
	if body.name == "AmigoOndu":
		onduJump()
		

func on_ganador_carrera_on_body_entered(body):
	if body.name == "Player":
		if winnerRival == false:
			winnerPlayer = true

	
	if body.name == "AmigoOndu":
		if winnerPlayer == false:
			winnerRival = true

			
			
func on_reposo_ondu_on_body_entered(body):
	if body.name == "AmigoOndu":
		positionInitOndu()
		onduEnReposo = true

func on_protagonista_habla_con_ondu_on_body_entered(body):
	if body.name == "Player" and onduEnReposo:
		zonaHablarOnduFinCarrera.visible = true

func on_protagonista_habla_con_ondu_on_body_exited(body):
	if body.name == "Player" and onduEnReposo:
		zonaHablarOnduFinCarrera.visible = false


func presentFinishRaceOndu():
	if zonaHablarOnduFinCarrera and onduEnReposo and Input.is_action_just_pressed("abrirLoQueSea"):
		colisionFinalCarrera.disabled = true
		zonaHablarOnduFinCarrera.hide()
		zonaHablarConOnduFinCarreraProtagonistaColision.disabled = true
		if winnerPlayer:
			Global.keyHideRace = false
		if winnerRival:
			print("No hay nada mi rey, has perdido, quieres volver a jugar")

#funciones de interaccion con la vida del protagonista

func on_bloque_amarillo_on_body_entered(body):
	if body.name == "Player":
		insideZonaMuerteBloqueAmarilloProtagonista = true

func on_bloque_amarillo_on_body_exited(body):
	if body.name == "Player":
		insideZonaMuerteBloqueAmarilloProtagonista = false


func on_zona_colision_bloque_amarillo_protagonista_on_body_entered(body):
	if body.name == "Player":
		insideZonaColisionBloqueAmarilloProtagonista = true

func on_zona_colision_bloque_amarillo_protagonista_on_body_exited(body):
	if body.name == "Player":
		insideZonaColisionBloqueAmarilloProtagonista = false
		

func damageBloqueAmarillo():
	if insideZonaColisionBloqueAmarilloProtagonista and insideZonaMuerteBloqueAmarilloProtagonista:
		animPlayer.play("aplastado")
		life.damage(50)
		insideZonaColisionBloqueAmarilloProtagonista = false
		insideZonaMuerteBloqueAmarilloProtagonista = false

func on_zona_colision_bloque_gris_protagonista_on_body_entered(body):
	if body.name == "Player":
		insideZonaColisionBloqueGrisProtagonista = true

func on_zona_colision_bloque_gris_protagonista_on_body_exited(body):
	if body.name == "Player":
		insideZonaColisionBloqueGrisProtagonista = false

func on_bloque_gris_on_body_entered(body):
	if body.name == "Player":
		insideZonaMuerteBloqueGrisProtagonista = true

func on_bloque_gris_on_body_exited(body):
	if body.name == "Player":
		insideZonaMuerteBloqueGrisProtagonista = false
		

func damageBloqueGris():
	if insideZonaColisionBloqueGrisProtagonista and insideZonaMuerteBloqueGrisProtagonista:
		animPlayer.play("aplastado")
		life.damage(100)
		insideZonaMuerteBloqueGrisProtagonista = false
		insideZonaColisionBloqueGrisProtagonista = false

func _on_ventilador_on_body_entered(body):
	if body.name == "Player":
		if ventilador1anim.is_playing():
			life.damage(100)
		elif ventilador2anim.is_playing():
			life.damage(100)
		elif ventilador3anim.is_playing():
			life.damage(100)
		elif  ventilador4anim.is_playing():
			life.damage(100)

func _on_bloque_izquierda_on_body_entered(body):
	if body.name == "Player":
		insideZonaMuerteBloqueMovIzquierda = true

func _on_bloque_izquierda_on_body_exited(body):
	if body.name == "Player":
		insideZonaMuerteBloqueMovIzquierda = false

func _on_bloque_derecha_on_body_entered(body):
	if body.name == "Player":
		insideZonaMuerteBloqueMovDerecha = true

func _on_bloque_derecha_on_body_exited(body):
	if body.name == "Player":
		insideZonaMuerteBloqueMovDerecha = false

func damageBloquesIzquierdaDerecha():
	if insideZonaMuerteBloqueMovDerecha and insideZonaMuerteBloqueMovIzquierda:
		animPlayer.play("AplastadoIzquierda")
		life.damage(80)
		insideZonaMuerteBloqueMovIzquierda = false
		insideZonaMuerteBloqueMovDerecha = false

func _on_enemigo_araña_on_body_entered(body):
	if body.name == "Player":
		life.damage(8)

func _on_bola_pinchos_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

func _on_serpiente_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)

func _on_enemigo_mono_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)


func _on_enemigo_murcielago_on_body_entered(body):
	if body.name == "Player":
		life.damage(12)

func on_puerco_on_body_entered(body):
	if body.name == "Player":
		life.damage(20)



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
	jumpOrIdleOnduHojaHorizontal()
	presentFinishRaceOndu()
	damageBloqueAmarillo()
	damageBloqueGris()
	damageBloquesIzquierdaDerecha()
	
	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKManzana) and señalKManzana.visible:
			life.heal(20)
			señalKManzana.visible = false  
		elif is_instance_valid(señalxManzana) and señalxManzana.visible:
			life.heal(20)
			señalxManzana.visible = false 
			

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(manzanaRecuperaTodaVidaSeñalK) and manzanaRecuperaTodaVidaSeñalK.visible:
			life.heal(100)
			manzanaRecuperaTodaVidaSeñalK.visible = false  
		elif is_instance_valid(manzanaRecuperaTodaVidaSeñalX) and manzanaRecuperaTodaVidaSeñalX.visible:
			life.heal(100)
			manzanaRecuperaTodaVidaSeñalX.visible = false 
			

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
	


