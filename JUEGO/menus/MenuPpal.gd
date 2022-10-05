extends Control

#variable sin definir, creada para cargar el nivel siguiente,
#ATENCION: DE DEBE AGREGAR LA RUTA DEL NIVEL, A LA INSTANCIA DENTRO DEL NIVEL,
#NO DENTRO DEL NODO PORTAL, SOLO LA INSTACIA DENTRO DEL NIVEL, "OJO A ESO DIEGO"
export var iniciar_nivel =  ""#"res://JUEGO/niveles/Nivel1.tscn"

func _ready():
	#uso esto por un bug que al pausar, entrar al menu ppal, luego iniciar juego.
	#quedaba todo en pausa. (osea todos los hijos desde esa pausa)
	#con esto me aseguro de que no quede pausado al iniciar el juego
	get_tree().paused = false
	#para librarnos del bug de las monedas
	#asi al volver al menu ppal, e inicia el juego las monedas quedan en cero de nuevo
	DatosPlayer.reset()
	

#al precionar iniciar juego, nos llevara a esta señal
func _on_BotonIniciar_pressed():
	#metodo para el reinicio de la musica
	MusicaGlobal.replay()
	#llamos al arbol, pedimos el metodo "cambiar escena", y cambiamos
# warning-ignore:return_value_discarded
	get_tree().change_scene(iniciar_nivel)
