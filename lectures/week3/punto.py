from enum import Enum

class Cuadrante(Enum):
    EJE = 0
    PRIMER_CUADRANTE = 1
    SEGUNDO_CUADRANTE = 2
    TERCER_CUADRANTE = 3
    CUARTO_CUADRANTE = 4

class Punto:

    # No es necesario aplicar sobre carga del constructor porque un punto viene determinado por sus coordenadas (x,y)
    def __init__(self, x:float, y:float):
        self._coordenada_x:float = x
        self._coordenada_y:float = y

    def __str__(self):
        return f"({self.get_coordenada_x()}, {self.get_coordenada_y()}) CUAD {self.get_cuadrante().name}"
    def get_coordenada_x(self) -> float:
        return self._coordenada_x

    def get_coordenada_y(self) -> float:
        return self._coordenada_y

    def get_cuadrante(self) -> Cuadrante:
        if self.get_coordenada_x() == 0 or self.get_coordenada_y() == 0:
            return Cuadrante.EJE
        elif self.get_coordenada_x() > 0:
            if self.get_coordenada_y() > 0:
                return Cuadrante.PRIMER_CUADRANTE
            return Cuadrante.CUARTO_CUADRANTE
        else:
            if self.get_coordenada_y() > 0:
                return Cuadrante.SEGUNDO_CUADRANTE
            return Cuadrante.TERCER_CUADRANTE

    def set_coordenada_x(self, x:float) -> bool:
        self._coordenada_x = x
        print(f"Coordenada X actualizada con éxito a {self.get_coordenada_x()}")
        return True

    def set_coordenada_y(self, y:float) -> bool:
        self._coordenada_y = y
        print(f"Coordenada Y actualizada con éxito a {self.get_coordenada_y()}")
        return True