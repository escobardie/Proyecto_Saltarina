extends Node

#script con patron singleton, quiere decir que no se vera afectado
#por los efectos de juego
#lo que esta aqui, persiste mas alla del reinicio de la escena


signal actualizar_datos()
#señal para el menu de juego terminado
signal s_game_over()


#VARIABLES PARA EL HUD
var moneda_oro = 0
var moneda_plata = 0
var moneda_bronce = 0
var puntaje_monedas = 0
var vidas = 3
var llaves = 0


#esta variable (que me la cargo la escena DE NIVEL) la estara usando menu game over 
var nivel_actual = ""
#usaremos esta variable para identificar y nombre el nivel en el que estamos
var numero_nivel = ""


#metodo para restablecer los valores, esto pasara cuando estemos en la escena de GAMEOVER
#se ejecutara ni bien perdamos (definida en menugameover)
func reset():
	vidas = 3
	moneda_bronce = 0
	moneda_plata = 0
	moneda_oro = 0
	puntaje_monedas = 0


#metodo para calcular los puntos al momento de ganar la partida
func generar_puntaje():
	var valor_oro = moneda_oro * 100
	var valor_plata = moneda_plata * 50
	var valor_bronce = moneda_bronce * 20
	puntaje_monedas = valor_bronce + valor_plata + valor_oro
	return puntaje_monedas


func restar_vidas():
	vidas -= 1
	if vidas == 0:
		#emitimos la señal
		emit_signal("s_game_over")
	emit_signal("actualizar_datos")


func restar_llaves():
	llaves -= 1
	emit_signal("actualizar_datos")


func contabilizar_llaves(valor):
	llaves = valor
	emit_signal("actualizar_datos")


func sumar_monedas(moneda):
	match moneda:
		"bronce":
			moneda_bronce += 1
		"plata":
			moneda_plata += 1
		"oro":
			moneda_oro += 1
		_:
			print("ERROR")
	emit_signal("actualizar_datos")
