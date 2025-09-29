int[][] crearMatrizCuadrada(int n) {
  int[][] mat = new int[n][n];
  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      mat[i][j] = (int) random(0, 10);
    }
  }
  return mat;
}

void imprimir(int[][] matriz) {
  for (int i = 0; i < matriz.length; i++) {
    for (int j = 0; j < matriz[0].length; j++) {
      print(matriz[i][j]);
    }
    println();
  }
}

int[]diagonalSecundaria(int[][] matriz) {
  int[] diagonal = new int [matriz.length];
  for (int fil = 0; fil < matriz.length; fil++) {
    diagonal[fil] = matriz[fil][matriz.length-fil-1];
  }
  return diagonal;
}

boolean sonIguales(int[][] m1, int[][] m2) {
  for (int i = 0; i < m1.length; i++) {
    for (int j = 0; j < m1[0].length; j++) {
      if (m1[i][j] != m2[i][j]) {
        return false;
      }
    }
  }
  return true;
}

int[][] transpuesta(int[][] matriz) {
  int[][] trans = new int[matriz[0].length][matriz.length];
  for (int i = 0; i < matriz.length; i++) {
    for (int j = 0; j < matriz[0].length; j++) {
      trans[i][j] = matriz[j][i];
    }
  }
  return trans;
}

void setup() {
  int[][] matriz = crearMatrizCuadrada(5);
  imprimir(matriz);
  println(diagonalSecundaria(matriz));
  println("-------");
  
  if (sonIguales(matriz, transpuesta(matriz))) {
    println("Son iguales");
  } else {
    println("No son iguales");
  }
}
