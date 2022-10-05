extends "res://JUEGO/objetos/power_up/PowerUpBase.gd"


#modificar metodo por herencia 
#sobre-escribir metodo
func aplicar_power_up(body):
	#llamamos al metodo dentro del personaje
	body.volar()
