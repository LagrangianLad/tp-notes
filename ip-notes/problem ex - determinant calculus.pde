int[][] quitarColumna(int[][] matriz, int pos) {
  int[][] resultado = new int [matriz.length][matriz[0].length-1];

  for (int i = 0; i < matriz.length; i++) {
    for (int j = 0; j < matriz[i].length; j++) {
      if (j < pos) {
        resultado[i][j] = matriz[i][j];
      } else if (j > pos) {
        resultado[i][j-1] = matriz[i][j];
      }
    }
  }

  return resultado;
}

int [][] quitarFila(int[][] matriz, int pos) {
  int[][] resultado = new int [matriz.length-1][matriz[0].length];

  for (int i = 0; i < matriz.length; i++) {
    if (i < pos) {
      resultado[i] = matriz[i];
    } else if (i > pos) {
      resultado[i-1] = matriz[i];
    }
  }

  return resultado;
}

int[][] menorMatricial (int[][] m, int fila, int columna) {
  return quitarColumna(quitarFila(m, fila), columna);
}

int det(int [][] m) {
  if (m.length == 1) {
    return m[0][0];
  }
  int resultado = 0;
  final int COL = 0; // Columna por la que desarrollo
  for (int fila = 0; fila < m.length; fila ++) {
    // DET = a00 * Adj00 + a10 * Adj10 + a20 * Adj20 + .... + aN0 * Adj N0
    resultado += m[fila][COL] * pow(-1, fila+COL) * det(menorMatricial(m, fila, COL));
  }
  return resultado;
}

void setup () {
  int[][] M = {
    { 1, 4, 3, 6 },
    { 2, 4, 9, 2 },
    { 5, -2, 8, -3},
    { 1, 7, 8, -1}
  }; // -725
  println(det(M));
}
