void burbuja(int[] lista) {
  for (int i = 0; i < lista.length-1; i++) {
    // FUNDAMENTAL LA DECLARACIÓN DE ESTE FOR
    for (int j = 0; j < lista.length-i-1; j++) {
      if (lista[j+1] > lista[j]) {
        int aux = lista[j];
        lista[j] = lista[j+1];
        lista[j+1] = aux;
      }
    }
  }
}

void seleccion (int[] lista) {
  for (int i = 0; i < lista.length-1; i++) {
    int posicionMaximo = i;
    for (int j = i+1; j<lista.length; j++) {
      // ERROR TÍPICO, comparar lista[j] con lista[i] en lugar de con lista[posicionMaximo], que es el que guarda el máximo valor.
      if (lista[j] > lista[posicionMaximo]) {
        posicionMaximo = j;
      }
    }
    // INTERCAMBIO LA POSICION DE I POR LA POSICION DEL MÁXIMO
    int aux = lista[i];
    lista[i] = lista[posicionMaximo];
    lista[posicionMaximo] = aux;
  }
}

void insercion(int[] lista) {
  for (int i = 1; i < lista.length; i++) {
    int valorActual = lista[i];
    int posicion = i-1;

    while (posicion >= 0 && lista[posicion] >= valorActual) {
      // ERROR PONER AQUÍ ++posicion PORQUE LUEGO HAGO posicion-- Y ROMPERÍA TODO
      lista[posicion+1] = lista[posicion];
      posicion--;
    }
    lista[++posicion] = valorActual;
  }
}