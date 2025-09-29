/*Dada una matriz tridimensional como colección de matrices bidimensionales se pide:*/

// APARTADO 1. Para cada matriz bidimensional Mi:

// 1.i ] Si Mi tiene algún número primo, devolver el producto de todos sus primos.
boolean tieneAlgunPrimo(int[][] matriz) {
  for (int i = 0; i < matriz.length; i++) {
    for (int j = 0; j < matriz[i].length; j++) {
      if (esPrimo(matriz[i][j])) {
        return true;
      }
    }
  }
  return false;
}

boolean esPrimo(int n) {
  for (int i = 2; i < n-1; i++) {
    if (n%i == 0) {
      return false;
    }
  }
  return true;
}

int contarPrimos(int[][] m) {
  int contador = 0;
  for (int i = 0; i < m.length; i++) {
    for (int j = 0; j < m[i].length; j++) {
      if (esPrimo(m[i][j])) {
        contador++;
      }
    }
  }
  return contador;
}

int[] listaDePrimos(int[][] m) {
  int[] primos = new int[contarPrimos(m)];
  int primosEncontrados = 0;
  for (int i = 0; i < m.length; i++) {
    for (int j = 0; j < m[i].length; j++) {
      if (esPrimo(m[i][j])) {
        primos[primosEncontrados] = m[i][j];
        primosEncontrados++;
      }
    }
  }
  return primos;
}

int multiplicarLista(int[] lista) {
  int resultado = 1;
  for (int i = 0; i < lista.length; i++) {
    resultado = resultado * lista[i];
  }
  return resultado;
}


int multiplicarTodosLosPrimos(int[][] m) {
  return multiplicarLista(listaDePrimos(m));
}


// 1.ii ] En caso contrario, devolver la media aritmética de sus valores con un p% de probabilidad. Con un 1-p% de probabilidad
//        devolver un elemento intermedio entre el menor y el mayor
float mediaAritmetica2D(int[][] m) {
  int suma = 0;
  for (int i = 0; i < m.length; i++) {
    for (int j = 0; j < m[i].length; j++) {
      suma+=m[i][j];
    }
  }
  return (suma / (float) (m.length*m[0].length));
}

int mayor2D(int[][] m) {
  int maximo = 0;
  for (int i = 0; i < m.length; i++) {
    for (int j = 0; j < m[i].length; j++) {
      if (m[i][j] > maximo) {
        maximo = m[i][j];
      }
    }
  }
  return maximo;
}

int menor2D(int[][] m) {
  int minimo = mayor2D(m);
  for (int i = 0; i < m.length; i++) {
    for (int j = 0; j < m[i].length; j++) {
      if (m[i][j] < minimo) {
        minimo = m[i][j];
      }
    }
  }
  return minimo;
}

int elementoIntermedio(int[][] m) {
  return (int) random(menor2D(m), mayor2D(m));
}







// APARTADO 2. En función de un parámetro op dado:

// 2.i ] Si op == 1, devolver el máximo de todos sus valores.
int maximoDeTodosLosValores(int[][][] matriz) {
  int maximo = 0;
  for (int i = 0; i < matriz.length; i++) {
    if (mayor2D(matriz[i]) > maximo) {
      maximo = mayor2D(matriz[i]);
    }
  }
  return maximo;
}

// 2.ii ] Si op == 2, devolver el mínimo de todos sus valores.
int minimoDeTodosLosValores(int[][][] matriz) {
  int minimo = maximoDeTodosLosValores(matriz);
  for (int i = 0; i < matriz.length; i++) {
    if (menor2D(matriz[i]) < minimo) {
      minimo = menor2D(matriz[i]);
    }
  }
  return minimo;
}

// 2.iii ] Si op == 3, devolver la media aritmética de sus valores.
int mediaAritmeticaDeTodosLosValores(int[][][] matriz) {
  int suma = 0;
  for (int i = 0; i < matriz.length; i++) {
    for (int j = 0; j < matriz[i].length; j++) {
      for (int k = 0; k < matriz[i][j].length; k++) {
        suma+=matriz[i][j][k];
      }
    }
  }
  int numeroElementos = matriz.length * matriz[0].length * matriz[0][0].length;
  return suma / numeroElementos;
}

int realizarOperacion(int[][][] matriz, int op) {
  int valor = -1;
  switch (op) {
  case 1:
    valor= maximoDeTodosLosValores(matriz);
  case 2:
    valor= minimoDeTodosLosValores(matriz);
  case 3:
    valor= mediaAritmeticaDeTodosLosValores(matriz);
  }
  return valor;
}





// APARTADO 3. Escriba un programa principal que:

// 3.i ] Imprima la matriz por pantalla
void imprimirMatriz2D(int[][] m) {
  for (int i = 0; i < m.length; i++) {
    for (int j = 0; j < m[i].length; j++) {
      print(m[i][j] + "  ");
    }
    println();
  }
}
void imprimirMatriz3D(int[][][] matriz) {
  for (int i = 0; i < matriz.length; i++) {
    println("MATRIZ " + i);
    imprimirMatriz2D(matriz[i]);
    println("--------------------");
  }
}

// 3.ii ] Genere automáticamente la matriz tridimensional
int[][] generarMatriz2D(int ancho, int alto) {
  int[][] m = new int[ancho][alto];
  for (int i = 0; i < m.length; i++) {
    for (int j = 0; j < m[i].length; j++) {
      m[i][j] = (int) random(1, 10);
    }
  }
  return m;
}

int[][][] generarMatrizAleatoria () {
  int ancho = (int) random(1, 10);
  int alto = (int) random(1, 10);
  int profundidad = (int) random(1, 10);

  int[][][] matriz = new int[profundidad][ancho][alto];
  for (int i = 0; i < profundidad; i++) {
    matriz[i] = generarMatriz2D(ancho, alto);
  }
  return matriz;
}


void setup() {
  int[][][] matriz = generarMatrizAleatoria();

  float probabilidad = random(0, 1);
  println("\nPROBABILIDAD: " + probabilidad);
  int op = (int) random(1, 4);
  println("OPERACIÓN: " + op);

  imprimirMatriz3D(matriz);

  // APARTADO 1
  for (int i = 0; i < matriz.length; i++) {
    println("APARTADO 1, MATRIZ " + i);
    int[][] m = matriz[i];
    if (tieneAlgunPrimo(m)) {
      println("MULTIPLICACIÓN DE PRIMOS " + multiplicarTodosLosPrimos(m));
    } else {
      if (random(0, 1) < probabilidad) {
        println("MEDIA ARITMÉTICA " + mediaAritmetica2D(m));
      } else {
        println("ELEMENTO INTERMEDIO " + elementoIntermedio(m));
      }
    }
  }


  // APARTADO 2
  println("OPERACIÓN " + realizarOperacion(matriz, op));
}
