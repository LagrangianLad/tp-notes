class Pila {
  int[] elementos;

  Pila(int numeroDeElementos) {
    this.elementos = new int[numeroDeElementos];
  }

  void imprimir() {
    print("PILA --> ");
    for (int i = 0; i < this.elementos.length; i++) {
      print(this.elementos[i] + " ");
    }
    println("");
  }

  int posicionUltimoElemento() {
    int posicion = 0;
    while (posicion < this.elementos.length && this.elementos[posicion] != 0) {
      posicion++;
    }
    return posicion-1;
  }

  void anadir(int elemento) {
    if (this.posicionUltimoElemento() < this.elementos.length-1) {
      println("Elemento añadido");
      this.elementos[this.posicionUltimoElemento() + 1] = elemento;
    } else {
      println("Pila llena");
    }
  }

  int retirar() {
    if (this.posicionUltimoElemento() >= 0) {
      println("Elemento retirado");
      int elemento = this.elementos[this.posicionUltimoElemento()];
      this.elementos[this.posicionUltimoElemento()] = 0;
      return elemento;
    } else {
      println("Pila vacía");
      return -1;
    }
  }
}


void setup() {
  Pila pila = new Pila(3);
  pila.imprimir();
  pila.anadir(1);
  pila.imprimir();
  pila.anadir(2);
  pila.imprimir();
  pila.anadir(3);
  pila.imprimir();
  pila.anadir(4);
  println(pila.retirar());
  pila.imprimir();
  pila.retirar();
  pila.imprimir();
  pila.retirar();
  pila.imprimir();
  pila.retirar();
}
