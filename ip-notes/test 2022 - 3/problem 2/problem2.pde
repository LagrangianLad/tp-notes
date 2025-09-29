boolean esPrimo(int n) {
  for (int i = 2; i < sqrt(n)+1; i++) {
    // No tiene sentido mirar más allá de la raíz, porque si hubiera algún divisor (digamos p)
    // más allá de la raíz, entonces hay dos posibilidades:
    //   - n = p * un número más grande que p (en particular, mayor que la raíz de n) es imposible
    //     porque sucede solo si n < n
    //   - n = p * un número más pequeño que p (será más pequeño que la raíz de n, lo habría encontrado)
    //     antes
    if (n%i == 0) {
      return false;
    }
  }
  return true;
}

int primorial(int numero) {
  int total = 1;
  for (int i = 2; i < numero; i++) {
    if (esPrimo(i)) {
      total += i;
    }
  }
  return total;
}

int sumarPrimoriales(int a, int b) {
  int suma = 0;
  for (int i = a; i<=b; i++) {
    suma+=primorial(i);
  }
  return suma;
}

void setup() {
  int numero1 = (int) random(0, 100);
  int numero2 = (int) random(0, 100);

  while (numero1 > numero2) {
    numero1 = (int) random(0, 100);
    numero2 = (int) random(0, 100);
  }

  println(sumarPrimoriales(numero1, numero2));
}
