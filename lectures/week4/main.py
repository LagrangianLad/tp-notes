"""
TECNOLOGÍA DE LA PROGRAMACIÓN - SESIÓN DE PRÁCTICAS SEMANA II

PABLO CORBALÁN DE CONCEPCIÓN

DTIE MATEMÁTICAS Y FÍSICA UNIVERSIDAD DE MURCIA - CURSO 2025/26
"""
from poligono import Poligono, TipoForma, TipoRelacionLados
from punto import Punto
from linea import Linea
import copy

if __name__ == '__main__':
    # DEFINICIONES DE LA SESIÓN 3
    mi_poligono = Poligono(3, TipoForma.CONVEXO, TipoRelacionLados.REGULAR, "rojo")
    mi_poligono2:Poligono = Poligono(5, TipoForma.CONCAVO, TipoRelacionLados.REGULAR, "marrón")
    puntoA:Punto = Punto(-2, 2)
    puntoB:Punto = Punto(2, 2)
    puntoC:Punto = Punto(-2, -2)
    puntoD:Punto = Punto(2, -2)
    linea1:Linea = Linea(puntoA, puntoB)
    linea2:Linea = Linea(puntoB, puntoD)
    linea3:Linea = Linea(puntoD, puntoC)
    linea4:Linea = Linea(puntoC, puntoA)

    # PROBLEMA 1
    print(f"Distancia entre (0,0) y ( -1, -1) = {Punto(0,0).distancia_manhatan(Punto(-1,-1))}")
    print("=====================================================================================")
    # PROBLEMA 2
    puntoO:Punto = Punto(0,0)
    lados_poligono3:list[Linea] = [
        Linea(puntoO, Punto(2, 0)),
        Linea(Punto(2,0), Punto(1, 1)),
        Linea(Punto(1,1), puntoO)
    ]
    lados_poligono4:list[Linea] = [
        Linea(puntoO, Punto(1,0)),
        Linea(Punto(1,0), Punto(1,1)),
        Linea(Punto(1,1), Punto(0,1)),
        Linea(Punto(1,0), puntoO)
    ]
    lados_poligono5:list[Linea] = [
        Linea(Punto(40, 40), Punto(41, 41)),
        Linea(Punto(41, 41), Punto(40, 45)),
        Linea(Punto(40, 45), Punto(40,  40))
    ]
    mi_poligono3:Poligono = Poligono(3)
    mi_poligono4:Poligono = Poligono(4)
    mi_poligono5:Poligono = Poligono (3)

    mi_poligono3.set_lados(lados_poligono3)
    mi_poligono4.set_lados(lados_poligono4)
    mi_poligono5.set_lados(lados_poligono5)

    mi_poligono3.agregar_vecino(mi_poligono4)
    mi_poligono3.agregar_vecino(mi_poligono5)

    print(f"VECINOS DEL POLÍGONO 3: {mi_poligono3.get_poligonos_vecinos()}")
    print(f"VECINOS DEL POLÍGONO 4: {mi_poligono4.get_poligonos_vecinos()}")
    print("=====================================================================================")

    # PROBLEMA 3
    print("VÉRTICES DEL POLÍGONO 3: ")
    for punto in mi_poligono3.get_vertices():
        print(punto)
    print("=====================================================================================")

    # PROBLEMA 4, CLONACIÓN
    print(f"ANTES DE LA COPIA (POLIGONOS ORIGINALES): POLIGONO 1\n\t{mi_poligono} POLIGONO 2\n\t{mi_poligono2} ")
    copia_superficial_poligono:Poligono = copy.copy(mi_poligono)
    copia_profunda_poligono:Poligono = copy.deepcopy(mi_poligono2)

    copia_superficial_poligono.set_color("NARANJA")
    copia_profunda_poligono.set_color("LILA")

    print(f"DESPUES DE LA COPIA (POLIGONOS ORIGINALES): POLIGONO 1\n\t{mi_poligono} POLIGONO 2\n\t{mi_poligono2}")
    print(f"DESPUES DE LA COPIA (POLIGONOS COPIA): \n\t{copia_superficial_poligono} \n\t{copia_profunda_poligono}")
    print("=====================================================================================")

    # PROBLEMA 5
    puntoE:Punto = Punto(3, 2)
    puntoF:Punto = Punto(-1, 5)
    lineaEF:Linea = Linea(puntoE, puntoF)
    print(f"EL PUNTO E PERTENECE A LA LÍNEA {puntoE.get_linea_pertenece()}")
    print(f"EL PUNTO F PERTENECE A LA LÍNEA {puntoF.get_linea_pertenece()}")

    mi_poligono6:Poligono = Poligono(3)
    mi_poligono6.set_lados([linea1, linea2, linea3])
    print(f"LINEA 1 PERTENECE A: {linea1.get_poligono_pertenece()}")
    print(f"LINEA 2 PERTENECE A: {linea2.get_poligono_pertenece()}")
    print(f"LINEA 3 PERTENECE A: {linea3.get_poligono_pertenece()}")