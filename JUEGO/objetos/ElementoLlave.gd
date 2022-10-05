extends Area2D

#crearemos una señal para detectar la cantidad de llaves y poder consumirlas
signal consumida()


func _on_body_entered(_body):
	
	#al cosumur la llave, hacemos esto
	DatosPlayer.restar_llaves()
	
	
	emit_signal("consumida")
	#con esto nos aseguramos de que con tocarlo ya se desactive y solo consuma una llave
	$DetectorPersonaje.set_deferred("disabled", true)
	$AnimationPlayer.play("consumir")
