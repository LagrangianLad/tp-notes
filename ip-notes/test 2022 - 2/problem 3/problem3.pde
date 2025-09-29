char minuscula(char c) {
  char val;
  switch (c) {
  case 'A':
    val = 'a';
    break;
  case 'E':
    val = 'e';
    break;
  case 'I':
    val = 'i';
    break;
  case 'O':
    val = 'o';
    break;
  case 'U':
    val = 'u';
    break;
  default:
    val = c;
  }
  return val;
}

int numeroDeVecesQueAparece(char letra, String C) {
  int contador = 0;
  for (int i = 0; i < C.length(); i++) {
    if (minuscula(C.charAt(i)) == minuscula(letra)) {
      contador++;
    }
  }
  return contador;
}

void setup() {
  String C = "aeiouaeiouaeioua"; // cuatro a's
  char letra = 'a';
  println(numeroDeVecesQueAparece(letra, C));
}
