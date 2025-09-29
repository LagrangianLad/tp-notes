class Libro {
  /*Para cada libro se quiere registrar su título, autor, el año en el que se publicó y una lista con las últimas 5 valoraciones
   (valor entre 0 y 5).*/
  String titulo;
  String autor;
  int ano;
  int numeroDeValoraciones;
  int[] valoraciones = new int[5];
  boolean reservado;
}

class Biblioteca {
  /*Una biblioteca debe tener registrado su número de licencia, el número de libros disponibles y tamaño del almacén de ésta.
   Para la biblioteca que nos ha encargado la aplicación, el almacén no es demasiado grande, caben un total de 500 libros como máximo.*/
  int numeroDeLicencia;
  int numeroDeLibrosDisponibles;
  Libro[] almacen;
  int numeroDeLibrosReservados;
}

class Lector {
  /*Modelar un registro que almacene la información de un lector: Nombre y apellidos, edad, si está o no sancionado y
   los libros que ha leído*/
  String nombre;
  String apellidos;
  int edad;
  boolean sancionado; // LO MODELO COMO QUE NO PUEDES ESTAR SANCIONADO POR UNA BIBLIOTECA Y NO SANCIONADO POR OTRA.
  int numeroDeLibrosLeidos;
  Libro[] librosLeidos;
}

Biblioteca crearBiblioteca(int numeroDeLicencia, int tamanoAlmacen) {
  /*Una función que permita crear nuestra biblioteca en base a su código de licencia y tamaño de almacén*/
  Biblioteca biblioteca = new Biblioteca();
  biblioteca.numeroDeLicencia = numeroDeLicencia;
  biblioteca.numeroDeLibrosDisponibles = 0;
  biblioteca.almacen = new Libro[tamanoAlmacen];
  biblioteca.numeroDeLibrosReservados = 0;
  return biblioteca;
}

Libro crearLibro(String titulo, String autor, int ano) {
  /*Una función que permita crear un libro a partir de su título, autor y año.*/
  Libro libro = new Libro();
  libro.titulo = titulo;
  libro.autor = autor;
  libro.ano = ano;
  libro.numeroDeValoraciones = 0;
  libro.reservado = false;
  return libro;
}

Lector crearLector(String nombre, String apellidos, int edad) {
  Lector lector = new Lector();
  lector.nombre = nombre;
  lector.apellidos = apellidos;
  lector.edad = edad;
  lector.sancionado = false;
  lector.numeroDeLibrosLeidos = 0;
  lector.librosLeidos = new Libro [500];
  return lector;
}

void insertarLibroEnBiblioteca(Libro libro, Biblioteca biblioteca) {
  /*Una función que permita insertar un libro en una biblioteca.*/
  if (biblioteca.numeroDeLibrosDisponibles == biblioteca.almacen.length) {
    println("Lo sentimos, la biblioteca está llena");
  } else {
    biblioteca.almacen[biblioteca.numeroDeLibrosDisponibles] = libro;
    biblioteca.numeroDeLibrosDisponibles++;
  }
}

void insertarLibroEnLector(Libro libro, Lector lector) {
  /*Añadir a la lista de libros leídos por un lector un libro*/
  if (lector.numeroDeLibrosLeidos == lector.librosLeidos.length) {
    println("Menudo frikardo ya no puede leer más");
  } else {
    lector.librosLeidos[lector.numeroDeLibrosLeidos] = libro;
    lector.numeroDeLibrosLeidos++;
  }
}

void imprimirLibro(Libro libro, boolean informacionExtendida) {
  /*Una función que imprima por pantalla toda la información relativa a un libro.*/
  println("··LIBRO··");
  println("\tTÍTULO: "+libro.titulo);
  println("\tAUTOR: "+ libro.autor);
  println("\tAÑO: " + libro.ano);

  if (informacionExtendida) {
    String textoValoraciones = "";
    for (int i = 0; i < libro.valoraciones.length; i++) {
      textoValoraciones += "" + libro.valoraciones[i] + " ";
    }
    println("\tVALORACIONES: " + textoValoraciones);
    println("\tVALORACIÓN MEDIA: " + valoracionMedia(libro));

    if (libro.reservado) {
      println("\tEL LIBRO ESTÁ RESERVADO");
    } else {
      println("\tEL LIBRO NO ESTÁ RESERVADO");
    }
  }
}

void imprimirBiblioteca(Biblioteca biblioteca) {
  /*Una función que imprima por pantalla toda la información relativa a una biblioteca*/
  println("·········BIBLIOTECA·········");
  println("\tNÚMERO DE LICENCIA: "+biblioteca.numeroDeLicencia);
  println("\tNÚMERO DE LIBROS DISPONIBLES: "+biblioteca.numeroDeLibrosDisponibles);
  println("\tNÚMERO DE LIBROS RESERVADOS: " +biblioteca.numeroDeLibrosReservados);
  println("\tALMACEN DE LA BIBLIOTECA: ");
  for (int i = 0; i < biblioteca.numeroDeLibrosDisponibles; i++) {
    imprimirLibro(biblioteca.almacen[i], false);
  }
}

void imprimirLector(Lector lector) {
  /*Imprime todos los datos de un lector*/
  println("\nLECTOR: " + lector.nombre +""+ lector.apellidos + "(" + lector.edad + " años)");
  println("\t ESTADO DE SANCIÓN: " + lector.sancionado);
  for (int i = 0; i < lector.numeroDeLibrosLeidos; i++) {
    imprimirLibro(lector.librosLeidos[i], false);
  }
}

float valoracionMedia(Libro libro) {
  /*Una función que devuelva la valoración media de un libro.*/
  int suma = 0;
  for (int i = 0; i < libro.valoraciones.length; i++) {
    suma+=libro.valoraciones[i];
  }
  if (libro.numeroDeValoraciones > 5) {
    return (suma / (float) libro.valoraciones.length);
  } else if (libro.numeroDeValoraciones > 0) {
    return (suma / (float) libro.numeroDeValoraciones);
  } else {
    return 0;
  }
}


float valoracionMediaBiblioteca(Biblioteca biblioteca) {
  /*Una función que devuelva la valoración media de todos los libros de una biblioteca*/
  float suma = 0;
  for (int i = 0; i < biblioteca.numeroDeLibrosDisponibles; i++) {
    suma += valoracionMedia(biblioteca.almacen[i]);
  }
  return ( suma / biblioteca.numeroDeLibrosDisponibles);
}

void valorarLibro(Libro libro, int valoracion) {
  /*Permite añadir una valoracion a un libro, sobreescribiendo las que ya están puestas*/
  libro.valoraciones[libro.numeroDeValoraciones % 5] = valoracion;
  libro.numeroDeValoraciones++;
}

void reservarLibro(Biblioteca biblioteca, Libro libro, Lector lector) {
  if (libro.reservado) {
    println("Lo sentimos, el libro ya ha sido prestado");
  } else if (lector.sancionado) {
    println("El lector " + lector.nombre + " " + lector.apellidos + " está sancionado y por tanto no puede reservar el libro");
  } else {
    biblioteca.numeroDeLibrosReservados++;
    boolean libroYaLeido = false;
    for (int i = 0; i < lector.numeroDeLibrosLeidos; i++) {
      if (lector.librosLeidos[i] == libro) {
        libroYaLeido = true;
      }
    }
    if (!libroYaLeido && lector.numeroDeLibrosLeidos < lector.librosLeidos.length) {
      libro.reservado = true;
      insertarLibroEnLector(libro, lector);
      println("Libro reservado correctamente!");
    }
  }
}

void sancionar(Lector lector) {
  println("Lector " + lector.nombre + " " + lector.apellidos + " sancionado correctamente");
  lector.sancionado = true;
}

void setup() {
  Biblioteca bib = crearBiblioteca(1, 500);

  Libro l1 = crearLibro("Un mundo feliz", "Aldous Huxley", 1948);
  Libro l2 = crearLibro("Santa biblia de Jerusalén", "El mesías", 5);
  Libro l3 = crearLibro("Cálculo", "Spivak", 1980);


  imprimirLibro(l1, true);
  imprimirLibro(l2, true);
  imprimirLibro(l3, true);

  insertarLibroEnBiblioteca(l1, bib);
  insertarLibroEnBiblioteca(l2, bib);
  insertarLibroEnBiblioteca(l3, bib);
  imprimirBiblioteca(bib);


  valorarLibro(l1, 1);
  valorarLibro(l1, 2);
  valorarLibro(l1, 3);
  valorarLibro(l2, 5);
  valorarLibro(l3, 5);
  valorarLibro(l3, 5);
  valorarLibro(l3, 5);
  valorarLibro(l3, 5);
  valorarLibro(l3, 5);
  valorarLibro(l3, 1);
  valorarLibro(l3, 2);

  Lector lec1 = crearLector("Manolo", "Saorín Castaño", 88);
  insertarLibroEnLector(l1, lec1);
  insertarLibroEnLector(l2, lec1);
  imprimirLector(lec1);
  reservarLibro(bib, l3, lec1);

  Lector lec2 = crearLector("Ana", "Morales Martínez", 44);
  reservarLibro(bib, l3, lec1);

  imprimirBiblioteca(bib); // Para ver si el libro se ha reservado bien

  sancionar(lec1);
  sancionar(lec2);

  reservarLibro(bib, l1, lec2); // Error por sanción
}
