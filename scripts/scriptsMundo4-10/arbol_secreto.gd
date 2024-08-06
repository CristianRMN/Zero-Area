extends Node2D


@onready var ardilla1 = $amigaArdilla/AnimationPlayer
@onready var ardilla2 = $amigaArdilla2/AnimationPlayer
@onready var ardilla3 = $amigaArdilla3/AnimationPlayer
@onready var ardilla4 = $amigaArdilla4/AnimationPlayer
@onready var ardilla5 = $amigaArdilla5/AnimationPlayer
@onready var ardilla6 = $amigaArdilla6/AnimationPlayer
@onready var ardilla7 = $amigaArdilla7/AnimationPlayer
@onready var ardilla8 = $amigaArdilla8/AnimationPlayer
@onready var ardilla9 = $amigaArdilla9/AnimationPlayer
@onready var ardilla10 = $amigaArdilla10/AnimationPlayer
@onready var ardilla11= $amigaArdilla11/AnimationPlayer
@onready var ardilla12 = $amigaArdilla12/AnimationPlayer
@onready var ardilla13 = $amigaArdilla13/AnimationPlayer
@onready var ardilla14 = $amigaArdilla14/AnimationPlayer
@onready var ardilla15Sprite = $amigaArdilla15/SpritesArdilla
@onready var ardilla15 = $amigaArdilla15/AnimationPlayer

@onready var bellota1SeñalK = $bellotaRecuperaVida/comeK
@onready var bellota1SeñalX = $bellotaRecuperaVida/comeX

@onready var bellota2SeñalK = $bellotaRecuperaVida2/comeK
@onready var bellota2SeñalX = $bellotaRecuperaVida2/comeX

@onready var bellota3SeñalK = $bellotaRecuperaVida3/comeK
@onready var bellota3SeñalX = $bellotaRecuperaVida3/comeX

@onready var bellota4SeñalK = $bellotaRecuperaVida4/comeK
@onready var bellota4SeñalX = $bellotaRecuperaVida4/comeX

@onready var bellota5SeñalK = $bellotaRecuperaVida5/comeK
@onready var bellota5SeñalX = $bellotaRecuperaVida5/comeX

@onready var bellota6SeñalK = $bellotaRecuperaVida6/comeK
@onready var bellota6SeñalX = $bellotaRecuperaVida6/comeX

@onready var bellota7SeñalK = $bellotaRecuperaVida7/comeK
@onready var bellota7SeñalX = $bellotaRecuperaVida7/comeX

@onready var bellota8SeñalK = $bellotaRecuperaVida8/comeK
@onready var bellota8SeñalX = $bellotaRecuperaVida8/comeX

@onready var bellota9SeñalK = $bellotaRecuperaVida9/comeK
@onready var bellota9SeñalX = $bellotaRecuperaVida9/comeX

@onready var bellota10SeñalK = $bellotaRecuperaVida10/comeK
@onready var bellota10SeñalX = $bellotaRecuperaVida10/comeX



func _ready():
	ardilla1.play("eat")
	ardilla2.play("eat")
	ardilla3.play("eat")
	
	ardilla4.play("walk")
	ardilla5.play("walk")
	ardilla6.play("walk")
	ardilla7.play("walk")
	ardilla8.play("walk")
	ardilla9.play("walk")
	ardilla10.play("walk")
	ardilla11.play("walk")
	ardilla12.play("walk")
	ardilla13.play("walk")
	ardilla14.play("walk")
	
	ardilla15.play("idle")
	ardilla15Sprite.flip_h = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
