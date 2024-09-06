extends Node2D

#jugador
@onready var player = $Player 
@onready var life = $vidaTerapagos/CanvasLayer/ProgressBar
@onready var animPlayer = $Player/AnimationPlayer
var initial_position = Vector2() 



#setas
@onready var setaMarron = $amigo_seta_marron/SpritesSetaMarron1
@onready var setaMarron2 = $amigo_seta_marron2/SpritesSetaMarron1
@onready var setaAmarilla = $amigoSetaAmarilla2/SpritesSetaAmarilla



func _ready():

#posicion del jugador
	initial_position = player.global_position
	if Global.player_position != Vector2():
		player.global_position = Global.player_position
		Global.player_position = Vector2()


#posiciones de las setas
	setaMarron.flip_h = true
	setaMarron2.flip_h = true
	setaAmarilla.flip_h = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
