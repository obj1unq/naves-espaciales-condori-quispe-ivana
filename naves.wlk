//AGREGANDO CLASE NAVE EN GENERAL para que las otras naves puedan entender PROPULSAR
class Nave {
  var property velocidad
  const velocidadMaxima = 300000 
  method recibirAmenaza() //preguntar si esta bien dejarlo asi
  
  method propulsar() {
	if(velocidad + 20000 < velocidadMaxima){ // lo puedo hacer como una validacion, preguntar
		velocidad = velocidad + 20000
	} else {
		velocidad = velocidadMaxima
	}
  }
}

class NaveDeCarga inherits Nave{

	//var velocidad = 0
	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	override method recibirAmenaza() {
		carga = 0
	}

}

class NaveDePasajeros inherits Nave{

	//var velocidad = 0
	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	//preguntar por este metodo
	method velocidadMaximaLegal() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaLegal() or alarma

	override method recibirAmenaza() {
		alarma = true
	}

}

class NaveDeCombate inherits Nave{
	//var property velocidad = 0
	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}
	
	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}

}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

}
