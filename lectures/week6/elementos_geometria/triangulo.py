from enum import Enum
from week6.poligono import Poligono, TipoRelacionLados, TipoForma
from week6.linea import Linea

import math

class TipoTriangulo(Enum):
    EQUILATERO = 1
    ISOSCELES = 2
    ESCALENO = 3

class Triangulo(Poligono):
    def __init__(self,
                 tipo_triangulo:TipoTriangulo,
                 relacion_lados:TipoRelacionLados = None,
                 color:str = None,
                 lados:list['Linea'] = None):
        super().__init__(numero_lados =3,
                         forma = TipoForma.CONVEXO,
                         relacion_lados=relacion_lados,
                         color=color,
                         lados=lados)

        self._tipo_triangulo = tipo_triangulo

    def __str__(self) -> str:
        descripcion_basica:str = super().__str__()
        descripcion_triangulo:str = f"Tipo de triángulo: {self.get_tipo_triangulo().name}"
        descripcion_triangulo += f"\nPerímetro del triángulo: {self.calcular_perimetro()}"
        return f"{descripcion_basica} \n {descripcion_triangulo}"

    def __eq__(self, otro:'Triangulo') -> bool:
        return True if self.get_tipo_triangulo() == otro.get_tipo_triangulo() else False



    def get_tipo_triangulo(self) -> TipoTriangulo:
        return self._tipo_triangulo

    # EXTENDER UN MÉTODO DEL PADRE
    def calcular_perimetro(self) -> float:
        # CON EL SELF SE VA AL MÉTODO DEFINIDO EN LA INSTANCIA
        # SI ESTE MÉTODO NO ESTÁ DEFINIDO, SE VA AL MÉTODO DE LA CLASE PADRE
        if self.get_numero_lados() == 3:
            super().calcular_perimetro()
        else:
            return -1

    # CREAR UN NUEVO MÉTODO DE LA CLASE HIJO
    def calcular_area(self) -> float:
        a:float = self.get_lados()[0].calcular_longitud()
        b:float = self.get_lados()[1].calcular_longitud()
        c:float = self.get_lados()[2].calcular_longitud()
        s:float = self.calcular_perimetro() / 2
        return math.sqrt(s * (s-a) * (s-b) * (s-c))

    def set_lados(self, lados:list['Linea']) -> bool:
        if len(lados) == 3:
            super().set_lados(lados)
            return True
        return False

    def eliminar_lado_aleatorio(self) -> bool:
        return False # PARA QUE NO SE PUEDAN ELIMINAR LOS LADOS DE UN TRIÁNGULO.


class TrianguloEscaleno(Triangulo):
    def __init__(self, color:str, lados:list[Linea] = None):
        super().__init__(tipo_triangulo=TipoTriangulo.ESCALENO, color=color, lados=lados)

    def __str__(self) -> str:
        return f"{super().__str__()}\n Triangulo escaleno"

class TrianguloEquilatero(Triangulo):
    def __init__(self, color:str, lados:list[Linea] = None):
        super().__init__(tipo_triangulo=TipoTriangulo.EQUILATERO, color=color, lados=lados)


def __str__(self) -> str:
    return f"{super().__str__()}\n Triángulo equilátero"


class TrianguloIsosceles(Triangulo):
    def __init__(self, color:str, lados:list[Linea] = None):
        super().__init__(TipoTriangulo.ISOSCELES, color=color, lados=lados)


    def __str__(self) -> str:
        return f"{super().__str__()}\n Triángulo isósceles"
