from week5.poligono import Poligono, TipoForma, TipoRelacionLados
from week5.linea import Linea
import math

class Cuadrado(Poligono):

    def __init__(self, color:str = None, lados:list[Linea] = None):
        super().__init__(numero_lados = 4,
                         forma = TipoForma.CONVEXO,
                         relacion_lados=TipoRelacionLados.REGULAR,
                         color = color,
                         lados=lados)
        self._longitud_diagonal:float = self.calcular_longitud_diagonal()

    def calcular_longitud_diagonal(self) -> float:
        if self.get_lados():
            return self.get_lados()[0].calcular_longitud() * math.sqrt(2)
        else:
            print("No se puede calcular la longitud de la diagonal para un cuadrado sin lados establecidos.")
            return -1

    def get_longitud_diagonal(self) -> float:
        self._longitud_diagonal = self.calcular_longitud_diagonal()
        return self._longitud_diagonal

    def __str__(self) -> str:
        descripcion_basica:str = super().__str__()
        descripcion_cuadrado:str = f"Cuadrado con longitud: {self.get_longitud_diagonal()}"
        return f"{descripcion_basica}\n{descripcion_cuadrado}"

    def __eq__(self, otro_cuadrado:'Cuadrado') -> bool:
        # Dos cuadrados serán iguales si tienen la misma diagonal, por ejemplo
        return True if self.get_longitud_diagonal() == otro_cuadrado.get_longitud_diagonal() else False

    def calcular_perimetro(self) -> float:
        if self.get_numero_lados() == 4:
            return super().calcular_perimetro()
        else:
            print("No se puede calcular el perímetro de un cuadrado cuyo número de lados no es cuatro")
            return -1

    def calcular_area(self) -> float:
        if self.get_numero_lados() == 4:
            return pow(self.get_lados()[0].calcular_longitud(), 2)
        else:
            print("No se puede calcular el área de un cuadrado cuyo número de lados no es cuatro")
            return -1





