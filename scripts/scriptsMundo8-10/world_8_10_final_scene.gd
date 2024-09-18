extends Node2D

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2() 

#ventiladores
@onready var ventilador1 = $ventiladoresMortales
@onready var ventilador1Anim = $ventiladoresMortales/AnimationPlayer
@onready var ventilador2 = $ventiladoresMortales2
@onready var ventilador2Anim = $ventiladoresMortales2/AnimationPlayer
@onready var ventilador3 = $ventiladoresMortales3
@onready var ventilador3Anim = $ventiladoresMortales3/AnimationPlayer

#comida
@onready var señalKnaranja = $"naranjaRecuperaVida/señalComerK"
@onready var señalXnaranja = $"naranjaRecuperaVida/señalComerX"
@onready var señalKManzana = $manzana_recupera_vida/PulsaK
@onready var señalxManzana = $manzana_recupera_vida/PulsaX

#enemigos
@onready var hipopotamo1 = $hipopotamo
@onready var serpiente1 = $enemigoSerpiente
@onready var puerco1 = $enemigoPuerco
@onready var abeja1 = $enemigoAbeja
@onready var abeja2 = $enemigoAbeja2
@onready var murcielago1 = $murcielago

#bolaPinchos
@onready var bolaPinchos1 = $bolaPinchoPecharuntVertical

#temporizador veneno abeja
@onready var timer = Timer.new()
var wait_time = 5
var poison = false

#bloques azules
@onready var areaBloquesAzulesIzquierda = [$bloqueMovimientoIzquierda/zonaMuerte,
$bloqueMovimientoIzquierda2/zonaMuerte, $bloqueMovimientoIzquierda3/zonaMuerte,
$bloqueMovimientoIzquierda4/zonaMuerte, $bloqueMovimientoIzquierda5/zonaMuerte,
$bloqueMovimientoIzquierda6/zonaMuerte, $bloqueMovimientoIzquierda7/zonaMuerte]

@onready var areaBloquesAzulesDerecha = [$bloqueMovimientoDerechaEscena4/zonaMuerte,
$bloqueMovimientoDerechaEscena5/zonaMuerte, $bloqueMovimientoDerechaEscena6/zonaMuerte,
$bloqueMovimientoDerechaEscena7/zonaMuerte, $bloqueMovimientoDerechaEscena8/zonaMuerte,
$bloqueMovimientoDerechaEscena9/zonaMuerte, $bloqueMovimientoDerechaEscena10/zonaMuerte]

@onready var zonaParedIzquierda = $zonaColisionBloquesIzquierdaPared
@onready var zonaParedDerecha = $zonaColisionBloqueDerechaPAred

var insideBloqueIzquierda = false
var insideBloqueDerecha = false
var insideParezIzquuierda = false
var insideParedDerecha = false


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

#conexion ventilador
	ventilador1.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador2.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))
	ventilador3.connect("body_entered", Callable(self, "_on_ventilador_on_body_entered"))

#conexiones enemigos
	hipopotamo1.connect("body_entered", Callable(self, "on_hipopotamo_on_body_entered"))
	serpiente1.connect("body_entered", Callable(self, "_on_serpiente_on_body_entered"))
	puerco1.connect("body_entered", Callable(self, "on_puerco_on_body_entered"))
	abeja1.connect("body_entered", Callable(self, "on_abeja_on_body_entered"))
	abeja2.connect("body_entered", Callable(self, "on_abeja_on_body_entered"))
	murcielago1.connect("body_entered", Callable(self, "on_murcielago_on_body_entered"))

#conexion bola pinchos
	bolaPinchos1.connect("body_entered", Callable(self, "on_bola_pincho_on_body_entered"))

#conexion bloques azules
	for area in areaBloquesAzulesIzquierda:
		if area is Area2D:
			area.connect("body_entered", Callable(self, "on_bloque_azul_izquierda_on_body_entered"))
			area.connect("body_exited", Callable(self, "on_bloque_azul_izquierda_on_body_exited"))

	for area in areaBloquesAzulesDerecha:
		if area is Area2D:
			area.connect("body_entered", Callable(self, "on_bloque_azul_derecha_on_body_entered"))
			area.connect("body_exited", Callable(self, "on_bloque_azul_derecha_on_body_exited"))
	zonaParedIzquierda.connect("body_entered", Callable(self, "on_pared_izquierda_on_body_entered"))
	zonaParedDerecha.connect("body_entered", Callable(self, "on_pared_derecha_on_body_entered"))
	zonaParedIzquierda.connect("body_exited", Callable(self, "on_pared_izquierda_on_body_exited"))
	zonaParedDerecha.connect("body_exited", Callable(self, "on_pared_derecha_on_body_exited"))


func _process(delta):
#llamamos al respawn
	if player.global_position.y > 500: 
		respawn_player()
	
	damageBlockBlueLeft()
	damageBlockBlueRight()

	hitBee()
	if poison:
		life.damage(1)

#funcion alimentacion
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


#funcion respawn del jugador
func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)

#funcion ventilador
func _on_ventilador_on_body_entered(body):
	if body.name == "Player":
		if ventilador1Anim.is_playing():
			life.damage(100)
		if ventilador2Anim.is_playing():
			life.damage(100)
		if ventilador3Anim.is_playing():
			life.damage(100)

#funciones de bolas de pinchos y ventiladores
func on_bola_pincho_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)

#funciones enemigos
func on_hipopotamo_on_body_entered(body):
	if body.name == "Player":
		life.damage(30)


func _on_serpiente_on_body_entered(body):
	if body.name == "Player":
		life.damage(15)


func on_puerco_on_body_entered(body):
	if body.name == "Player":
		life.damage(20)

func on_abeja_on_body_entered(body):
	if body.name == "Player":
		timer.start()


func on_murcielago_on_body_entered(body):
	if body.name == "Player":
		life.damage(12)

#funcion veneno abeja
func hitBee():
	if timer.is_stopped():
		poison = false
	
	else:
		poison = true

#funciones bloques azules
func on_bloque_azul_izquierda_on_body_entered(body):
	if body.name == "Player":
		print("aqui1")
		insideBloqueIzquierda = true

func on_bloque_azul_izquierda_on_body_exited(body):
	if body.name == "Player":
		print("aqui2")
		insideBloqueIzquierda = false

func on_bloque_azul_derecha_on_body_entered(body):
	if body.name == "Player":
		print("aqui3")
		insideBloqueDerecha = true

func on_bloque_azul_derecha_on_body_exited(body):
	if body.name == "Player":
		print("aqui4")
		insideBloqueDerecha = false

func on_pared_izquierda_on_body_entered(body):
	if body.name == "Player":
		print("aqui5")
		insideParezIzquuierda = true

func on_pared_izquierda_on_body_exited(body):
	if body.name == "Player":
		print("aqui6")
		insideParezIzquuierda = false

func on_pared_derecha_on_body_entered(body):
	if body.name == "Player":
		print("aqui7")
		insideParedDerecha = true

func on_pared_derecha_on_body_exited(body):
	if body.name == "Player":
		print("aqui8")
		insideParedDerecha = false

func damageBlockBlueLeft():
	if insideBloqueDerecha and insideParedDerecha:
		animPlayer.play("AplastadoIzquierda")
		life.damage(80)
		insideBloqueDerecha = false
		insideParedDerecha = false

func damageBlockBlueRight():
	if insideBloqueIzquierda and insideParezIzquuierda:
		animPlayer.play("AplastadoIzquierda")
		life.damage(80)
		insideBloqueIzquierda = false
		insideParezIzquuierda = false
