extends Node2D

@onready var player = $Player 
@onready var life = $CanvasLayer/vidaTerapagos/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer

@onready var ondu = $AmigoOndu
@onready var onduSprite = $AmigoOndu/TodosLosSpritesDeOndu
@onready var onduAnim = $AmigoOndu/AnimationPlayer

@onready var areaInicioHablar = $conversacionOnduInicio
@onready var señalHablar = $conversacionOnduInicio/habla

@onready var startRaceAreaInicio = $inicio/areaInicio
@onready var startRaceColisionMeta = $inicio/CollisionShape2D
@onready var startAreaInicioSeñal = $inicio/areaInicio/start

@onready var nomoverseHastaStart = $notMove/CollisionShape2D

@onready var fuegos1 = $fuegosArtificialesCarrera
@onready var fuegos1Anim = $fuegosArtificialesCarrera/AnimationPlayer
@onready var fuegos2 = $fuegosArtificialesCarrera2
@onready var fuegos2Anim = $fuegosArtificialesCarrera2/AnimationPlayer

@onready var finDeLosFuegos = $finFuegos

var runnersInPosition = false
var notSpeakWithOndu = false
var aCorrer = false

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
		
		
		

func _on_fuegos_on_body_entered(body):
	if body.name == "fuegosArtificialesCarrera":
		explota = true
		print("entre")


func AnimationFuegos():
	if explota:
		if explota:
			fuegos1Anim.play("fuegos")
			fuegos2Anim.play("fuegos")
			explota = false  # Evita que la animación se reproduzca más de una vez
			aCorrer = true


func _on_fuegos_animation_finished(anim_name):
	animations_finished += 1
	if animations_finished >= 2:  # Espera a que ambas animaciones terminen
		fuegos1.hide()
		fuegos2.hide()
		animations_finished = 0  # Reinicia el contador para la próxima vez
		


func startRace():
	if (startAreaInicioSeñal.visible) and runnersInPosition and notSpeakWithOndu and Input.is_action_just_pressed("abrirLoQueSea"):
		lanzaFuegos = true
		
		if aCorrer:
			startRaceColisionMeta.disabled = true
			nomoverseHastaStart.disabled = false
			onduAnim.play("run")

func _physics_process(delta):
	# Verificar si el jugador ha caído por debajo de un umbral
	if player.global_position.y > 500: 
		respawn_player()
		
	in_starting_position()
	if lanzaFuegos:
		fuegos1.position.y += direction_lanza_fuegos * posicionFuegos * delta
		fuegos2.position.y += direction_lanza_fuegos * posicionFuegos * delta
	AnimationFuegos()
	
	startRace()
	

func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)
	


