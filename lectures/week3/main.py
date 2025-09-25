"""
TECNOLOGÍA DE LA PROGRAMACIÓN - SESIÓN DE PRÁCTICAS SEMANA II

PABLO CORBALÁN DE CONCEPCIÓN

DTIE MATEMÁTICAS Y FÍSICA UNIVERSIDAD DE MURCIA - CURSO 2025/26
"""
from poligono import Poligono, TipoForma, TipoRelacionLados
from punto import Punto
from linea import Linea

if __name__ == '__main__':
    # DEFINICIONES DE LA SESIÓN 2
    mi_poligono = Poligono(3, TipoForma.CONVEXO, TipoRelacionLados.REGULAR, "rojo")
    mi_poligono2:Poligono = Poligono(5, TipoForma.CONCAVO)
    puntoA:Punto = Punto(-2, 2)
    puntoB:Punto = Punto(2, 2)
    puntoC:Punto = Punto(-2, -2)
    puntoD:Punto = Punto(2, -2)
    linea1:Linea = Linea(puntoA, puntoB)
    linea2:Linea = Linea(puntoB, puntoD)
    linea3:Linea = Linea(puntoD, puntoC)
    linea4:Linea = Linea(puntoC, puntoA)

    # PROBLEMA 3
    print(mi_poligono)
    mi_poligono.set_color("azul")
    mi_poligono.set_forma(TipoForma.CONVEXO)
    mi_poligono.set_relacion_lados(TipoRelacionLados.REGULAR)
    print(mi_poligono)

    print(f"Ejemplo de consulta usando un método getter, color: {mi_poligono.get_color()}")

    # PROBLEMA 5
    mi_poligono3:Poligono = Poligono(4, TipoForma.CONVEXO, TipoRelacionLados.REGULAR, "rojo")
    mi_poligono4:Poligono = Poligono(5, TipoForma.CONVEXO)

    print(f"Ejemplo de consulta usando un método getter polígono 3, numero_lados: {mi_poligono3.get_numero_lados()}")
    print(f"Ejemplo de consulta usando un método getter polígono 3, forma: {mi_poligono3.get_forma().name}")
    print(f"Ejemplo de consulta usando un método getter polígono 3, relacion_lados: {mi_poligono3.get_relaccion_lados().name}")
    print(f"Ejemplo de consulta usando un método getter polígono 3, color: {mi_poligono3.get_color()}")

    mi_poligono3.set_color("verde")
    mi_poligono4.set_color("lila")
    mi_poligono4.set_forma(TipoForma.CONCAVO)

    print(mi_poligono3)
    print(mi_poligono4)

    # PROBLEMA 6
    ejemplo_punto:Punto = Punto(3,4)
    print(f"Ejemplo punto: {ejemplo_punto}")
    ejemplo_punto.set_coordenada_x(6)
    ejemplo_punto.set_coordenada_y(-2)
    print(ejemplo_punto)
