extends Node2D

@onready var setaMarron = $amigo_seta_marron/SpritesSetaMarron1
@onready var setaMarron2 = $amigo_seta_marron2/SpritesSetaMarron1
@onready var setaAmarilla = $amigoSetaAmarilla2/SpritesSetaAmarilla


func _ready():
	setaMarron.flip_h = true
	setaMarron2.flip_h = true
	setaAmarilla.flip_h = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
