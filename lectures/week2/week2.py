"""
TECNOLOGÍA DE LA PROGRAMACIÓN - SESIÓN DE PRÁCTICAS SEMANA II

PABLO CORBALÁN DE CONCEPCIÓN

DTIE MATEMÁTICAS Y FÍSICA UNIVERSIDAD DE MURCIA - CURSO 2025/26
"""

from enum import Enum
import math

class Cuadrante(Enum):
    EJE = 0
    PRIMER_CUADRANTE = 1
    SEGUNDO_CUADRANTE = 2
    TERCER_CUADRANTE = 3
    CUARTO_CUADRANTE = 4

class Punto:

    def __init__(self, x:float, y:float):
        self._coordenada_x:float = x
        self._coordenada_y:float = y

    def __str__(self):
        return f"({self.obtener_coordenada_x()}, {self.obtener_coordenada_y()}) CUAD {self.obtener_cuadrante().name}"
    def obtener_coordenada_x(self) -> float:
        return self._coordenada_x

    def obtener_coordenada_y(self) -> float:
        return self._coordenada_y

    def obtener_cuadrante(self) -> Cuadrante:
        if self.obtener_coordenada_x() == 0 or self.obtener_coordenada_y() == 0:
            return Cuadrante.EJE
        elif self.obtener_coordenada_x() > 0:
            if self.obtener_coordenada_y() > 0:
                return Cuadrante.PRIMER_CUADRANTE
            return Cuadrante.CUARTO_CUADRANTE
        else:
            if self.obtener_coordenada_y() > 0:
                return Cuadrante.SEGUNDO_CUADRANTE
            return Cuadrante.TERCER_CUADRANTE

class Linea:

    def __init__(self, punto_inicio:Punto, punto_fin:Punto) -> None:
        self._punto_inicio:Punto = punto_inicio
        self._punto_fin:Punto = punto_fin

    def __str__(self) -> str:
        return f"LÍNEA ({self.obtener_punto_fin()}, {self.obtener_punto_fin()}) LONGITUD {self.calcular_longitud()}."
    def obtener_punto_inicio(self) -> Punto:
        return self._punto_inicio

    def obtener_punto_fin(self) -> Punto:
        return self._punto_fin

    def calcular_longitud(self) -> float:
        x1:float = self.obtener_punto_inicio().obtener_coordenada_x()
        y1:float = self.obtener_punto_inicio().obtener_coordenada_y()
        x2:float = self.obtener_punto_fin().obtener_coordenada_x()
        y2:float = self.obtener_punto_fin().obtener_coordenada_y()
        return math.sqrt(pow(x2-x1, 2) + pow(y2-y1, 2))

class TipoForma(Enum):
    CONVEXO = 1
    CONCAVO = 2
    COMPLEJO = 3

class TipoRelacionLados(Enum):
    REGULAR = 1
    IRREGURAL = 2

class Poligono:

    numero_poligonos = 0

    @classmethod
    def numero_poligonos_creados(cls):
        return cls.numero_poligonos

    def __init__(self,
                 forma:TipoForma,
                 relacion_lados:TipoRelacionLados,
                 numero_lados:int = 3,
                 color:str="BLANCO"):
        self._numero_lados:int = numero_lados
        self._color:str = color
        self._forma:TipoForma = forma
        self._relacion_lados:TipoRelacionLados = relacion_lados

        self._lados:list[Linea] = list()

        Poligono.numero_poligonos += 1

    def __str__(self) -> str:
        return f"Lados {self._numero_lados}, color {self._color}, forma {self._forma.name}, relación {self._relacion_lados.name}, perímetro {self.calcular_perimetro()}"

    #####################################################################
    # DUDA PARA PREGUNTAR: CUANDO QUIERO TIPAR "otro" ME DA ERROR, ¿ENTIENDO QUE ES PORQUE LA CLASE NO ESTÁ DECLARADA TODAVÍA?
    # ¿NO PUEDO ESPECIFICAR otro:Poligono DESDE LA PROPIA CLASE POLÍGONO?
    #####################################################################

    def __eq__(self, otro) -> bool:
        return True if self.obtener_numero_lados() == otro.obtener_numero_lados() else False

    def __add__(self, otro) -> int:
        return self.calcular_perimetro() + otro.calcular_perimetro()

    def __lt__(self, otro) -> bool:
        return True if self.calcular_perimetro() <= otro.calcular_perimetro() else False

    def __len__(self) -> int:
        return self.obtener_numero_lados()

    def obtener_numero_lados(self) -> int:
        return self._numero_lados

    def obtener_color(self) -> str:
        return self._color

    def obtener_forma(self) -> TipoForma:
        return self._forma

    def obtener_relacion_lados(self) -> TipoRelacionLados:
        return self._relacion_lados

    def modificar_numero_lados(self, nuevo_numero_lados:int) -> str:
# LOS MÉTODOS PARA MODIFICAR ATRIBUTOS SON ÚTILES PARA CONTROLAR LOS ERRORES ANTES DE LA ASIGNACIÓN
         if nuevo_numero_lados < 3:
            return "Error: el número de lados ha de ser mayor o igual que 3"
         self._numero_lados = nuevo_numero_lados
# AUNQUE EN LA CLASE SIEMPRE PUEDO ACCEDER AL ATRIBUTO, ES MEJOR IDEA CONSULTAR EL MÉTODO
         return f"Ok, se han establecido { self.obtener_numero_lados() } en el polígono"

    def calcular_perimetro(self) -> float:
        perimetro:float = 0
        for lado in self._lados:
            perimetro+=lado.calcular_longitud()
        return perimetro

    def establecer_lados(self, lineas:list[Linea]) -> bool:
        if len(lineas) != self.obtener_numero_lados():
            print("No se han podido establecer las líneas como lados del polígono.")
            return False
        print(f"Lineas establecidas. El polígono tiene {self.obtener_numero_lados}")
        self._lados = lineas

if __name__ == '__main__':
    # PROBLEMA 1
    mi_poligono = Poligono(TipoForma.CONVEXO, TipoRelacionLados.REGULAR, 3, "rojo")
    print("Polígono creado correctamente")
    print(f"Número de lados: {mi_poligono._numero_lados}")
    print(f"Color: {mi_poligono._color}")
    print(f"Tipo forma: {mi_poligono._forma.name}")
    print(f"Tipo relacción lados: {mi_poligono._relacion_lados.name}")

    # PROBLEMA 2
    mi_poligono2:Poligono = Poligono(TipoForma.CONVEXO, TipoRelacionLados.REGULAR)
    print("Polígono 2 creado correctamente")
    print(f"Número de lados: {mi_poligono2._numero_lados}")
    print(f"Color: {mi_poligono2._color}")
    print(f"Tipo forma: {mi_poligono2._forma.name}")
    print(f"Tipo relacción lados: {mi_poligono2._relacion_lados.name}")

    # PROBLEMA 3
    resultado = mi_poligono.modificar_numero_lados(4)
    print(resultado)

    # PROBLEMA 4
    print(f"Se han creado {Poligono.numero_poligonos_creados()} poligonos")

    # PROBLEMA 5
    puntoA:Punto = Punto(-2, 2)
    puntoB:Punto = Punto(2, 2)
    puntoC:Punto = Punto(-2, -2)
    puntoD:Punto = Punto(2, -2)
    print(f"Cuadrante del punto A: {puntoA.obtener_cuadrante()}")
    print(f"Cuadrante del punto B: {puntoB.obtener_cuadrante()}")
    print(f"Cuadrante del punto C: {puntoC.obtener_cuadrante()}")
    print(f"Cuadrante del punto D: {puntoD.obtener_cuadrante()}")

    # PROBLEMA 6
    linea1:Linea = Linea(puntoA, puntoB)
    linea2:Linea = Linea(puntoB, puntoD)
    linea3:Linea = Linea(puntoD, puntoC)
    linea4:Linea = Linea(puntoC, puntoA)
    print(f"Linea 1: {linea1}")
    print(f"Linea 2: {linea2}")
    print(f"Linea 3: {linea3}")
    print(f"Linea 4: {linea4}")

    # PROBLEMA 7
    lados_poligono:list[Linea] = [linea1, linea2, linea3, linea4]
    mi_poligono.establecer_lados(lados_poligono)
    print(mi_poligono)

    # PROBLEMA 8
    mi_poligono2.modificar_numero_lados(5)
    mi_poligono2.establecer_lados([
        Linea(Punto(2,3), Punto(3,4)),
        Linea(Punto(3, 4), Punto(6, 0)),
        Linea(Punto(6, 0), Punto(-2, -1)),
        Linea(Punto(-2, -1), Punto(0, -3)),
        Linea(Punto(0, -3), Punto(2, 3)),
    ])
    print(f"IGUALDAD: {mi_poligono == mi_poligono2}")
    print(f"SUMA: {mi_poligono + mi_poligono2}")
    print(f"MENOR QUE: {mi_poligono < mi_poligono2}")
    print(f"LONGITUD: {len(mi_poligono)}")


