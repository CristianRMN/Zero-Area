extends Node2D

@onready var setaVerde = $amigo_seta_verde/SpritesSetaVerde

func _ready():
	setaVerde.flip_h = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
