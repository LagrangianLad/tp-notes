"""
TECNOLOGÍA DE LA PROGRAMACIÓN - SESIÓN DE PRÁCTICAS SEMANA I

PABLO CORBALÁN DE CONCEPCIÓN

DTIE MATEMÁTICAS Y FÍSICA UNIVERSIDAD DE MURCIA - CURSO 2025/26
"""

def problema2():
    print(f"El resultado de la operación es: {1.5*float(int(input("Introduce: ")))}")

# ========================================================

def problema3():
    frase = input("Introduce tu frase: ")
    print(f"Frase en mayúsculas: {upper(frase)}")
    print(f"Frase en minúsculas: {lower(frase)}")
    print(f"Frase capitalizada: {capitalice(frase)}") # Primera letra en mayúsculas
    print (f"Frase capitalizada por palabra: {title(frase)}") # Primera letra de cada palabra en mayúsculas
    letra:str = input("Introduce una letra: ")
    print(f"El código ASCII de la letra {letra} es: {ord(letra)}")
    ascii:str = input("Introduce un código ascii: ")
    print(f"La letra asociada al código ASCII {ascii} es: {chr(asci)}")

# ========================================================

def problema4 (lista):
    print(lista[2])
    print(lista[0:2])
    lista.append(60)
    print(lista)
    lista.pop(1)
    print(lista)
    numero_aleatorio:int = random.randint(1,100)
    lista.insert(0, numero_aleatorio)
    print(lista)
    lista.sort(reverse=True)
    print(lista)

# ========================================================

def problema5():
    ciudades:tuple[str, str, str] = ("Madrid", "Barcelona", "Málaga")
    print(f"El segundo elemento de la tupla es: {ciudades[1]}")
    ciudades_lista:list = list(ciudades)
    ciudades_lista[2] = "Murcia"
    ciudades_nueva_tupla:tuple[str, str, str] = tuple(ciudades_lista)
    print(f"La nueva tupla es: {ciudades_nueva_tupla}")

# ========================================================

def problema6():
    A:set = {1,2,3,4,5,6,7,8,9,10}
    B:set = {2,4,6, 8, 10, 12}
    print(union(A, B))
    print(interseccion(A,B))
    print(resta(A,B))
    print(anyade(A, 100))
    print(elimina(A, 4))


def union(A:set, B:set) -> set:
    C:set = A
    for elemento in B:
       C.add(elemento)
    return C
def interseccion(A:set, B:set) -> set:
    C:set = set()
    for elemento in A:
       if elemento in B:
          C.add(elemento)
    for elemento in B:
       if elemento in A:
          C.add(elemento)
    return C
def resta(A:set, B:set) -> set:
    C:set = set()
    for elemento in A:
       if elemento not in B:
          C.add(elemento)
    return C
def anyade(A:set, elemento:int) -> set:
    A.add(elemento)
    return A
def elimina(A:set, elemento:int) -> set:
    A.remove(elemento)
    return A


# ========================================================

estudiantes:dict[str:int] = {
    "Paco Martínez": 8,
    "Laura Norte": 5,
    "Sara López": 10,
    "Juan Pérez": 3
}

def problema7():
    print(estudiantes)

    nombres_estudiantes = [e for e in estudiantes.keys()]
    print(f"Nombres de estudiantes: {nombres_estudiantes}")
    print(f"Número total de estudiantes: {len(nombres_estudiantes)}")

    notas_estudiantes = [n for n in estudiantes.values()]
    print(f"Notas de los estudiantes: {notas_estudiantes}")

    estudiantes["Sara Lopez"] = 9
    print(estudiantes)

    estudiantes.pop("Juan Pérez")
    print(estudiantes)

# ========================================================

def problema8():
    dinero_gastado:float = float(input("Dinero gastado en la tienda: "))
    premium:str = input("Tiene premium? (si/no): ")
    membresia:bool = True if premium == "si" else False

    descuento:float = 0
    if (dinero_gastado > 100 and membresia):
        descuento = 0.2
    elif (dinero_gastado > 100 or membresia):
        descuento = 0.1

    print(f"El cliente recibe un descuento del {descuento*100}%")

# ========================================================

def problema9():
    x:int = int(input("Introduzca un número entero positivo: "))
    limite:int = int(input("Introduzca el valor límite de la suma: "))

    suma:int = 0
    numero_actual=0
    while((suma + numero_actual) < limite and numero_actual <= x):
        suma+=numero_actual
        numero_actual+=1

    print(f"La suma final es: {suma}")

# ========================================================

def problema10():
    palabra:str =""
    size:int = int(input("Tamaño de la palabra: "))
    for i in range(0,size):
        random_number:int = random.randint(0,9)
        print(f"Posicion actual {i}")
        palabra+=str(random_number)
        print(palabra)

# ========================================================

def problema11():
    size:int = random.randint(3,7)
    lista = []
    for i in range(size):
        lista.append(random.randint(0,9))
    print(lista)
    for pos in range(len(lista)):
        print(lista[pos])
    for elem in lista:
        print(elem)

# ========================================================

def problema12(x:int, y:int)->None:
    print(f"El mayor número entre {x} e {y} es: {x if x > y else y}")

# ========================================================

def problema13(name:str, edad:int=18)->None:
    print(f"Hola {name}, tienes {edad} años")

# ========================================================

def problema14(*args, **kwargs):
    suma:float = 0
    for n in args:
        suma+=n
    promedio:float = suma/len(args)

    if "bienvenida" in kwargs.keys() and "despedida" in kwargs.keys():
        print(f"{kwargs["bienvenida"]}")
        print(promedio)
        print(f"{kwargs["despedida"]}")
    else:
        print(promedio)

# ========================================================

def problema15(nombre:str, saldo:float = 0, *args, **kwargs)-> (int, str):
    saldo_final:float = saldo
    print(args)
    for transaccion in args[0]:
        saldo_final += transaccion
    string_final = ""
    for key, argument in kwargs.items():
        string_final += f"{key} --> {argument}"
    return saldo_final, string_final

# ========================================================

from enum import Enum

class Color(Enum):
    ROJO:int = 1
    VERDE:int = 2
    AZUL:int = 3
    AMARILLO:int = 4

color_escogido:Color = Color.AMARILLO
print(f"Valor: {color_escogido.value}")
print(f"Nombre: {color_escogido.name}") # ES UN ATRIBUTO, NO UN MÉTODO

def mostrar_color(color:Color) -> None:
    print(f"Valor: {color.value}, Nombre: {color.name}")

def mostrar_todos_colores() -> None:
    for color in Color:
        mostrar_color(color)

mostrar_color(Color.AZUL)
mostrar_todos_colores()
