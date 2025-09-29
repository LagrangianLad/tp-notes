/* PLAN DE ATAQUE

  1. APLASTAR LA MATRIZ EN UNA LISTA
  2. LIMPIO LA LISTA DE ELEMENTOS REPETIDOS
  3. CUENTO CUANTAS VECES APARECE CADA UNO DE ESTOS ELEMENTOS
  4. DESPÚES DE CONTAR CUANTAS VECES APARECE CADA ELEMENTO, SACO QUÉ ELEMENTO APARECE MÁS VECES
  5. IMPRIMO TODOS LOS ELEMENTOS QUE APAREZCAN *ESE (4)* NÚMERO DE VECES


*/

// APLASTO LA MATRIZ EN UNA LISTA
int[] aplastar(int[][][] matriz) {
  int[] matrizAplastada = new int[matriz.length * matriz[0].length * matriz[0][0].length];
  int posicion = 0;
  for (int i = 0; i < matriz.length; i++) {
    for (int j = 0; j < matriz[i].length; j++) {
      for (int k = 0; k < matriz[i][j].length; k++) {
        matrizAplastada[posicion] = matriz[i][j][k];
        posicion++;
      }
    }
  }
  return quitarCerosDeLaCola(matrizAplastada);
}

int contarCerosDeLaCola(int[] lista) {
  int contador = 0;
  int posicion = lista.length -1;
  while (posicion >= 0 && lista[posicion] == 0) {
    contador++;
    posicion--;
  }
  return contador;
}

int[] quitarCerosDeLaCola(int[] lista) {
  int t = lista.length - contarCerosDeLaCola(lista);
  int[] listaSinCola = new int[t];
  for (int i = 0; i < t; i++) {
    listaSinCola[i] = lista[i];
  }
  return listaSinCola;
}





// 2. LIMPIO LA LISTA DE ELEMENTOS REPETIDOS
boolean contenido(int elemento, int[] lista) {
  for (int i = 0; i < lista.length; i++) {
    if (lista[i] == elemento) {
      return true;
    }
  }
  return false;
}

int[] limpiarLista(int[] lista) {
  int[] listaLimpia = new int[lista.length];
  int posicion = 0;
  for (int i = 0; i < lista.length; i++) {
    if (!contenido(lista[i], listaLimpia)) {
      listaLimpia[posicion] = lista[i];
      posicion++;
    }
  }
  return quitarCerosDeLaCola(listaLimpia);
}




// 3. CUENTO CUANTAS VECES APARECE CADA UNO DE ESTOS ELEMENTOS
int numeroDeApariciones(int n, int[] lista) {
  int contador = 0;
  for (int i = 0; i < lista.length; i++) {
    if (lista[i] == n) {
      contador++;
    }
  }
  return contador;
}

int[][] contarApariciones (int[] elementos, int[] lista) {
  int[][] apariciones = new int[elementos.length][2];

  for (int i = 0; i < elementos.length; i++) {
    apariciones[i][0] = elementos[i];
    apariciones[i][1] = numeroDeApariciones(elementos[i], lista);
  }
  return apariciones;
}





// 4. DESPÚES DE CONTAR CUANTAS VECES APARECE CADA ELEMENTO, SACO QUÉ ELEMENTO APARECE MÁS VECES
int maximoNumeroDeApariciones(int[][] apariciones) {
  int maximo = 0;
  for (int i = 0; i < apariciones.length; i++) {
    if (apariciones[i][1] > maximo) {
      maximo = apariciones[i][1];
    }
  }
  return maximo;
}





//5. IMPRIMO TODOS LOS ELEMENTOS QUE APAREZCAN *ESE (4)* NÚMERO DE VECES
void moda(int[][] apariciones) {
  int maximo = maximoNumeroDeApariciones(apariciones);
  for (int i = 0; i < apariciones.length; i++) {
    if (apariciones[i][1] == maximo) {
      println(apariciones[i][0]);
    }
  }
}


int[][][] generarMatriz3D() {
  int dim1 = (int) random(1, 3);
  int dim2 = (int) random(1, 3);
  int dim3 = (int) random(1, 3);
  int[][][] matriz = new int[dim1][dim2][dim3];
  for (int i = 0; i < dim1; i++) {
    for (int j = 0; j < dim2; j++) {
      for (int k = 0; k < dim3; k++) {
        matriz[i][j][k] = (int) random(1, 10);
      }
    }
  }
  return matriz;
}


void setup() {
  int[][][] matriz = generarMatriz3D();
  moda(contarApariciones(limpiarLista(aplastar(matriz)), aplastar(matriz)));
}
