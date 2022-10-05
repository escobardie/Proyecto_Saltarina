extends Area2D


onready var animacion = $AnimationPlayer
onready var sonido_salto = $AudioStreamPlayer


func _ready():
	animacion.play("idle")


#cuando el jugador colisiona con el detector hacer =>
func _on_DetectorImpulso_body_entered(body):
	#por cada colision repro el sonido del salto
	sonido_salto.play()
	#repro la animacion al colisionar con el personaje
	animacion.play("impulsar")
	#metodo del jugador para ser impulsado
	body.impulsar()
