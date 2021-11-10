import Nave.*

object troll {
	method votar() {
		return nave.algunJugadorNoSospechosos()
	}
	
}

object detective {
	method votar() {
		return nave.elMasSospechoso()
	}
}

object materialista {
	method votar() {
		return nave.jugadorConMochilaVacia()
	}
}