extends KinematicBody2D

export var velocidad = 100.0


var gravedad = 500.0
var movimiento = Vector2.ZERO


onready var animacion = $AnimatedSprite
onready var detector_vacio = $DetectorVacio
onready var detector_pared = $DetectorPared


func _physics_process(_delta): #funcion de fisica para el enemigo
	caer()
	caminar()
	
# warning-ignore:return_value_discarded
	move_and_slide(movimiento, Vector2.UP)


func caer():
	if not is_on_floor(): #si no estas en el suelo tu movimineto es:
		movimiento.y = gravedad


func caminar():
	if not animacion.is_playing(): #si animacion no se esta ejecutando, entonces hace esto
		animacion.play("caminar")
	
	detectar_colision()
	
	movimiento.x = velocidad


func detectar_colision():
	
	#bug solucionado con: TRASFORM => modificar posicion de "y = -5" "X = 35"
	if not detector_vacio.is_colliding() or detector_pared.is_colliding():
	#si NO estoy colisionando (es porque ya se me agoto la plataforma) y hacemos esto
	# O si detector pared colisiona con pared, hacer esto tambien
		velocidad *= -1  #debo de manejar movimiento a travez de velocidad
		detector_vacio.position.x *= -1 #dame vuelta el detector vacio
		detector_pared.position.x *= -1 #dame vuelta el detector pared
		detector_pared.scale.x *= -1
		animar(animacion.flip_h)



#cambiara el estado de la animacion al estado contrario
func animar(valor_actual):
	animacion.flip_h = !valor_actual



func _on_DetectorJugador_body_entered(body):
	body.respawn() #cuando el cuerpo colociona manda una señal, que en este caso es reinicio
