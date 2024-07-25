extends CharacterBody2D

@onready var sprite = $TroncoCaido
@onready var collision_shape = $CollisionShape2D
@onready var anim = $AnimationPlayer

func _ready():
	anim.connect("animation_finished", Callable(self, "_on_animation_finished"))
	anim.play("arbolVaaaa")

func _on_animation_finished(anim_name):
	if anim_name == "arbolVaaaa":
		collision_shape.disabled = true
		set_physics_process(false)

func _process(delta):
	collision_shape.rotation = sprite.rotation

func _update_collision_rotation():
	collision_shape.rotation = sprite.rotation
