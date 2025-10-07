"""
TECNOLOGÍA DE LA PROGRAMACIÓN - SESIÓN DE PRÁCTICAS SEMANA II

PABLO CORBALÁN DE CONCEPCIÓN

DTIE MATEMÁTICAS Y FÍSICA UNIVERSIDAD DE MURCIA - CURSO 2025/26
"""
from poligono import Poligono, TipoForma, TipoRelacionLados

from elementos_geometria.triangulo import Triangulo, TipoTriangulo, TrianguloEquilatero, TrianguloEscaleno, TrianguloIsosceles
from elementos_geometria.circulo import Circulo
from elementos_geometria.cuadrado import  Cuadrado

from punto import Punto
from linea import Linea

if __name__ == '__main__':
    # DEFINICIONES DE LA SESIÓN 5
    mi_poligono1 = Poligono(3, TipoForma.CONVEXO, TipoRelacionLados.REGULAR, "rojo")
    mi_poligono2:Poligono = Poligono(5, TipoForma.CONCAVO, TipoRelacionLados.REGULAR, "marrón")
    puntoA:Punto = Punto(-2, 2)
    puntoB:Punto = Punto(2, 2)
    puntoC:Punto = Punto(-2, -2)
    puntoD:Punto = Punto(2, -2)
    linea1:Linea = Linea(puntoA, puntoB)
    linea2:Linea = Linea(puntoB, puntoD)
    linea3:Linea = Linea(puntoD, puntoC)
    linea4:Linea = Linea(puntoC, puntoA)
    linea5:Linea = Linea(puntoD, puntoA)

    mi_poligono1.set_lados([linea1, linea2, linea3, linea4])
    # PROBLEMA 1
    mi_triangulo  = Triangulo(TipoTriangulo.ISOSCELES, TipoRelacionLados.REGULAR, "rojo")
    mi_triangulo.set_lados([linea1, linea2, linea5])
    print(mi_triangulo)

    # PROBLEMA 2
    mi_circulo1 = Circulo(5, puntoA, "azul")
    mi_circulo2 = Circulo(0.5, puntoB)
    mi_circulo1.eliminar_lado_aleatorio()
    mi_circulo1.get_vertices()
    mi_circulo1.calcular_vertices()
    print(f"Son vecinos círculo - círculo: {mi_circulo1.es_vecino(mi_circulo2)}")
    mi_poligono1.set_lados([linea1, linea2, linea5])
    print(f"Son vecinos círculo - polígono: {mi_circulo1.es_vecino(mi_poligono1)}")


    # PROBLEMA 3
    linea6:Linea = Linea(Punto(0, 0), Punto(3, 0))
    linea7:Linea = Linea(Punto(3, 0), Punto(3,3))
    linea8:Linea = Linea(Punto(3,3), Punto(0,3))
    linea9:Linea = Linea(Punto(0,3), Punto(9,0))
    linea10:Linea = Linea(Punto(0,3), Punto(0,0))
    mi_cuadrado1 = Cuadrado(lados=[linea6, linea7, linea8, linea9])
    print(mi_cuadrado1)
    print(f"Área del cuadrado 1: {mi_cuadrado1.calcular_area()}")
    mi_cuadrado2 = Cuadrado("azul")
    print(mi_cuadrado2)
    print(f"Mi cuadrado 2, longitud: {mi_cuadrado2.get_longitud_diagonal()}")

    # PROBLEMA 4
    triangulo_isosceles = TrianguloIsosceles("verde", lados=[linea6, linea7, linea10])
    print(triangulo_isosceles)