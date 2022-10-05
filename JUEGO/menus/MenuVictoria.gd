extends Control


export var ruta_menu_ppal = "res://JUEGO/menus/MenuPpal.tscn"


# en el ready cuando la escena se cree
func _ready():
	#otra forma de controlar el string
	$Puntaje.text = "Puntaje: {p}".format({"p": DatosPlayer.generar_puntaje()})


#al precionar menu pepal, nos llevara a esta señal
func _on_BotonMenuPPal_pressed():
	#llamos al arbol, pedimos el metodo "cambiar escena", y cambiamos
# warning-ignore:return_value_discarded
	get_tree().change_scene(ruta_menu_ppal)
