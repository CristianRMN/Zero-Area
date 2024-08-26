extends Node2D

@onready var bloque = $bloqueMover
@onready var areaEmpuje = $bloqueMover/zonaEmpuje
@onready var señalEmpuje = $"bloqueMover/zonaEmpuje/señalEmpuja"
@onready var areaFueraEmpuje = $"desconexionSeñalesBloqueCaida"
@onready var zonaEmpujeCayoSeñal = $"bloqueMover/zonaEmpujeCaida/señalEmpuja"
@onready var zonaEmpujeCayo = $bloqueMover/zonaEmpujeCaida
@onready var colisionZonaEmpuje1 = $bloqueMover/zonaEmpuje/CollisionShape2D
@onready var mariposa1 = $mariposa/AnimationPlayer

var speed = 15
var elBloqueCayo = false

func _ready():
#conexiones del bloque para empujar
	señalEmpuje.visible = false
	zonaEmpujeCayoSeñal.visible = false
	areaEmpuje.connect("body_entered", Callable(self, "_on_body_entered"))
	areaEmpuje.connect("body_exited", Callable(self, "_on_body_exited"))
	areaFueraEmpuje.connect("body_entered", Callable(self, "_on_area_cayo_on_body_entered"))
	
	zonaEmpujeCayo.connect("body_entered", Callable(self, "_on_zona_empuje_caida_on_body_entered"))
	zonaEmpujeCayo.connect("body_exited", Callable(self, "_on_zona_empuje_caida_on_body_exited"))

#mariposas
	mariposa1.play("volandoRectoIzquierda")

	


func _on_body_entered(body):
	if body.name == "Player" and elBloqueCayo == false:
		señalEmpuje.visible = true
		
func _on_body_exited(body):
	if body.name == "Player" and elBloqueCayo == false:
		señalEmpuje.visible = false

func _on_area_cayo_on_body_entered(body):
	if body.name == "bloqueMover":
		print("Estoy dentro")
		señalEmpuje.visible = false
		elBloqueCayo = true
		colisionZonaEmpuje1.disabled = true

func _on_zona_empuje_caida_on_body_entered(body):
	if body.name == "Player" and elBloqueCayo:
		zonaEmpujeCayoSeñal.visible = true
		
func _on_zona_empuje_caida_on_body_exited(body):
	if body.name == "Player" and elBloqueCayo:
		zonaEmpujeCayoSeñal.visible = false


func _physics_process(delta):
	if señalEmpuje.visible and Input.is_action_pressed("abrirLoQueSea"):
		bloque.position.x += speed * delta

	if zonaEmpujeCayoSeñal.visible and Input.is_action_pressed("abrirLoQueSea"):
		bloque.position.x += speed * delta
