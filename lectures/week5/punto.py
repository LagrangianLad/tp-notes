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

        self._linea_pertenece:'Linea' = None

    def __str__(self):
        msg:str = f"({self.get_coordenada_x()}, {self.get_coordenada_y()}) CUAD {self.get_cuadrante().name}"
        return msg

    def get_coordenada_x(self) -> float:
        return self._coordenada_x

    def get_linea_pertenece(self) -> 'Linea':
        return self._linea_pertenece

    def set_linea_pertenece(self, linea:'Linea') -> bool:
        self._linea_pertenece = linea
        return True

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

    # LA CLASE PUNTO NO EXISTE TODAVÍA, LA ESTOY DEFINIENDO. POR ESO NO PUEDO USAR SIMPLEMENTE
    # other:Punto
    def distancia_manhatan(self, other:'Punto') -> float:
        distancia:float = abs(self.get_coordenada_x() - other.get_coordenada_x()) + abs(self.get_coordenada_y() - other.get_coordenada_y())
        return distancia

    def distancia_manhatan_a_poligono(self, poligono: 'Poligono' ) -> float:
        """
        Dado un polígono devuelve la distancia entre el punto y el polígono, que se define como la menor distancia entre
        el punto y los vértices del polígono.
        """
        distancias:list[float] = list()
        for lado in poligono.get_lados():
            distancias.append(self.distancia_manhatan(lado.get_punto_inicio()))
        return min(distancias)