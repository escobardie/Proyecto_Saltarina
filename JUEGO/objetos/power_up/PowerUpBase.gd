extends Area2D


onready var animacion = $AnimationPlayer
onready var detector_personaje = $CollisionShape2D


#cuando entre el cuerpo en el area =>
func _on_body_entered(body):
	#llama automaticamente al metodo
	aplicar_power_up(body)
	#desactivamos el colisionador
	detector_personaje.set_deferred("disabled", true)
	#repro animacion
	animacion.play("consumir")


func aplicar_power_up(_body):
	pass
