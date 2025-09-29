/* C--> E S T A M O S   E N    U  N     E  X  A  M  E  N
        0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19
 
 D --> AM
 
 La función devuelve 3 y 13
 */
void comparar(String C, String D) {
  for (int i = 0; i < C.length(); i++) {
    int posicion = 0;
    while (posicion < D.length() && C.charAt(i+posicion) == D.charAt(posicion)) {
      posicion++;
    }
    if (posicion == D.length()) {
      println(i);
    }
  }
}
void setup() {
  String C = "Estamos en un examen";
  String D = "am";
  comparar(C, D);
}
