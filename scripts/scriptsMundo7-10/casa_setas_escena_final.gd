extends Node2D

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2() 

#posicion seta
@onready var setaVerde = $amigo_seta_verde/SpritesSetaVerde
@onready var reySetaRoja = $amigo_rey_seta_roja/SpritesSetaRoja


func _ready():

#posicion del jugador
	initial_position = player.global_position
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		Global.player_position = Vector2()

#posicion seta verde
	setaVerde.flip_h = true
	reySetaRoja.flip_h = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
