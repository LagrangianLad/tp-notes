/*Dado un número natural, determinar la cifra más grande que compone a ese número*/

int cifraMasGrande(int n) {
  if (n / 10 == 0) {
    return n;
  }

  if (n%10 > cifraMasGrande(n/10)) {
    return n%10;
  }

  return cifraMasGrande(n/10);
}

void setup() {
  println(cifraMasGrande(521));
  println(cifraMasGrande(123));
  println(cifraMasGrande(77168));
}
