object nave {
	var nivelOxigeno = 10
	var property jugadores = []
	var votos = []
	var cantidadImpostores
	var cantidadTripulantes
	
	method aumentarOxigenoEn(unaCantidad) {
		nivelOxigeno += unaCantidad
	}
	
	method disminuirOxigenoEn(unaCantidad) {
		nivelOxigeno -= unaCantidad
		self.verificarOxigeno()
	}
	
	method tareaRealizada() {
		if(self.todosCompletaronLasTareas()) {
			throw new Exception (message = "Ganaron los tripulantes")
		}
	}
	
	method todosCompletaronLasTareas() {
		return jugadores.all { jugador => jugador.completoLasTareas() }
	}
	
	method algunoTiene(unItem) {
		return jugadores.any { jugador => jugador.tiene(unItem) }
	}
	
	method algunoUse(unItem) {
		const jugador = jugadores.find { jugador => jugador.tiene(unItem) }
		jugador.usar(unItem)
	}
	
	method verificarOxigeno() {
		if(nivelOxigeno <= 0) {
			throw new Exception (message = "Ganaron los impostores")
		}
	}
	
	method serSaboteada(itemNecesario) {
		if(self.algunoTiene(itemNecesario)) {
			self.algunoUse(itemNecesario)
		} else {
			self.disminuirOxigenoEn(10)
		}
	}
	
	method algunJugadorNoSospechosos() {
		return jugadores.findOrDefault({ jugador => !jugador.esSospechoso() }, votoEnBlanco) 
	}
	
	method elMasSospechoso() {
		return jugadores.max { jugador => jugador.nivelDeSospecha() }
	}
	
	method jugadorConMochilaVacia() {
		return jugadores.findOrDefault ({ jugador => jugador.tieneMochilaVacia() }, votoEnBlanco)
	}
	
	method convocarVotacion() {
		votos = jugadores.map { jugador => jugador.votar() }
		const jugadorMasVotado = votos.max { jugador => votos.occurrencesOf(jugador) }
		jugadorMasVotado.expulsar()
		self.verificarGanador()
		votos = []
	}
	
	method expulsar(jugadorMasVotado) {
		jugadores.remove(jugadorMasVotado)
	}
	
	method verificarGanador() {
		if (cantidadImpostores == 0) {
			throw new Exception (message = "Ganaron los tripulantes")
		} else if (cantidadTripulantes == cantidadImpostores) {
			throw new Exception (message = "Ganaron los impostores")
		}
	}
	
	method disminuirCantidadImpostores() {
		cantidadImpostores -= 1
	}
	
	method disminuirCantidadTripulantes() {
		cantidadTripulantes -= 1
	}
	
}

object votoEnBlanco {
	method expulsar() {
		
	}
}
