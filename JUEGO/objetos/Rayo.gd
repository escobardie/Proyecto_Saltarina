extends Area2D

export var velocidad = 400.0

var mi_pos = Vector2.ZERO

onready var animacion = $Animacion #intanciamos a la animacion que creamos


func _ready():
	global_position = mi_pos
	animacion.play("moverse")


func crear(pos):
	mi_pos = pos


func _process(delta):
	#por cada cuadro de tu posicion, movete en el eje "Y"
	global_position.y += velocidad * delta #usando la variable delta, nos ahoramos la dificultad de los fps 


func _on_VisibilityNotifier2D_screen_exited():
	destruirse() #los nodos que salen de la pantalla se destruyen con queue_free()


func destruirse():
	queue_free() #liberar/destruir nodos


func _on_body_entered(body):
	#si esto que estas chocando es del GRUPO "JUGADORES", haces lo siguiente
	if body.is_in_group("jugador"): #si esta en un grupo "jugador", hace esto
		body.respawn() #metodo del personaje reinicio del juego
	
	destruirse() #metodo para eliminar los rayos al colisionar con la plataforma y el personaje
