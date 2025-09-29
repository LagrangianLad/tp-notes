/*
BOLETÍN II
 
 Corbalán de Concepción, Pablo
 49339953P
 1ºDTIE Matemáticas y física
 Fundamentos de la programación curso 2025
 */


// Constantes a lo largo del programa que potencialmente los dueños del teatro querrían ajustar.
final float DESCUENTO_APLICADO_A_MENORES_DE_EDAD = 0.7;
final int NUMERO_DE_FILAS_PATIO_DE_BUTACAS = 5;
final int NUMERO_DE_COLUMNAS_PATIO_DE_BUTACAS = 12;


/*EXPLICACIÓN I:
 
 En multitud de ocasiones, el programa tiene que recorrer la matriz patio de butacas para extraer o comparar diferente información
 de los asistentes al evento. Para esto, se implementa un doble bucle for junto con la comprobación de si el asistente en cuestión es
 una entrada de la matriz nula. Para patios de butacas grandes (y en especial, con muchos asientos vacíos) esto puede ser realmente ineficiente
 pues estaríamos realizando multitud de comprobaciones que no son estrictamente necesarias.
 
 Sustituir los bucles for por bucles while que incluyan la condición de que el asiento no sea nulo no es una opción viable, pues pararía el programa
 en cuanto detectara un asiento vacío (entrada nula). Esto no se corresponde al funcionamiento que se espera del programa. En un teatro real no
 deberíamos parar la recaudación porque uno de los asientos esté vacío, quizá el resto estén llenos. Lo mismo sucede con añadir la condición
 en el propio bucle for.
 
 Una solución más eficiente sería crear una función que dado un patio de butacas devolviera la lista de sus entradas no vacías (asientos completos)
 junto con la posición que ocupan en el patio de butacas. Es decir una lista donde cada entrada sea de la forma:
 
 {{posicion fila(i), posicion columna(i), asistente en esa posición(i)}, ... }
 
 
 Por legibilidad, y pensando que los patios de butacas no suelen tener más de 200-300 asientos, se ha decidido realizar la comprobación en cada una
 de las entradas. Si tratáramos con patios de butacas mucho más grandes (del orden de E5-E6) asientos, es mucho más interesante crear la susodicha
 función para evitar infinidad de comprobaciones inecesarias.
 
 
 Otra posible solución (quizá demasiado artificial) sería inicializar todos los asientos vacíos a un asistente cuyo nombre fuera "XXXX", su edad 0, el
 precio de su entrada 0 de forma que no contabilizase en el proceso. Esta solución no me ha resultado cómoda, incluir "asistentes fantasma" es algo que
 altera el diseño de prácticamente todos los requisitos. Al final, se ha preferido evitar los asientos vacíos realizando la comprobación.
 */


//#################################### FUNCIONES GENÉRICAS ####################################
// Se utilizan varias veces a lo largo del programa y no se corresponden con un proceso específico.
void imprimirReserva(Reserva reserva) {
  /* FUNCIÓN GENÉRICA
   
   Dada una reserva, imprime toda la información de la misma.
   
   Recibe un parámetro:
   - reserva: La reserva de la que debe imprimir información.
   */
  if (reserva == null) {
    println("ERROR: Reserva vacía");
  } else {
    println("\t#RESERVA: " + reserva.numeroDeReserva + " (" + reserva.listaDeAsistentes.length + " asistentes)");
    for (int asistente = 0; asistente < reserva.listaDeAsistentes.length; asistente++) {
      imprimirAsistente(reserva.listaDeAsistentes[asistente]);
    }
  }
}

void imprimirListaDeReservas(Reserva[] listaDeReservas) {
  /* FUNCIÓN GENÉRICA
   
   Dada una lista de reservas, imprime una a una la información de cada reserva.
   
   Recibe un parámetro:
   - listaDeReservas: La lista que contiene todas las reservas que se van a imprimir.
   */
  println("###LISTA DE RESERVAS###");
  if (listaDeReservas == null) {
    println("ERROR: Lista de reservas vacía");
  } else {
    for (int reserva = 0; reserva < listaDeReservas.length; reserva++) {
      imprimirReserva(listaDeReservas[reserva]);
    }
  }
}

String justificar(String texto, int tamano) {
  /* FUNCIÓN GENÉRICA
   
   Justifica un texto a la izquierda, de forma que el texto (ya justificado) ocupe 'tamaño' espacios.
   */
  if (tamano < 0) { // Posible error
    tamano = 0;
  }
  String espacios = "";
  for (int espacio = 0; espacio < tamano-texto.length(); espacio++) {
    espacios+=" ";
  }
  return texto+espacios;
}

void imprimirPatioDeButacas (Asistente[][] patioDeButacas) {
  /* FUNCIÓN GENÉRICA
   
   Dada una matriz (patio de butacas) imprime sus filas y sus columnas formateando la información y separando las columnas con barras
   verticales.
   
   Recibe un parámetro:
   - patioDeButacas: la matriz que representa el patio de butacas, de la cual se va a imprimir la información.*/
  if (patioDeButacas != null) {
    for (int fila = 0; fila < patioDeButacas.length; fila++) {
      print(justificar("FIL"+(fila+1)+"", 6));
      print("|");
      for (int columna = 0; columna < patioDeButacas[fila].length; columna++) {
        Asistente asistenteActual = patioDeButacas[fila][columna];
        if (asistenteActual != null) { // VÉASE EXPLICACIÓN I.
          print(justificar(asistenteActual.nombre.charAt(0) +""+ asistenteActual.apellidos.charAt(0) + "("+asistenteActual.edad+")", 6));
        } else {
          print(justificar("", 6));
        }
        print("|");
      }
      println("");
    }
  } else {
    println("Patio de butacas nulo");
  }
}

void imprimirAsistente(Asistente asistente) {
  /* FUNCIÓN GENÉRICA
   
   Dado un asistente imprime su información.
   */
  println("\t\t·" + justificar(asistente.nombre + " " + asistente.apellidos + " (edad: " + asistente.edad + ")", 50) + asistente.entrada.numero + "|" + asistente.entrada.precio + "€");
}



//#################################### REQUISITO 1 ####################################
class Entrada {
  int numero;
  float precio;
}

class Asistente {
  String nombre;
  String apellidos;
  int edad;
  Entrada entrada;
}

class Reserva {
  int numeroDeReserva;
  Asistente[] listaDeAsistentes;
}

Asistente crearAsistenteAleatorio(int numeroDeEntrada, int precioDeLaEntrada) {
  /* CORRESPONDIENTE AL REQUISITO 1
   
   Devuelve un estudiante quasi-aleatorio, donde el nombre y sus apellidos han sido seleccionados de una lista arbitraria.
   
   Recibe dos parámetros:
   - numeroDeEntrada: el número de entrada único que se le asignará al asistente.
   - precioDeLaEntrada: el precio de una entrada. Podríamos haber tratado este parámetro como una variable global, pero con la intención
   de hacer el programa lo más realista posible, hemos pensado que los precios de las entradas podrían variar dependiendo de la zona del precio de butacas.
   */
  Asistente asistente = new Asistente();
  String[] nombres = {"Jacobo", "Abraham", "Moisés", "David", "Salomón", "Isaías", "Elías", "Pedro", "Juan", "Mateo", "Lucas", "Esteban", "María", "José", "Noé"};
  String[] apellidos = {"Cohen", "Levi", "Ben-David", "Shalom", "Katz", "Mizrahi", "Peretz", "Rosenberg", "Goldstein", "Kaplan", "Azulay", "Avrahami", "Baruch", "Segal", "Friedman"};
  asistente.nombre = nombres[(int) random(0, nombres.length)];
  asistente.apellidos = apellidos[(int) random(0, apellidos.length)] + " " + apellidos[(int) random(0, apellidos.length)];
  asistente.edad = (int) random(1, 100);
  // Creación de la entrada del asistente.
  asistente.entrada = new Entrada();
  asistente.entrada.numero = numeroDeEntrada;
  asistente.entrada.precio = precioDeLaEntrada;
  if (asistente.edad < 18) {
    asistente.entrada.precio *= DESCUENTO_APLICADO_A_MENORES_DE_EDAD;
  }
  return asistente;
}

Reserva crearReservaAleatoria(int numeroDeReserva, int numeroDePersonasSentadas) {
  /* CORRESPONDIENTE AL REQUISITO 1
   
   Devuelve una reserva con un cierto número de asistentes aleatorios. Por simplicidad hemos tomado que cada
   reserva tendrá entre uno y diez asistentes.
   
   Recibe dos parámetros:
   - numeroDeReserva: el número de reserva único que se asignará a la reserva creada
   - numeroDePersonasSentadas: parámetro que se utiliza para asignar a cada persona un número de entrada único.
   Actúa como un contador de cuantas personas hay en el teatro. La función no hace uso explícito de este parámetro,
   pero permite la conexión entre crearListaDeReservasAleatoria() y crearAsistenteAleatorio().
   */
  Reserva reserva = new Reserva();
  reserva.numeroDeReserva = numeroDeReserva;
  reserva.listaDeAsistentes = new Asistente[(int) random(1, 10)];
  for (int i = 0; i < reserva.listaDeAsistentes.length; i++) {
    reserva.listaDeAsistentes[i] = crearAsistenteAleatorio(numeroDePersonasSentadas+i, 10);
  }
  return reserva;
}

Reserva[] crearListaDeReservasAleatoria() {
  /* CORRESPONDIENTE AL REQUISITO 1
   
   Devuelve una lista de reservas aleatoria, numeradas desde el uno hasta 'n' siendo 'n' la posición de la última reserva.
   Tal y como se solicita, el tamaño de la lista de reservas es aleatorio. Por simplicidad, hemos tomado que por cada evento habrá
   de una a diez reservas.
   
   No recibe parámetros.
   */
  Reserva[] listaDeReservas = new Reserva[(int) random(1, 10)];
  int numeroDePersonasSentadas = 0;
  for (int i = 0; i < listaDeReservas.length; i++) {
    listaDeReservas[i] = crearReservaAleatoria(i+1, numeroDePersonasSentadas);
    numeroDePersonasSentadas += listaDeReservas[i].listaDeAsistentes.length;
  }
  return listaDeReservas;
}





//#################################### REQUISITO 2 ####################################
int contarAsistentesTotales(Reserva[] listaDeReservas) {
  /* CORRESPONDIENTE AL REQUISITO II
   
   Dada una lista de reservas arbitraria, cuenta cuántos asistentes hay entre todas las reservas
   */
  int contador = 0;
  for (int reserva = 0; reserva < listaDeReservas.length; reserva++) {
    if (listaDeReservas[reserva] == null) {
      println("ERROR: Una de las reservas no ha sido inicializada");
      return -1;
    }
    contador+=listaDeReservas[reserva].listaDeAsistentes.length;
  }
  return contador;
}

Asistente[][] colocarAsistentesSinImportarOrden(Reserva[] listaDeReservas) {
  /* CORRESPONDIENTE AL REQUISITO II
   
   Dado un patio de butacas que se vacía al comienzo de la función y una lista de reservas, coloca siguiendo el orden de prioridad de
   las reservas a cada uno de los asistentes en su respectivo asiento del patio de butacas
   
   Recibe dos parámetros:
   - patioDeButacas: el patiod donde se van a colocar los asistentes.
   - listaDeReservas: la lista de donde extraeremos a los asistentes que van a ser colocados. Es posible que no todos los asistentes se
   puedan sentar
   */
  if (listaDeReservas == null) {
    println("ERROR: La lista de reservas no ha sido inicializada.");
    return null;
  } else if (NUMERO_DE_FILAS_PATIO_DE_BUTACAS < 1 || NUMERO_DE_COLUMNAS_PATIO_DE_BUTACAS < 1) { // Muestra 'dead code' porque con esta configuración (enteros positivos en las constantes) nunca se daría
    println("ERROR: El número de filas (y/o) columnas para la creación de un patio de butacas NO puede ser negativo");
    return null;
  } else {
    Asistente[][] patioDeButacas = new Asistente[NUMERO_DE_FILAS_PATIO_DE_BUTACAS][NUMERO_DE_COLUMNAS_PATIO_DE_BUTACAS];
    // Estos dos contadores me permiten recorrer la lista de reservas
    int reservaActual = 0;
    int personasDeLaReservaSentadas = 0;
    for (int personasSentadas = 0;
      // El mínimo entre los asientos disponibles y el total de asistentes al evento
      personasSentadas < min(contarAsistentesTotales(listaDeReservas), patioDeButacas.length * patioDeButacas[0].length);
      personasSentadas++) {
      // Comprobación para pasar a la siguiente reserva
      if (personasDeLaReservaSentadas == listaDeReservas[reservaActual].listaDeAsistentes.length) {
        personasDeLaReservaSentadas = 0;
        reservaActual++;
      }
      patioDeButacas[personasSentadas / patioDeButacas[0].length][personasSentadas % patioDeButacas[0].length] = listaDeReservas[reservaActual].listaDeAsistentes[personasDeLaReservaSentadas];
      personasDeLaReservaSentadas++;
    }
    return patioDeButacas;
  }
}




//#################################### REQUISITO 3 ####################################

int contarAsientosLibres(int fila, Asistente[][] patioDeButacas) {
  /* CORRESPONDIENTE AL REQUISITO 3
   
   Dada una fila y un patio de butacas cuenta el máximo número de asientos vacíos hay. Por como hemos construido el patio,
   estos asientos serán necesariamente consecutivos (no es posible, por ejemplo, que una reserva se siente ocupando espacios
   intercalados). El problema es equivalente a contar el número de columnas ocupadas y posteriormente restar este número al
   número total de columnas (en cada fila).
   
   Recibe dos parámetros:
   - fila: la fila de la que se van a contar los asientos libres
   - patioDeButacas: la matriz que representa el patio de butacas en el que tratamos.*/
  int columna = 0;
  while (columna < patioDeButacas[fila].length && patioDeButacas[fila][columna] != null) {
    columna++;
  }
  return patioDeButacas[fila].length - columna;
}

int encontrarFilaConEspacio(Asistente[][] patioDeButacas, Reserva reserva) {
  /* CORRESPONDIENTE AL REQUISITO 3
   
   Comprueba si los integrantes de la reserva 'reserva' caben en el patio de butacas y devuelve la primera fila en la que caben
   todos los asistentes de la reserva.
   
   Recibe dos parámetros:
   - patioDeButacas
   - reserva: la reserva para la cual se quiere encontrar sitio en el patio de butacas.
   */
  int filaQueTieneEspacio = -1;
  int fila = 0;
  while (fila < patioDeButacas.length && filaQueTieneEspacio == -1) {
    if (reserva.listaDeAsistentes.length <= contarAsientosLibres(fila, patioDeButacas)) {
      filaQueTieneEspacio = fila;
    }
    fila++;
  }
  return filaQueTieneEspacio; // Si no hay espacio, devuelve la fila -1.
}

int encontrarPrimeraColumnaNula(Asistente[][] patioDeButacas, int fila) {
  /* CORRESPONDIENTE AL REQUISITO 3.
   
   Dado un patio de butacas y una fila arbitraria, encuentra la posición de la primera columna vacía en esa fila. Devuelve esta posición.
   */
  int columna = 0;
  while (patioDeButacas[fila][columna] != null) {
    columna++;
  }
  return columna;
}

Asistente[][] colocarAsistentesRespetandoLasReservas(Reserva[] listaDeReservas) {
  /* CORRESPONDIENTE AL REQUISITO 3
   
   Dado un patio de butacas y una lista de reservas, intenta colocar a las reservas (siguiendo su orden en la lista) de forma que todos los asistentes de una misma reserva
   estén sentados en la misma fila. Si No puede, mostrará por pantalla que reserva no ha podido sentarse en la misma fila. La función no devuelve
   nada porque se aprovecha del aliasing de procesing para modificar el patio de butacas.*/
  if (listaDeReservas == null) {
    println("ERROR: La lista de reservas no ha sido inicializada.");
    return null;
  } else if (NUMERO_DE_FILAS_PATIO_DE_BUTACAS < 1 || NUMERO_DE_COLUMNAS_PATIO_DE_BUTACAS < 1) {
    println("ERROR: El número de filas (y/o) columnas para la creación de un patio de butacas NO puede ser negativo");
    return null;
  } else {
    Asistente[][] patioDeButacas = new Asistente[NUMERO_DE_FILAS_PATIO_DE_BUTACAS][NUMERO_DE_COLUMNAS_PATIO_DE_BUTACAS];
    for (int posicionReserva = 0; posicionReserva < listaDeReservas.length; posicionReserva++) {
      Reserva reserva = listaDeReservas[posicionReserva];
      int filaDondeHayEspacio = encontrarFilaConEspacio(patioDeButacas, reserva);
      if (filaDondeHayEspacio != -1) { // Es decir, cuando hay espacio para la reserva
        int columnaDondeHayEspacio = encontrarPrimeraColumnaNula(patioDeButacas, filaDondeHayEspacio);
        for (int personaSentada = 0; personaSentada < reserva.listaDeAsistentes.length; personaSentada++) {
          patioDeButacas[filaDondeHayEspacio][columnaDondeHayEspacio+personaSentada] = reserva.listaDeAsistentes[personaSentada];
        }
      } else {
        println("La reserva: " + reserva.numeroDeReserva + " no se puede sentar en una misma fila.");
      }
    }
    return patioDeButacas;
  }
}




//#################################### REQUISITO 4 ####################################
void ordenarPorEdadCreciente(Asistente[][] patioDeButacas) {
  /* CORRESPONDIENTE AL REQUISITO 4
   
   Dado un patio de butacas, recorre cada una de las filas para ordenarlas (de forma independiente) por edad de menor a mayor.
   Para ello utiliza el algoritmo de ordenación por seleción en cada una de las filas. Se ha escogido este algoritmo porque, debido
   a la naturaleza del problema no podemos asegurar que inicialmente los datos sean favorables (en cuyo caso, sería preferible utilizar
   el algoritmo de inserción).*/
  if (patioDeButacas == null) {
    println("ERROR: Patio de butacas no ha sido inicializado");
  } else {
    for (int fila = 0; fila < patioDeButacas.length; fila++) {
      for (int columna = 0; columna < patioDeButacas[fila].length-1; columna++) {
        int columnaEdadMinima = columna;
        for (int columnaComparacion = columna+1; columnaComparacion < patioDeButacas[fila].length; columnaComparacion++) {
          if (patioDeButacas[fila][columnaComparacion] != null) { // Véase explicación I
            if (patioDeButacas[fila][columnaComparacion].edad < patioDeButacas[fila][columnaEdadMinima].edad) {
              columnaEdadMinima = columnaComparacion;
            }
          }
        }
        // Intercambio el asistente en la posicion (fila, columna) por aquel en la misma fila que tiene la menor edad (de la lista a partir de)
        // la posición del asistente sentado en la columna 'columna'.
        Asistente asistenteAuxiliar = patioDeButacas[fila][columna];
        patioDeButacas[fila][columna] = patioDeButacas[fila][columnaEdadMinima];
        patioDeButacas[fila][columnaEdadMinima] = asistenteAuxiliar;
      }
    }
  }
}




//#################################### REQUISITO 5 ####################################
int mayorEdad(Asistente[][] patioDeButacas) {
  /*CORRESPONDIENTE AL REQUISITO 5
   
   Dado un patio de butacas, lo recorre al completo para encontrar la mayor edad.
   
   Una solución alternativa es hacer uso de la función ordenarPorEdadCreciente() y estudiar la última posición de cada columna.
   Esta función es más eficiente porque no requiere hacer los intercambios de posición. De todas formas la función menorEdad
   se ha programado haciendo uso de ordenarPorEdadCreciente() para mostrar una solución alternativa.
   
   Otra posible solución sería definir la función int[] listaDeEdades(Asistente[][] patioDeButacas) que dado un patio de butacas
   devolviera una lista de las edades de los asistentes y luego usar las funciones ya incluidas en processing max() y min(). Sin embargo
   como se pide expresamente encontrar el máximo del patio de butacas, hemos decidido no utilizar max() ó min().
   */
  if (patioDeButacas == null) {
    return -1;
  }
  int mayorEdad = -1;
  for (int fila = 0; fila < patioDeButacas.length; fila++) {
    for (int columna = 0; columna < patioDeButacas[fila].length; columna++) {
      if (patioDeButacas[fila][columna] != null) { // Véase explicación I
        if (patioDeButacas[fila][columna].edad > mayorEdad) {
          mayorEdad = patioDeButacas[fila][columna].edad;
        }
      }
    }
  }
  if (mayorEdad == -1) {
    return -1; // No hay nadie en el patio de butacas.
  }
  return mayorEdad;
}

int menorEdad(Asistente[][] patioDeButacas) {
  /*CORRESPONDIENTE AL REQUISITO 5
   
   Dado un patio de butacas, ordena sus filas por edad creciente y recorre la primera columna para devolver la menor edad. La motivación de esta
   solución se explica en el comentario de la función mayorEdad()
   */
  if (patioDeButacas == null) {
    return -1;
  }

  int menorEdad = 150; // Valdría cualquier número arbitrariamente grande, mayor que cualquier edad posible.
  boolean alMenosUnaPersonaSentada = false; // Es solo una bandera, para en caso de que no haya ninguna persona sentada NO devolver 150.

  ordenarPorEdadCreciente(patioDeButacas);
  for (int fila = 0; fila < patioDeButacas.length; fila++) {
    if (patioDeButacas[fila][0] != null) {
      if (patioDeButacas[fila][0].edad < menorEdad) {
        menorEdad = patioDeButacas[fila][0].edad;
        alMenosUnaPersonaSentada = true;
      }
    }
  }
  if (!alMenosUnaPersonaSentada) {
    return -1;
  }
  return menorEdad;
}


//#################################### REQUISITO 6 ####################################
float calcularRecaudacionPorRecursividad(Asistente[][] patioDeButacas, int fila, int columna) {
  /* CORRESPONDIENTE AL REQUISITO 6
   
   Dada una matriz (patio de butacas), calcula de forma recursiva cúanto se ha recaudado para un evento concreto.
   Esta función es llamada desde calcularRecaudacion(), una función simplificada para el usuario que no incluye los índices recursivos.
   
   La recursividad se ha planteado de la siguiente forma:
   CASO BASE --> no hay más filas.
   PASO RECURSIVO --> Va sumando las entradas de los asistentes (avanzando por columnas cuando sea posible) y cuando no haya más columnas que avanzar,
   pasa a la siguiente fila (con el índice de la columna igualado a cero, es decir, comenzando desde la primera columna de nuevo).
   */
  if (fila >= patioDeButacas.length) {
    return 0;
  }

  if (columna < patioDeButacas[fila].length) {
    // Es decir, aún me quedan columnas en esta fila por recorrer
    if (patioDeButacas[fila][columna] != null) { // Véase explicación I
      return patioDeButacas[fila][columna].entrada.precio + calcularRecaudacionPorRecursividad(patioDeButacas, fila, columna+1);
    }
  }
  // Si ya no me quedan columnas por recorrer
  return calcularRecaudacionPorRecursividad(patioDeButacas, fila+1, 0);
}


float calcularRecaudacion(Asistente[][] patioDeButacas) {
  /*CORRESPONDIENTE AL REQUISITO 6
   
   Función "puente" que inicia la  función recursiva calcularRecaudaciónPorRecursividad()
   */
  if (patioDeButacas == null) {
    return -1;
  }
  return calcularRecaudacionPorRecursividad(patioDeButacas, 0, 0);
}

// ------------------------------------- INICIALIZACIÓN DEL PROGRAMA
void setup() {

  println("###################################### BOLETÍN II ######################################");
  println("\n--------------------REQUISITO 1--------------------");
  Reserva[] listaDeReservas = crearListaDeReservasAleatoria();
  imprimirListaDeReservas(listaDeReservas);
  println("-- COMPROBACIONES:"); // No hay comprobaciones a la función crearListaDeReservasAleatoria() porque esta no recibe parámetros.
  imprimirListaDeReservas(null);
  imprimirListaDeReservas(new Reserva[1]);

  println("\n--------------------PROCESO 2--------------------");
  println("PATIO DE BUTACAS: asistentes colocados separando las reservas");
  Asistente[][] patioDeButacas = colocarAsistentesSinImportarOrden(listaDeReservas);
  // OBSERVACIÓN: No hemos considerado el error de que una fila del patio de butacas en específico sea nula. Este es imposible por cómo se ha contruido
  // el programa y no hay ningún parámetro alterable que pueda modificarlo. Solo se daría si el usuario (programador) expresamente asigna
  // patioDeButacas[# fila] = null

  imprimirPatioDeButacas(patioDeButacas);
  println("-- COMPROBACIONES:");
  colocarAsistentesSinImportarOrden(null);

  // OBSERVACIÓN: Al considerar el número de filas (y columnas) una constante, la única forma de que generara un error, por ejemplo
  // ajustando numero de filas = -2 sería iniciando el programa con ese valor. Por si acaso, se ha tenido en cuenta en los requisitos 2 y 3.
  // De hecho, como fallarán los requisitos 2 y 3, el patio de butacas será nulo. Ajustar las filas o columnas a un valor negativo es una buena
  // forma de ver como falla prácticmaente todo el programa.

  println("\n--------------------REQUISITO 3--------------------");
  println("PATIO DE BUTACAS: asistentes colocados sin separar las reservas");
  patioDeButacas = colocarAsistentesRespetandoLasReservas(listaDeReservas);
  imprimirPatioDeButacas(patioDeButacas);
  println("-- COMPROBACIONES:");
  colocarAsistentesRespetandoLasReservas(null);

  println("\n--------------------REQUISITO 4---------------------");
  println("PATIO DE BUTACAS: asistentes colocados ordenando las edades de menor a mayor (en cada fila)");
  // Este requisito utiliza el aliasing de Processing. He decidido programarla así porque si el software fuera para un teatro real, los requisitos 2 y 3 se corresponderían
  // con la "creación" del patio de butacas (sentar a todo el mundo por primera vez). Ordenarlos por edad creciente es algo que se haría posteriormente,
  // con los asistentos ya asignados.

  // IMPORTANTE: Tal y como está programado ahora, los dueños del teatro "ordenan" el patio despúes de sentar a las personas sin romper los grupos por filas. Eso podría llevar
  // a intentar ordenar por edad un patio vacío (tiene peerfecto sentido, si nadie se puede sentar en el patio, no habrá ni menor ni mayor edad y por supuesto no podremos ordenar)
  // las filas de forma creciente o decreciente. El programa está preparado para manejar estos casos.
  ordenarPorEdadCreciente(patioDeButacas);
  imprimirPatioDeButacas(patioDeButacas);
  println("-- COMPROBACIONES:");
  ordenarPorEdadCreciente(null);

  println("\n--------------------REQUISITO 5---------------------");
  int mayorEdad = mayorEdad(patioDeButacas);
  int menorEdad = menorEdad(patioDeButacas);
  if (mayorEdad != -1) {
    println("La mayor edad del evento es: " + mayorEdad);
  } else {
    println("ERROR: Cálculo de la mayor edad");
  }
  if (menorEdad != -1) {
    println("La menor edad del evento es: " + menorEdad);
  } else {
    println("ERROR: Cálculo de la menor edad");
  }

  println("\n--------------------REQUISITO 6--------------------");
  float recaudacion = calcularRecaudacion(patioDeButacas);
  if (recaudacion >= 0) {
    println("La recaudación total ha sido de: " + calcularRecaudacion(patioDeButacas));
  } else {
    println("ERROR: Contabilización de la recaudación");
  }
}
