import math
from punto import Punto

class Linea:

    # No es necesario determinar la sobre carga del constructor porque un segmento viene determinado por dos puntos (p1, p2)
    def __init__(self, punto_inicio:Punto, punto_fin:Punto) -> None:
        self._punto_inicio:Punto = punto_inicio
        self._punto_fin:Punto = punto_fin

        punto_fin.set_linea_pertenece(self)
        punto_inicio.set_linea_pertenece(self)

        self._poligono_pertenece = None

    def __str__(self) -> str:
        return f"LÍNEA ({self.get_punto_fin()}, {self.get_punto_fin()}) LONGITUD {self.calcular_longitud()}."
    def get_punto_inicio(self) -> Punto:
        return self._punto_inicio
    def get_punto_fin(self) -> Punto:
        return self._punto_fin

    def get_poligono_pertenece(self) -> 'Poligono':
        return self._poligono_pertenece

    def set_poligono_pertenece(self, poligono:'Poligono') -> bool:
        self._poligono_pertenece = poligono
        return True

    def get_puntos(self) -> tuple[Punto, Punto]:
        return (self.get_punto_inicio(), self.get_punto_fin())

    def set_punto_inicio(self, punto:Punto) -> bool:
        self._punto_inicio = punto
        print(f"Punto de inicio actualizado con éxito a {self.get_punto_inicio()}")
        return True

    def set_punto_fin(self, punto:Punto) -> bool:
        self._punto_fin = punto
        print(f"Punto de fin actualizado con éxito a {self.get_punto_fin()}")
        return True

    def calcular_longitud(self) -> float:
        return self.get_punto_inicio().distancia_manhatan(self.get_punto_fin())