class Fecha {
  int dia;
  int mes;
  int ano;

  void imprimir() {
    println(dia + "/" + mes + "/" + ano);
  }

  boolean anterior(Fecha f) {
    if (ano <= f.ano) {
      if (mes <= f.mes) {
        if (dia <= f.dia) {
          return true; // consideramos verdadero si son iguales, nos la pela
        }
      }
    }
    return false;
  }
}

Fecha crearFecha() {
  Fecha f = new Fecha();
  f.dia = (int) random(1, 32);
  f.mes = (int) random(1, 13);
  f.ano = (int) random(1900, 2001);

  if (f.mes == 2) {
    f.dia = (int)random(1, 29);
  }

  if (f.dia == 31 && (f.mes == 4 || f.mes == 6 || f.mes == 9 || f.mes == 11)) {
    f.dia = (int) random(1, 30);
  }
  return f;
}

int[][] generarMatrizDeFechas (int numeroDeFechas) {
  int[][] m = new int[3][numeroDeFechas];
  for (int i = 0; i < numeroDeFechas; i++) {
    Fecha fechaAux = crearFecha();
    m[0][i] = fechaAux.dia;
    m[1][i] = fechaAux.mes;
    m[2][i] = fechaAux.ano;
  }
  return m;
}

void imprimirMatrizDeFechas(int[][] m) {
  for (int i = 0; i < m[0].length; i++) {
    Fecha fechaAux = new Fecha();
    fechaAux.dia = m[0][i];
    fechaAux.mes = m[1][i];
    fechaAux.ano = m[2][i];
    print("Fecha " + i + ": " );
    fechaAux.imprimir();
  }
}

void ordenar(int[][] matriz) {
  int numeroFechas = matriz[0].length;
  for (int i = 0; i < numeroFechas-1; i++) {
    for (int j = i+1; j < numeroFechas; j++) {
      // Burbuja
      Fecha fecha1 = new Fecha();
      Fecha fecha2 = new Fecha();

      fecha1.dia = matriz[0][i];
      fecha1.mes = matriz[1][i];
      fecha1.ano = matriz[2][i];
      fecha2.dia = matriz[0][j];
      fecha2.mes = matriz[1][j];
      fecha2.ano = matriz[2][j];

      if (fecha1.anterior(fecha2)) {
        // Les doy la vuelta en la matriz
        matriz[0][i] = fecha2.dia;
        matriz[1][i] = fecha2.mes;
        matriz[2][i] = fecha2.ano;
        matriz[0][j] = fecha1.dia;
        matriz[1][j] = fecha1.mes;
        matriz[2][j] = fecha1.ano;
      }
    }
  }
}

void setup() {

  int[][] m = generarMatrizDeFechas(3);
  imprimirMatrizDeFechas(m);
  ordenar(m);
  println("--------------");
  imprimirMatrizDeFechas(m);
}
