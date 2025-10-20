//AGREGANDO CLASE NAVE EN GENERAL para que las otras naves puedan entender PROPULSAR
class Nave {
  var property velocidad 
  //const velocidadMaxima = 300000 
  method recibirAmenaza() //preguntar si esta bien dejarlo asi => esta bioen!
  
  method propulsar() {
		velocidad = 300000.min(velocidad + 20000) //mas claro
	/*f(velocidad + 20000 < velocidadMaxima){ // lo puedo hacer como una validacion, preguntar
		velocidad = velocidad + 20000
	} else {
		velocidad = velocidadMaxima
	}*/
  }
	method prepararseParaViajar(){
		velocidad = 300000.min(velocidad + 15000)
	}
  // velocidad = 300000.min(velocidad + 20000)
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

class NaveDeCargaConResiduosRadiactivos inherits NaveDeCarga{
	var sellado = false

	method sellarAlVacio() {
	  sellado = true
	}
	method sellado() = sellado

	override method recibirAmenaza() {
	  	velocidad = 0 //ffrenar
	} 
	override method prepararseParaViajar(){
		self.sellarAlVacio()
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
	override method prepararseParaViajar(){

		modo.prepararseParaViajar(self)
	}
}
object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}
	method prepararseParaViajar(nave){
		nave.emitirMensaje("Volvimos a la Base°")
	}

}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}
	method prepararseParaViajar(nave){
		nave.emitirMensaje("Volvimos a la Base°")
	}
}

