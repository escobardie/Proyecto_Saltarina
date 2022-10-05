extends KinematicBody2D

# con "export" hacemos que la prioridad este en el editor no en los valores dentro del script
#cuando trabajamos en VJ con velocidad y movimiento, usamos magnitudes vectoriales (Vector2)
export var velocidad = Vector2(150.0, 150.0)
export var acel_caida = 400
export var fuerza_salto = 3000
export var fuerza_rebote = 350
export var impulso = -3800 #valor negativos porque esta en el eje "Y"


#variable globar que cuando se inicialize valga CERO
var movimiento = Vector2.ZERO
var fuerza_salto_original
var acel_caida_original
var puede_moverse = true #variable para definir si tiene permitido moverse


onready var animacion = $AnimacionSprite
onready var audio_salto = $AudioSalto
onready var camara = $Camera2D
onready var timer_power_up = $EnfriamientoPowerUpSalto
onready var timer_power_up_Volar = $EnfriamientoPowerUpVolar
onready var animacion_personaje = $AnimationPlayer


#cada vez que empiece el nivel, o aparezca la escena de saltarina
func _ready():
	#animacion para darle un poco de detalles al ingreso del juego
	animacion_personaje.play("aclarar")
	#calculo para restaurar la fuerza de salto a su original
	fuerza_salto_original = fuerza_salto
	#calculo para restaurar la aceleracio de caida a su original
	acel_caida_original = acel_caida

#cuando sean cuestiones de movimientos o fisica usaremos _physics_process
#declararemos movimientos del jugador
func _physics_process(_delta):
	#estoy tomando el movimiento orizontal, osea en el eje X
	movimiento.x = velocidad.x * tomar_direccion()
	
	caer()
	saltar()
	colicion_techo()
	caida_al_vacio()
	
	#es el metodo que hace que se mueva el personaje
# warning-ignore:return_value_discarded
	move_and_slide(movimiento, Vector2.UP)
	#con Vector2.UP podemos sabr que es un techo y que es el suelo


func tomar_direccion():
	var direccion = 0
	# puede_moverse variable creada para el post ingreso al portal
	#si tiene permitido moverse (true), hacer =>
	if puede_moverse:
		#teclas mapeadas
		# get_action_strength = tomar la fuerza de la accion
		direccion = Input.get_action_strength("mov_der") - Input.get_action_strength("mov_izq")
		#cuando no esta en movimiento hace=>
		if direccion == 0:
			animacion.play("idle")
		else:
			#en direccion a la izquierda
			if direccion < 0:
				#activamos el flip_H
				animacion.flip_h = true
			#en direccion a la derecha
			else:
				#desactiva el flip_H
				animacion.flip_h = false
			animacion.play("correr")
	return direccion



func caer():
	#siempre que el personaje no este en el suelo, hacer =>
	if not is_on_floor():
		animacion.play("saltar")
		#aceleracion progresiva de la caida
		movimiento.y += acel_caida
		#clamp = declaramos el maximo y minimo para atrapar(controlar) al personaje, es decir damos el topo de velocidad
		#de caida del personaje
		#basicamente es: atrapar un valor entre otro dos valores
		movimiento.y = clamp(movimiento.y, impulso, velocidad.y)


func saltar ():
	#is_action_pressed= ejecutar siempre que este precionada la tecla
	#is_action_just_pressed = lo ejecutara solo una vez al precionar la tecla
	#is_action_just_released = lo ejecutara solo una vez al soltar la tecla
	#cuando se preciona tecla "salto" hacer (ejectura solo una vez) =>
	#puede_moverse es una variable para permitir el movimiento, usado para entrar al portal
	if Input.is_action_just_pressed("salto") and is_on_floor() and puede_moverse:
	#si estoy precionando salto y aparte estoy tocando el suelo hacer=>
		audio_salto.play()
		animacion.play("saltar")
		#calculo que hace posible el salto
		saltar_movimiento()


#metodo que crea el salto
func saltar_movimiento():
	#calculo para contrarestar la fuerza de salto
	movimiento.y = 0 #calculo para que la fuerza de salto tenga mas impacto
	movimiento.y -= fuerza_salto


func colicion_techo():
	#si el personaje colisiona con el techo hacer=>
	if is_on_ceiling():
		#rebota hacia abajo
		movimiento.y = fuerza_rebote


func impulsar():
	movimiento.y = impulso


func caida_al_vacio():
	#si la posion de nuestro personaje es major al limite inferior de la camara
	if position.y > camara.limit_bottom:
		# cuando el personaje sale del enfoque de la camara, se reinicia
		respawn()


func respawn():
	DatosPlayer.restar_vidas()
	#animacion para darle un poco de detalles al morir el juego
	animacion_personaje.play("oscurecer")
	#SOLO SI LA VIDA ES MAYOR IGUAL A 1 HACE =>
	if DatosPlayer.vidas >= 1:
		#metodo para reiniciar la escena actual
# warning-ignore:return_value_discarded
		get_tree().reload_current_scene()


#metodo usado en el powerUp de salto
func cambiar_fuerza_salto():
	#iniciamos el timer para el powerUp
	timer_power_up.start()
	#cambiamos la fuerza de salto 
	fuerza_salto = -impulso * 0.9


#metodo usado en el powerUp de volar
func volar():
	#iniciamos el timer para el powerUp
	timer_power_up_Volar.start()
	#cambiamos la aceleracion de su caida
	acel_caida = 60
	#repro animacion de volar
	animacion_personaje.play("volar")
	#llamamos al metodo que hace posible al salto
	saltar_movimiento()


#cuando este timer llegue a cero hacer =>
func _on_EnfriamientoPoweUp_timeout():
	#restaura valor del salto al original
	fuerza_salto = fuerza_salto_original


#cuando este timer llegue a cero hacer =>
func _on_EnfriamientoPowerUpVolar_timeout():
	#cuando se termina el timer repro esto
	animacion_personaje.play("default")
	#restaura valor del aceleracion de caida al original
	acel_caida = acel_caida_original


func play_entrar_portal(posicion_portal):
	#una vez dentro del portal, rep animacion y anulamos los movimientos del personaje
	animacion_personaje.play("entrar_portal")
	puede_moverse = false
	$Tween.interpolate_property(
		self,
		"global_position",
		global_position,
		posicion_portal,
		0.8,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT_IN
	)
	$Tween.start()


func _on_AnimationPlayer_animation_finished(anim_name):
	#siempre que la animacion sea la de entrar al portal, hace =>
	if anim_name == "entrar_portal":
		#es decir: cuando esta animacion termine, ejecutara esta animacion
		animacion_personaje.play("oscurecer")
