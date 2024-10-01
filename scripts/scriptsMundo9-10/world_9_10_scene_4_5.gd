extends Node2D

#mariposas
@onready var mariposas = [
$mariposa/AnimationPlayer,
$mariposa2/AnimationPlayer,
$mariposa3/AnimationPlayer,
$mariposa4/AnimationPlayer
]


func _ready():
	for mariposa in mariposas:
		mariposa.play("volandoArriba")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
