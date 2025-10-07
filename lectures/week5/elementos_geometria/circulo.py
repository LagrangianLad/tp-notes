from enum import Enum

import week5.elementos_geometria.circulo
from week5.elementos_geometria.triangulo import TipoTriangulo
from week5.poligono import Poligono, TipoRelacionLados, TipoForma
from week5.punto import Punto

from math import pi
class Circulo(Poligono):

        def __init__(self,
                     radio: float,
                     centro: Punto,
                     color: str = None):
            super().__init__(numero_lados=0,
                             forma=TipoForma.CONVEXO,
                             relacion_lados=TipoRelacionLados.REGULAR,
                             color=color,
                             lados=None)

            self._radio:float = radio
            self._centro:Punto = centro

        def __str__(self) -> str:
            descripcion_basica: str = super().__str__()
            descripcion_circulo:str = f"\nPerímetro del círculo: {self.calcular_perimetro()}"
            descripcion_circulo += f"\nÁrea del círculo: {self.calcular_area()}"
            return f"{descripcion_basica} \n {descripcion_circulo}"

        def __eq__(self, otro:'Circulo') -> bool:
            # ENTENDEMOS QUE DOS CIRCULOS SON IGUALES SI TIENEN EL MISMO RADIO
            return True if self.get_radio() == otro.get_radio() else False

        def get_radio(self) -> float:
            return self._radio

        def get_centro(self) -> Punto:
            return self._centro

        def set_radio(self, nuevo_radio:float) -> bool:
            if nuevo_radio > 0:
                self._radio = nuevo_radio
                return True
            return False

        def _set_numero_lados(self, nuevo_numero_lados:int) -> bool:
            print("ERROR: NO SE PUEDE CAMBIAR EL NÚMERO DE LADOS DE UN CIRCULO")
            return False

        def set_forma(self, forma: TipoForma) -> bool:
            print("ERROR: NO SE PUEDE CAMBIAR LA FORMA DE UN CIRCULO")
            return False

        def set_relacion_lados(self, relacion_lados: TipoRelacionLados) -> bool:
            print("ERROR: NO SE PUEDE CAMBIAR LA RELACIÓN DE LADOS DE UN CÍRCULO")
            return False

        def calcular_vertices(self):
            print("ERROR: NO SE PUEDEN CALCULAR LOS VÉRTICES DE UN CÍRCULO")
            pass

        def get_vertices(self):
            print("ERROR: UN CÍRCULO NO TIENE VÉRTICES")
            pass

        def eliminar_lado_aleatorio(self):
            print("ERROR: NO SE PUEDE ELIMINAR UN LADO DE UN CÍRCULO, ESTE NO TIENE LADOS")

            # SOBRE ESCRIBEN LOS MÉTODOS DE LA CLASE POLÍGONO
        def calcular_perimetro(self) -> float:
            return 2*pi*self.get_radio()

        def calcular_area(self) -> float:
            return pi*pow(self.get_radio(), 2)

        def es_vecino(self, otro_poligono:'Poligono') -> bool:
            if isinstance(otro_poligono, Circulo):
                distancia_centros:float = self.get_centro().distancia_manhatan(otro_poligono.get_centro())
                return True if distancia_centros < Circulo.get_distancia_maxima_vecinos() else False
            else:
                # EL OTRO ES UN POLÍGONO
                vecinos:bool=False
                posicion_lado:int = 0
                while not vecinos and posicion_lado < len(otro_poligono.get_lados()):
                    lado_actual:'Linea' = otro_poligono.get_lados()[posicion_lado]
                    punto_actual:Punto = lado_actual.get_punto_inicio()
                    distancia:float = punto_actual.distancia_manhatan(self.get_centro())
                    if distancia < otro_poligono.get_distancia_maxima_vecinos():
                        vecinos = True
                    posicion_lado += 1
                return vecinos

        def escalar_poligono(self, factor=None, ajuste_lados=None) -> bool:
            resultado_escalada:bool = False
            if factor:
                resultado_escalada =self.set_radio(self.get_radio() * factor)
            if ajuste_lados:
                resultado_escalada = self.set_radio(self.get_radio() + ajuste_lados)
            return resultado_escalada


