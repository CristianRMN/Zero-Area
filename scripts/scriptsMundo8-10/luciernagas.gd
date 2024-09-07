extends Area2D
@onready var luciernagasAnim = $AnimationPlayer


func _ready():
	luciernagasAnim.play("fly")


func _process(delta):
	pass
