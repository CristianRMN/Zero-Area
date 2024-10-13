extends Node2D

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2() 

#variables de las abejas
@onready var abejas = [
$enemigoAbeja,
$enemigoAbeja2,
$enemigoAbeja3
]

#temporizador veneno abeja
@onready var timer = Timer.new()
var wait_time = 5
var poison = false

#comida
@onready var miel_señalk = $Miel_Recupera_Vida/Area2D/comeK
@onready var miel_señalx = $Miel_Recupera_Vida/Area2D/comeX


func _ready():
#posicion del jugador
	initial_position = player.global_position
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		Global.player_position = Vector2()

	for abeja in abejas:
		abeja.connect("body_entered",Callable(self, "on_abeja_on_body_entered"))

#inicio temporizador
	timer.wait_time = wait_time
	timer.one_shot = true
	add_child(timer)



func _process(delta):
#llamamos al respawn del jugador
	if player.global_position.y > 600: 
		respawn_player()

	hitBee()
	if poison:
		life.damage(1)
		
	eat_miel()

#funcion de respawn del jugador
func respawn_player():
	# Restaurar la posición del jugador a la posición inicial
	player.global_position = initial_position
	life.damage(10)

func on_abeja_on_body_entered(body):
	if body.name == "Player":
		timer.start()

func hitBee():
	if timer.is_stopped():
		poison = false
	
	else:
		poison = true
		

func eat_miel():
	if Input.is_action_just_pressed("alimentacion"):
		if is_instance_valid(miel_señalk) and miel_señalk.visible:
			life.heal(3)
			miel_señalk.visible = false  
		elif is_instance_valid(miel_señalx) and miel_señalx.visible:
			life.heal(3)
			miel_señalx.visible = false 
