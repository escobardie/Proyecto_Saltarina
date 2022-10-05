extends Node

#crearemos una señal para poder abrir el portal
signal abrir_portal()

#variable para la ventana de game over
export var menu_game_over = "res://JUEGO/menus/MenuGameOver.tscn"
#variable para definir el nivel actual cada vez que decidamos REINICIA la partida-
#luego del GAMEOVER
export var nivel_actual = ""
#usaremos esto para identifica en que nivel estamos
export var numero_nivel = ""

var numero_llave = 0
var contenedor_llaves

#llamda para programar el movimiento de las nubes
onready var nubes_lejanas = $ParallaxBackground/ParallaxNubesLejanas


func _ready():
	DatosPlayer.numero_nivel = numero_nivel
	#recibimos la señal transmitida desde el DatosPlayer
# warning-ignore:return_value_discarded
	DatosPlayer.connect("s_game_over", self, "game_over")
	#cargamos en la variable el nodo donde estan las llaves
	contenedor_llaves = get_node_or_null("ContenedorLLaves")
	#si contenedor llave no es nulo, hace =>
	if contenedor_llaves != null:
		nuero_llaves_nivel()
	
	


#movimiento de nubes a la izquierda
#func _process(delta):
	#motion_offset es la propiedad que requiero para el eje "X" ,
	#y que decresca 5 pixeles
#	nubes_lejanas.motion_offset.x -= 5


func nuero_llaves_nivel():
	#cargamos en la variable el numero de la cantidad de sus hijos dentro del nodo
	numero_llave = contenedor_llaves.get_child_count()
	#get_child_count() = cantidad numerica de hijos
	
	#llamada para enviar la cantidad de llaves y asi poder ser usado en el HUD
	DatosPlayer.contabilizar_llaves(numero_llave)
	
	#por cada hijo, dentro del contenedor de llaves, hacer =>
	for llave in contenedor_llaves.get_children():#get_children() = hitera los hijos
		#por cada hijo, conecta la señal "consumida" al metodo "llave restantes"
		#self es la referencia a si mismo 
		llave.connect("consumida", self, "llaves_restantes")


func llaves_restantes():
	numero_llave -= 1
	#si ya se consumieron las llaves, hacer =>
	if numero_llave == 0:
		#enviamos la señal para abrir el portal
		emit_signal("abrir_portal")


#funcion para cambia de escena
func game_over():
	#DATOS PLAYER tu nivel actual es el que tengo guardada en la variable export
	DatosPlayer.nivel_actual = nivel_actual
	#DatosPlayer.numero_nivel = numero_nivel
	
# warning-ignore:return_value_discarded
	get_tree().change_scene(menu_game_over)
