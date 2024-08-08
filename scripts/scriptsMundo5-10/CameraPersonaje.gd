extends Camera2D




func _ready():
	limit_top = -432  # Evitar movimiento hacia arriba
	limit_bottom = position.y  # Evitar movimiento hacia abajo


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
