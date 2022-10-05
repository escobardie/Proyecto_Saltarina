extends Control

var nivel_actual = ""

#variable sin definir, creada para cargar el nivel siguiente,
#ATENCION: SE DEBE AGREGAR LA RUTA DEL NIVEL, A LA INSTANCIA DENTRO DEL NIVEL,
#NO DENTRO DEL NODO PORTAL, SOLO LA INSTACIA DENTRO DEL NIVEL, "OJO A ESO DIEGO"
export var ruta_menu_ppal = "res://JUEGO/menus/MenuPpal.tscn"

func _ready():
	nivel_actual = DatosPlayer.nivel_actual
	#al perder se llamara a este metodo que devuelve los valores a su estado original
	DatosPlayer.reset()


#al precionar menu pepal, nos llevara a esta señal
func _on_BotonMenuPPal_pressed():
	#llamos al arbol, pedimos el metodo "cambiar escena", y cambiamos
# warning-ignore:return_value_discarded
	get_tree().change_scene(ruta_menu_ppal)


func _on_BotonReintentar_pressed():
	#llamos al arbol, pedimos el metodo "cambiar escena", y cambiamos
# warning-ignore:return_value_discarded
	get_tree().change_scene(nivel_actual)

