extends Button


#al precionar el boton salir, mandamos una señal asi mismo y hacemos =>
func _on_pressed():
	#metodo para cerrar el juego
	get_tree().quit()
