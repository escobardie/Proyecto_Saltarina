extends Control

export var ruta_menu_ppal = "res://JUEGO/menus/MenuPpal.tscn"

func _ready():
	#siempre que el juego arranque hace=>
	#visibilidad del menu en falso
	visible = false


#vamos a usar este callback
func _input(event):
	#si el evento, de tecla es "pausa", hacer solo una vez =>
	if event.is_action_pressed("pausa"):
		#como es un valor booleano, solo le decimos que sea opuesto al que ya es
		visible = not visible
		#metodo del padre, para pausar el escena
		get_tree().paused = not get_tree().paused


func _on_BotonContinuar_pressed():
	#metodo del padre, para pausar el o no a la escena
	get_tree().paused = false
	visible = false


func _on_BotonMenuPPal_pressed():
	#llamos al arbol, pedimos el metodo "cambiar escena", y cambiamos
# warning-ignore:return_value_discarded
	get_tree().change_scene(ruta_menu_ppal)
