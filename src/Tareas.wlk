import Jugadores.*
import Nave.*

class Tarea {
	const itemsNecesarios = []
	
	method puedeRealizarla(unTripulante) {
		return itemsNecesarios.all { item => unTripulante.tiene(item) }
	}
	
	method esRealizadaPor(unTripulante) {
		itemsNecesarios.forEach { item => unTripulante.usar(item) }
	}
}

object arreglarElTableroElectrico inherits Tarea(itemsNecesarios = ["Llave inglesa"]) {
	
	override method esRealizadaPor(unTripulante) {
		super(unTripulante)
		unTripulante.aumentarNivelDeSospechaEn(10)
	}
}

object sacarLaBasura inherits Tarea(itemsNecesarios = ["Escoba", "Bolsa De Consorcio"]) {
	
	override method esRealizadaPor(unTripulante) {
		super(unTripulante)
		unTripulante.disminuirNivelDeSospechaEn(4)
	}
}

object ventilarLaNave inherits Tarea(itemsNecesarios = []) {
	
	override method esRealizadaPor(_) { 
		nave.aumentarOxigenoEn(5)
	}
}
