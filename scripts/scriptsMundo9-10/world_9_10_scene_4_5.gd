extends Node2D

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2() 

#mariposas
@onready var mariposas = [
$mariposa/AnimationPlayer,
$mariposa2/AnimationPlayer,
$mariposa3/AnimationPlayer,
$mariposa4/AnimationPlayer,
$mariposa5/AnimationPlayer,
$mariposa6/AnimationPlayer
]

#comida
@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX
@onready var señalKnaranja = $"naranjaRecuperaVida/señalComerK"
@onready var señalXnaranja = $"naranjaRecuperaVida/señalComerX"
@onready var señalKPlatano = $platano_recupera_vida/BananaKeyboardK
@onready var señalxPlatano = $platano_recupera_vida/BananaKeyboardX

#enemigos
@onready var hipopotamo1 = $hipopotamo
@onready var abeja1 = $enemigoAbeja
@onready var serpiente1 = $enemigoSerpiente
@onready var puerco1 = $enemigoPuerco
@onready var murcielagos = [
$murcielago,
$murcielago2
]

#estacas
@onready var areaEstacas = $areaEstacas



#temporizador veneno abeja
@onready var timer = Timer.new()
var wait_time = 5
var poison = false

func _ready():
#posicion del jugador
	initial_position = player.global_position
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		Global.player_position = Vector2()

#inicio temporizador
	timer.wait_time = wait_time
	timer.one_shot = true
	add_child(timer)

#conexion mariposas
	for mariposa in mariposas:
		mariposa.play("volandoArriba")

#conexiones enemigos
	hipopotamo1.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))
	abeja1.connect("body_entered", Callable(self, "on_abeja_on_body_entered"))
	serpiente1.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	puerco1.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	for murcielago in murcielagos:
		murcielago.connect("body_entered", Callable(self, "on_murcielago_on_body_entered"))

#conexion estacas
	areaEstacas.connect("body_entered", Callable(self, "on_area_estacas_on_body_entered"))




func _process(delta):
#llamamos al respawn del jugador
	if player.global_position.y > 600: 
		respawn_player()

	hitBee()
	if poison:
		life.damage(1)

#funcion de comida del jugador
	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKnaranja) and señalKnaranja.visible:
			life.heal(18)
			señalKnaranja.visible = false  
		elif is_instance_valid(señalXnaranja) and señalXnaranja.visible:
			life.heal(18)
			señalXnaranja.visible = false 

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKPlatano) and señalKPlatano.visible:
			life.heal(18)
			señalKPlatano.visible = false  
		elif is_instance_valid(señalxPlatano) and señalxPlatano.visible:
			life.heal(18)
			señalxPlatano.visible = false 

	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(señalKManzana) and señalKManzana.visible:
			life.heal(20)
			señalKManzana.visible = false  
		elif is_instance_valid(señalxManzana) and señalxManzana.visible:
			life.heal(20)
			señalxManzana.visible = false 


#funcion de respawn del jugador
func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)

#funciones enemigos
func on_hipopotamo_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

func on_abeja_on_body_entered(body):
	if body.name == "Player":
		timer.start()

func hitBee():
	if timer.is_stopped():
		poison = false
	
	else:
		poison = true


func _on_serpiente_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)


func on_puerco_on_body_entered(body):
	if body.name == "Player":
		life.damage(20)


func on_murcielago_on_body_entered(body):
	if body.name == "Player":
		life.damage(12)

#funcion estacas
func on_area_estacas_on_body_entered(body):
	if body.name == "Player":
		life.damage(10)
