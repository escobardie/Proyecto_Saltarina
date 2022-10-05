extends Area2D

#variable para se definida por el programador
export var es_trampa = false


var color_trampa = Color.black


onready var detector_personaje = $DetectorPersonaje


func _ready():
	#si es trampa hace =>
	if es_trampa:
		#para ayuda del diseñaro, al ser trampa se cambiara el color
		$Sprite.modulate = color_trampa
		#activar el Ray Cast (rayo detector de personaje)
		detector_personaje.enabled = true
		#llama a Rotation Degre, y modificar su propiedad para invertir al pincho
		rotation_degrees = 180


func _process(_delta):
	#si esta colisionando/detectando al personaje, hacer =>
	if detector_personaje.is_colliding():
		#desactivar el RayCast
		detector_personaje.set_deferred("enabled", false)
		$AnimationPlayer.play("caer")


func _on_body_entered(body): #llama a este metodo es tu responsabilidad
	body.respawn() #ey vos cuerpo que entraste ejecuta este metodo


