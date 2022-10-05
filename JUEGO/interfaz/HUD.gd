extends Control


#contenedor vidas tiene un texto (donde figura las vidas), que se llama cantidad
onready var etiqueta_vidas = $ContenedorVidas/Cantidad
#variables para las etiqueta de las monedas
onready var etiqueta_moneda_oro = $ContenedorMonedasOro/Cantidad
onready var etiqueta_moneda_plata = $ContenedorMonedasPlata/Cantidad
onready var etiqueta_moneda_bronce = $ContenedorMonedasBronce/Cantidad
onready var etiqueta_llaves = $ContenedorLlaves/Cantidad
onready var etiqueta_nombre = $ContenedorNombre/Cantidad


func _ready():
	#conecto la señal creada en datosPlayer, con este script y conecto con la func actualizar_hud
# warning-ignore:return_value_discarded
	DatosPlayer.connect("actualizar_datos", self, "actualizar_hud")
	#llamo al metodo para que se genere la actualizacion en la pantalla
	actualizar_hud()


func actualizar_hud():
	#de la etiqueta, queremos el texto. ese texto son los datos de vida dentro del-
	#sript de datos_player
	#con los comandos   "%s" %  convertimos una cadena de numero a string
	etiqueta_vidas.text = "%s" % DatosPlayer.vidas
	etiqueta_moneda_oro.text = "%s" % DatosPlayer.moneda_oro
	etiqueta_moneda_plata.text = "%s" % DatosPlayer.moneda_plata
	etiqueta_moneda_bronce.text = "%s" % DatosPlayer.moneda_bronce
	etiqueta_llaves.text = "%s" % DatosPlayer.llaves
	etiqueta_nombre.text = "nivel: %s" % DatosPlayer.numero_nivel
