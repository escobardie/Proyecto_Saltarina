extends Area2D

onready var detector_jugador = $DetectorJugador #para desactivar la colision para el RESPAWN
onready var detector_pisoton = $DetectorPisoton/Colisionador #para desactivar la colision para saltar
onready var volon_animation = $AnimationPlayer #para llamar a la animacion que creamos



func _on_DetectorPisoton_body_entered(body):#cuando body(persanaje) hace contacto => hace esto:
	desactivar_colisionadores([detector_jugador, detector_pisoton]) #funcion con lista de colisionadores
	body.impulsar() #metodo del personaje, impulsa al jugador para llegar mas lejos
	volon_animation.stop() #antes de la animacionde volar, pausame cualquier animacion
	volon_animation.play("morir") #play a la animacion de morir


func _on_body_entered(body):#cuando body(persanaje) hace contacto => hace esto:
	body.respawn() #metodo del personaje reinicio del juego


func desactivar_colisionadores(colisionadores):
	#por cada colision en la lista de colisionadores, hace lo siguiente
	for colision in colisionadores:
		#hace todo esto, con cada una de las colisionadores de la lista
		colision.set_deferred("disabled", true) #cuando hace contacto me desactivas la colision
		colision.set_deferred("visible", false) #cuando hace contacto me haces desaparecer el Colisionador
	#detector_jugador.set_deferred("disabled", true) #cuando hace contacto me desactivas la colision del RESPAWN
	#detector_jugador.set_deferred("visible", false) #cuando hace contacto me haces desaparecer el Colisionador DETECTORJUGADOR
	#detector_pisoton.set_deferred("disabled", true)
	#detector_pisoton.set_deferred("visible", false)
	


