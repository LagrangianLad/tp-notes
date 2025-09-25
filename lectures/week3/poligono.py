from enum import Enum
from linea import Linea

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
                 numero_lados:int,
                 forma:TipoForma = None,
                 relacion_lados:TipoRelacionLados = None,
                 color:str=None,
                 contrasenya:str = None):
        self._numero_lados:int = numero_lados
        self._color:str = color
        self._forma:TipoForma = forma
        self._relacion_lados:TipoRelacionLados = relacion_lados

        self._lados:list[Linea] = list()

        self.__contrasenya:str = contrasenya

        Poligono.numero_poligonos += 1

    def __str__(self) -> str:
        mensaje:str = f"POLÍGONO CON {self.get_numero_lados()} LADOS. "
        if self.get_color():
            mensaje += f"\n\t Color: {self.get_color()}"
        if self.get_forma():
            mensaje += f"\n\t Forma: {self.get_forma().name}"
        if self.get_relaccion_lados():
            mensaje += f"\n\t Relacción lados: {self.get_relaccion_lados().name}"
        return mensaje

    #####################################################################
    # DUDA PARA PREGUNTAR: CUANDO QUIERO TIPAR "otro" ME DA ERROR, ¿ENTIENDO QUE ES PORQUE LA CLASE NO ESTÁ DECLARADA TODAVÍA?
    # ¿NO PUEDO ESPECIFICAR otro:Poligono DESDE LA PROPIA CLASE POLÍGONO?
    #####################################################################

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