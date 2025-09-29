class Punto {
  float x;
  float y;
  float z;
}

class Rectangulo {
  Punto coordenada;
  float lado1;
  float lado2;
  String c;

  Rectangulo(float x, float y, float z, float lado1, float lado2, String c) {
    Punto p = new Punto();
    p.x = x;
    p.y = y;
    p.z = z;
    this.coordenada = p;
    this.lado1 = lado1;
    this.lado2 = lado2;
    this.c = c;
  }

  float area() {
    return this.lado1*this.lado2;
  }

  float perimetro() {
    return 2*(this.lado1+this.lado2);
  }
}

void setup() {
  Rectangulo r = new Rectangulo(0, 0, 0, 10, 20, "Rojo");
  println(r.area());
  println(r.perimetro());
}
