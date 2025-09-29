boolean capicua(int[] cifras) {
  if (cifras.length <= 1) {
    return true;
  }

  if (cifras[0] == cifras[cifras.length-1]) {
    int[] nuevasCifras = new int[cifras.length -2];
    for (int i = 0; i < nuevasCifras.length; i++) {
      nuevasCifras[i] = cifras[i+1];
    }
    return capicua(nuevasCifras);
  }

  return false;
}

void setup() {
  int[] cifrasCAP = {1, 2, 2, 1};
  println(capicua(cifrasCAP));
  int[] cifrasNOCAP = {1, 2, 3, 1};
  println(capicua(cifrasNOCAP));
}
