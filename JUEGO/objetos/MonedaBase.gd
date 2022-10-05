extends Area2D

#variable para poder definir que tipo de moneda es cada una
export(String,"oro", "plata", "bronce") var tipo_moneda


onready var animacion_moneda := $AnimatedSprite
onready var animacion_consumir := $AnimationPlayer
onready var colisionador_personaje = $CollisionPersonaje


func _ready():
	animacion_moneda.play()


func _on_body_entered(_body):
	
	#contectamos con el metodo para sumar las monedas
	DatosPlayer.sumar_monedas(tipo_moneda)
	
	#metodo para desactivar la colision
	colisionador_personaje.set_deferred("disabled", true)
	#para que una vez consumida/desaparezca la moneda, ya no se vuelva a consumirse
	#personaje entro yl colisionador desaparecio
	animacion_consumir.play("consumir")
