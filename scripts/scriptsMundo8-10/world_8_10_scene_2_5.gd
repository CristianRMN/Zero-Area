extends Node2D

#mariposas
@onready var mariposa1Anim = $mariposa/AnimationPlayer
@onready var mariposa2Anim = $mariposa2/AnimationPlayer
@onready var mariposa3Anim = $mariposa3/AnimationPlayer
@onready var mariposa4Anim = $mariposa4/AnimationPlayer

func _ready():
	mariposa1Anim.play("volandoArriba")
	mariposa2Anim.play("volandoArriba")
	mariposa3Anim.play("volandoArriba")
	mariposa4Anim.play("volandoAbajo")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
