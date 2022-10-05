extends StaticBody2D


#cuando el jugador entre, y el area lo detecte hacer =>
func _on_DetectorPersonaje_body_entered(_body):
	#llamamos al colisionador directamente sin almacenarlo primero en una variable
	$DetectorPersonaje/CollisionShape2D.set_deferred("disabled", true) #desactivamos el colisionador
	#se usar el llamado directo solo cuando sabes que solo sera usado una vez
	$AnimationPlayer.play("caer")


func deshabilitar_colisionador():
	#llamamos al colisionador directamente sin almacenarlo primero en una variable
	$Colisionador.set_deferred("disabled", true) #desactivamos el colisionador

