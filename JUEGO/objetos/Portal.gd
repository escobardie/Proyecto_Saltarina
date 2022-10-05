extends Area2D

#variable sin definir, creada para cargar el nivel siguiente,
#ATENCION: DE DEBE AGREGAR LA RUTA DEL NIVEL, A LA INSTANCIA DENTRO DEL NIVEL,
#NO DENTRO DEL NODO PORTAL, SOLO LA INSTACIA DENTRO DEL NIVEL, "OJO A ESO DIEGO"
export var proximo_nivel = ""


var esta_activado = false


func _ready():
	#traeme mi padre, que quiero conectar una señal que se llama abrir portal,
	#(conecta a mi mismo), y conectar con el metodo de abrir el portal
# warning-ignore:return_value_discarded
	get_parent().connect("abrir_portal", self, "play_animacion")


func _on_body_entered(body):
	#si el personaja entra al portal, y el portal esta activado, hacer =>
	if esta_activado:
		#usaremos global_position pasa estabilizar al personaje cada vez que entra al portal (osea centrarlo)
		body.play_entrar_portal(global_position)
		#yield()= detiene el flujo del codigo, hasta que pase algo (definir)
		#creamos un timer por codigo, tiempo ACORDE a la animacion de entrar al portal,
		#finalizar cuando el timer llegue al final osea TIMEOUT.
		yield(get_tree().create_timer(1.0), "timeout")
		
		cambiar_nivel()


func cambiar_nivel():
	#llamos al arbol, pedimos el metodo "cambiar escena", y cambiamos

# warning-ignore:return_value_discarded
	get_tree().change_scene(proximo_nivel)


func play_animacion():
	esta_activado = true
	$AnimatedSprite.play("default")
	$AnimationPlayer.play("activado")

