import Nave.*

object reducirOxigeno {
	
	method sabotear() {
		nave.serSaboteada("Tubo de oxigeno")
	}
}
	
class ImpugnarAUnJugador {
	var unJugador
	
	method sabotear() {
		unJugador.impugnarProximoVoto()
	}
}
