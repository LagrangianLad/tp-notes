/*Dadas dos cadenas de tipo string, escribir un programa que compruebe cúantas veces está contenida una en la otra, sin contar
 mayúsculas.*/

char letraMinuscula(char letra) {
  // Por simplificar, voy a trabajar solo con textos que tengan vocales.
  char l = '-';
  switch (letra) {
  case 'A':
    l = 'a';
    break;
  case 'E':
    l = 'e';
    break;
  case 'I':
    l = 'i';
    break;
  case 'O':
    l = 'o';
    break;
  case 'U':
    l = 'u';
    break;
  };
  return l;
}

String textoMinuscula (String texto) {
  String resultado = "";
  for (int i = 0; i < texto.length(); i++) {
    char x = texto.charAt(i);
    if (x == 'A' || x == 'E' || x == 'I' || x == 'O' || x == 'U') {
      resultado += letraMinuscula(x);
    } else {
      resultado+=x;
    }
  }
  return resultado;
}


int contarContenidos(String s, String S) {
  s = textoMinuscula(s);
  S = textoMinuscula(S);
  int numeroDeContenidos = 0;

  for (int posicionLetra = 0; posicionLetra < (S.length() - s.length() + 1); posicionLetra++) {
    int posicionEnLaQueBusco = 0;

    while (posicionEnLaQueBusco < s.length() && s.charAt(posicionEnLaQueBusco) == S.charAt(posicionLetra + posicionEnLaQueBusco)) {
      posicionEnLaQueBusco++;
    }
    if (posicionEnLaQueBusco == s.length()) {
      numeroDeContenidos++;
    }
  }
  return numeroDeContenidos;
}

void setup() {
  println(contarContenidos("AEI", "AeIoUAEEAeiuOAEIaei")); // Cuatro veces
}
