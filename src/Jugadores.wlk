import Tareas.*
import Nave.*
import Personalidades.*

class Jugador {
	var mochila = []
	var property nivelDeSospecha = 40
	
	method esSospechoso() {
		return nivelDeSospecha > 50
	}
	
	method buscarItem(unItem) {
		mochila.add(unItem)
	}
	
	method tiene(unItem) {
		return mochila.contains(unItem)
	}
	
	method aumentarNivelDeSospechaEn(unaCantidad) {
		nivelDeSospecha += unaCantidad
	}
	
	method disminuirNivelDeSospechaEn(unaCantidad) {
		nivelDeSospecha -= unaCantidad
	}
	
	method usar(unItem) {
		mochila.remove(unItem)
	}
	
	method llamarAReunionDeEmergencia() {
		nave.convocarVotacion()
	}
	
	method tieneMochilaVacia() {
		return mochila.isEmpty()
	}
	
	method expulsar() {
		nave.expulsar(self)
		self.informarExpulsion()
	}
	
	method informarExpulsion()
	
}

class Tripulante inherits Jugador {
	const tareas = []
	var impugnado = false
	var personalidad
	
	method realizarTarea() {
		const unaTarea = tareas.anyOne()
		if(unaTarea.puedeRealizarla(self)) {
			unaTarea.esRealizadaPor(self)
			tareas.remove(unaTarea)
			nave.tareaRealizada()
		} else {
			throw new Exception (message = "La tarea no puede ser completada")
		}
	}
	
	method completoLasTareas() {
		return tareas.isEmpty()
	}
	
	method votar() {
		if(impugnado) {
			impugnado = false
			return votoEnBlanco 
		} else {
			return personalidad.votar()
		}
	}
	
	override method informarExpulsion() {
		nave.disminuirCantidadTripulantes()
	}
	
	method impugnarProximoVoto() {
		impugnado = true
	}
	
}

class Impostor inherits Jugador {
	
	method completoLasTareas() {
		return true
	}
	
	method realizarUnaTarea(unaTarea) {}
	
	method realizarSabotaje(unSabotaje) {
		self.aumentarNivelDeSospechaEn(5)
		unSabotaje.sabotear()
	}
	
	method votar() {
		return nave.jugadores().anyOne()
	}
	
	override method informarExpulsion() {
		nave.disminuirCantidadImpostores()
	}
}