extends Node2D

@onready var mariposa1 = $mariposa/AnimationPlayer
@onready var mariposa2 = $mariposa2/AnimationPlayer

func _ready():
	mariposa1.play("volandoArriba")
	mariposa2.play("volandoArriba")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
