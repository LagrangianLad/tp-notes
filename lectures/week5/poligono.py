from enum import Enum
from linea import Linea
from punto import Punto

import random

class TipoForma(Enum):
    CONVEXO = 1
    CONCAVO = 2
    COMPLEJO = 3

class TipoRelacionLados(Enum):
    REGULAR = 1
    IRREGURAL = 2

class Poligono:

    numero_poligonos:int = 0
    distancia_maxima_vecinos:float = 10

    @classmethod
    def numero_poligonos_creados(cls) -> float:
        return cls.numero_poligonos

    @classmethod
    def get_distancia_maxima_vecinos(cls) -> float:
        return cls.distancia_maxima_vecinos

    @classmethod
    def set_distancia_maxima_vecinos(cls, distancia) -> bool:
        if distancia < 0:
            print("La distancia ha de ser positiva o cero")
            return False
        cls.distancia_maxima_vecinos = distancia
        return True

    def __init__(self,
                 numero_lados:int,
                 forma:TipoForma = None,
                 relacion_lados:TipoRelacionLados = None,
                 color:str=None,
                 contrasenya:str = None,
                 lados:list[Linea] = None):
        self._numero_lados:int = numero_lados
        self._color:str = color
        self._forma:TipoForma = forma
        self._relacion_lados:TipoRelacionLados = relacion_lados

        self._lados:list[Linea] = lados

        self.__contrasenya:str = contrasenya

        Poligono.numero_poligonos += 1

        self._poligonos_vecinos:list[Poligono] = list()

        self._vertices : set[Punto] = set()
        self._vertices = self.get_vertices()

    def __str__(self) -> str:
        mensaje:str = f"POLÍGONO CON {self.get_numero_lados()} LADOS. "
        if self.get_color():
            mensaje += f"\n\t Color: {self.get_color()}"
        if self.get_forma():
            mensaje += f"\n\t Forma: {self.get_forma().name}"
        if self.get_relaccion_lados():
            mensaje += f"\n\t Relacción lados: {self.get_relaccion_lados().name}"
        return mensaje

    def __eq__(self, otro) -> bool:
        return True if self.get_numero_lados() == otro.obtener_numero_lados() else False

    def __add__(self, otro) -> int:
        return self.calcular_perimetro() + otro.calcular_perimetro()

    def __lt__(self, otro) -> bool:
        return True if self.calcular_perimetro() <= otro.calcular_perimetro() else False

    def __len__(self) -> int:
        return self.get_numero_lados()

    def get_numero_lados(self) -> int:
        return self._numero_lados

    def get_color(self) -> str:
        return self._color

    def get_forma(self) -> TipoForma:
        return self._forma

    def get_relaccion_lados(self) -> TipoRelacionLados:
        return self._relacion_lados

    def get_poligonos_vecinos(self) -> list['Poligono']:
        return self._poligonos_vecinos

    def get_lados(self) -> list[Linea]:
        return self._lados

    def _set_numero_lados(self, nuevo_numero_lados:int) -> bool:
# LOS MÉTODOS PARA MODIFICAR ATRIBUTOS SON ÚTILES PARA CONTROLAR LOS ERRORES ANTES DE LA ASIGNACIÓN
         if nuevo_numero_lados < 3:
            print("Error: el número de lados ha de ser mayor o igual que 3")
            return False
         self._numero_lados = nuevo_numero_lados
# AUNQUE EN LA CLASE SIEMPRE PUEDO ACCEDER AL ATRIBUTO, ES MEJOR IDEA CONSULTAR EL MÉTODO
         print(f"Ok, se han establecido { self.get_numero_lados() } en el polígono")
         return True

    def set_color(self, color:str) -> bool:
        self._color = color
        print(f"Se ha cambiado el color del polígono a {self.get_color()}")
        return True

    def set_forma(self, forma:TipoForma) -> bool:
        self._forma = forma
        print(f"Se ha cambiado la forma del polígono a {self.get_forma().name}")
        return True

    def set_relacion_lados(self, relacion_lados:TipoRelacionLados) -> bool:
        self._relacion_lados = relacion_lados
        print(f"Se ha cambiado la relación de lados del polígono a {self.get_relaccion_lados().name}")
        return True

    def set_lados(self, lineas:list[Linea]) -> bool:
        if len(lineas) != self.get_numero_lados():
            print("No se han podido establecer las líneas como lados del polígono.")
            return False
        print(f"Lineas establecidas. El polígono tiene {self.get_numero_lados()}")
        self._lados = lineas
        # RECALCULAMOS LOS VÉRTICES CON LOS NUEVOS LADOS
        if lineas != self.get_lados():
            self.set_vertices(self.calcular_vertices())

        # AGREGAMOS ESTA LÍNEA POR LA CORRESPONDENCIA ENTRE LÍNEAS Y POLÍGONOS PROPUESTA EN SEMANA 4 - PROBLEMA 5
        for linea in lineas:
            linea.set_poligono_pertenece(self)
        return True

    def set_vertices(self, vertices_nuevos:set[Punto]) -> bool:
        self._vertices = vertices_nuevos
        print("Vértices actualizados")
        return True

    def set_contrasenya(self, contrasenya:str) -> bool:
        if self.__contrasenya != contrasenya and len(contrasenya) > 8:
            self.__contrasenya = contrasenya
            print("Contraseña cambiada con éxito.")
            return True
        else:
            print("Las contraseñas deben ser diferentes y la nueva contraseña ha de tener ocho o más caractéres")
            return False

    def calcular_perimetro(self) -> float:
        perimetro:float = 0
        for lado in self._lados:
            perimetro+=lado.calcular_longitud()
        return perimetro

    def escalar_poligono(self, factor=None, ajuste_lados=None) -> bool:
        # Entendemos que si el usuario pasa tanto factor como ajuste_lados, quiere primero multiplicar el número de lados y
        # luego sumar el parámetro ajuste_lados, que es perfectamente posible.
        resultado_escalada:bool = False
        if factor:
            resultado_escalada = self._set_numero_lados(self.get_numero_lados() * factor)
        if ajuste_lados:
            resultado_escalada = self._set_numero_lados(self.get_numero_lados() + ajuste_lados)
        return resultado_escalada


    def es_vecino(self, otro_poligono:'Poligono') -> bool:
        es_vecino:bool = False
        posicion_lado = 0
        while not es_vecino and posicion_lado < len(self.get_lados()):
            punto_actual:Punto = self.get_lados()[posicion_lado].get_punto_inicio()
            distancia:float = punto_actual.distancia_manhatan_a_poligono(otro_poligono)
            if distancia < Poligono.get_distancia_maxima_vecinos():
                es_vecino = True
            posicion_lado += 1
        return es_vecino


    def agregar_vecino(self, otro_poligono:'Poligono') -> bool:
        if not self.es_vecino(otro_poligono):
            print(f"No se pudo agregar {otro_poligono} a la lista de vecinos")
            return False

        # NECESARIO PARA EVITAR LA RECURSIVIDAD
        if otro_poligono in self.get_poligonos_vecinos():
            return False

        self._poligonos_vecinos.append(otro_poligono)
        otro_poligono.agregar_vecino(self)
        print(f"Se ha añadido {otro_poligono} a la lista de vecinos")
        return True

    def calcular_vertices(self) -> set[Punto]:
        if self.get_lados():
            vertices:set[Punto] = set()
            for lado in self.get_lados():
                punto_inicial, _ = lado.get_puntos()
                # COMO ES UN CONJUNTO YA REVISA SI ESTÁN REPETIDOS
                vertices.add(punto_inicial)
            return vertices
        else:
            return None

    def get_vertices(self) -> set[Punto]:
        if not self._vertices: # NO HAY, LOS CALCULO
            self._vertices = self.calcular_vertices()
        return self._vertices


    def eliminar_lado_aleatorio(self) -> None:
        lados = self.get_lados()
        self._set_numero_lados(self.get_numero_lados() - 1)
        lados.remove(random.randint(0, len(lados)))
        self.set_lados(lados)