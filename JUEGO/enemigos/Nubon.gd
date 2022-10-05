extends Node2D

export var rayo: PackedScene #es una escena empaquetada de lo que yo le ponga

var puede_disparar = true

onready var detector_personaje = $Sprite/RayCast2D #llamamos al detecto que creamos
onready var posiciones_disparo = $Sprite/PosicionesDisparo #llamamos a los disparos contenidos dentro del Nodo2D
onready var timer_disparo = $Timer #llamada al controlador de disparos
onready var sonido_rayo = $Rayos #llamados al nodo de sonido


func _process(_delta): # solo usaremos deteccion
	 #si detector esta colisionando hacemos lo siguiente y puede_disparar es true
	if detector_personaje.is_colliding() and puede_disparar:
		disparar()
		puede_disparar = false #CON UNA vez que dispare, ya deje de disparar
		timer_disparo.start() #prendemos/activamos(el timer) la cadencia de disparos


func disparar():
	sonido_rayo.play() #cada vez que dispara sonara el sonido del rayo
	#por cada posicion adentro de posiciones_disparo, devolveme todos tus hijo DETRO DEL NODO
	for posicion in posiciones_disparo.get_children():
		#esta variable sera una instancia de la escena empaquetado que fue previamente guardad
		var nuevo_rayo = rayo.instance()
		#ese nuevo rayo que llame a crear y le pase la posicion blobal de cada POSICION DENTRO DEL FOR
		nuevo_rayo.crear(posicion.global_position)
		#es un metodo que instancia "nuevo rayo"
		#add_child(nuevo_rayo)
		#creamos un contenedor de rayos dentro de un Nodo"Rayo"
		#basicamente la tarea de esto es: un lugar donde guardar las instancias de rayo
		owner.get_node("Rayos").add_child(nuevo_rayo)
		#owner.get_node = buscame un nodo, que se llama "Rayos" y guardamelos ahi


func _on_Timer_timeout(): #se crea un timer justamente para controlar el tiempo de disparo
	#una vez que el timer vuelva a CERO, hacemos esto
	puede_disparar = true #se reactivan los disparos
