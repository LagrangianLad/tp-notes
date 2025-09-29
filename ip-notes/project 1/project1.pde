/*
 FUNDAMENTOS DE LA PROGRAMACIÓN - BOLETÍN 1
 Corbalán de Concepción, Pablo
 DNI: 49339953P
 DTIE Matemáticas y física  2024/25
 */



// ======================== FUNCIÓN 1 ========================

void generarPale (int numeroCajasPale, float pesoIdealCaja) {
  /*
  CORRESPONDIENTE A FUNCIÓN 1: SIMULACIÓN DE UN PALÉ
   
   Dado un entero (el número de cajas) y el peso que hipotéticamente debería pesar
   cada una de las cajas (si la tolva fuera perfecta) genera un palé de cajas y muestra
   por pantalla el peso (real) del palé así como el porcentaje de exceso de peso que tiene.
   
   No devuelve ningún dato porque imprime directamente por pantalla toda la información sobre el palé
   */

  println("El número de cajas del palé es: " + numeroCajasPale);
  // Comprobaciones de los argumentos, si todo va bien, ejecutamos el proceso 1.
  if (numeroCajasPale <= 0) {
    println("·ERROR PROCESO 1: El número de cajas tiene que ser estrictamente positivo." ); // Suponemos que un panel sin cajas no tiene sentido
  } else if (pesoIdealCaja <= 0) {
    println("·ERROR PROCESO 1: El peso ideal de cada caja tiene que ser estrictamente positivo.");
  } else {
    float pesoPale = 0; // Peso total del pale (considerando el error en la medida)
    for ( int caja = 0; caja < numeroCajasPale; caja++) {
      pesoPale += random(pesoIdealCaja, pesoIdealCaja + 1);
    }

    float pesoIdealPale = numeroCajasPale * pesoIdealCaja; // Aunque para nuestro ejemplo sea un número entero, lo declaramos como float para permitir el escenario en el que una caja pesa 4.5 kg idealmente.
    
    
    // 'porcentaje de exceso de peso que tiene' se puede entender de dos maneras:
    
    //      1 ) Porcentaje relativo: es decir, que porcentaje representa el exceso respecto al peso ideal
    //          Por ejemplo, si la caja tuviera que pesar 10 kg (peso ideal) y pesara 12 (peso real), el porcentaje relativo es 20%
   
    //      2 ) Porcentaje absoluto: es decir, que porcentaje representa el peso total respecto al peso ideal
    //          En el mismo ejemplo (peso ideal = 10kg, peso real = 12kg) el porcentaje absoluto es 120%.
    
    // Para evitar ambigüedad calculamos ambos.
    
    float porcentajeExcesoPesoPaleRelativo = ( (pesoPale - pesoIdealPale) / pesoIdealPale) * 100;
    float porcentajeExcesoPesoPaleAbsoluto = (pesoPale / pesoIdealPale) * 100;

    println("El peso del palé es: " + pesoPale);
    println("El porcentaje de peso en exceso del palé (RELATIVO) es: " + porcentajeExcesoPesoPaleRelativo + "% (sobre el peso ideal, " + pesoIdealPale + ").");
    println("El porcentaje de peso en exceso del palé (ABSOLUTO) es: " + porcentajeExcesoPesoPaleAbsoluto + "% (sobre el peso ideal, " + pesoIdealPale + ").");

  }
}




// ======================== FUNCIÓN 2 ========================

float diferenciaPesos(float pesoIdeal, float pesoReal) {
  /*
  CORRESPONDIENTE A FUNCIÓN 2: DIFERENCIA ENTRE DOS PESOS
   
   Dados dos pesos (pesoIdeal y pesoReal) siendo el peso real siempre mayor que el peso ideal,
   se calcula la diferencia de ambos pesos y se devuelve como un número real.
   */
  float diferenciaPeso = -1; // inicializamos en un valor de control que no se puede alcanzar si el programa funciona correctamente porque peso ideal < peso real

  if ( pesoIdeal <= 0 || pesoReal <= 0) {
    println("·ERROR PROCESO 2: Tanto el peso real como el peso ideal tienen que ser estrictamente positivos.");
  } else if (pesoReal > pesoIdeal) {
    diferenciaPeso = pesoReal - pesoIdeal;
  } else {
    println("·ERROR PROCESO 2. No se puede ejecutar el programa porque el peso real tiene que ser mayor que el ideal.");
  }
  return diferenciaPeso;
}




// ======================== FUNCIÓN 3 ========================

int sumarCifras(int numero) {
  /*
  Función auxiliar que dado un número entero devuelve la suma de sus cifras. 
  Por ejemplo, sumarCifras(321) --> 6.
  */
  int suma = 0;
  while (numero > 0) {
    suma += (numero % 10);
    numero = numero / 10;
  }
  return suma; 
}

void codigosNumericos (int numeroDeCodigos, int codigoProductoBase) {
  /*
  CORRESPONDIENTE A FUNCIÓN 3: CÓDIGOS NUMÉRICOS ÚNICOS
   
   Dado un entero (el número de códigos a generar) y un segundo entero de tres cifras que actúa como el código base para el producto
   devuelve tantos códigos únicos cómo se han pedido con el siguiente formato
   
   XX FF PPP C
   
   Donde:
   - XX es el código del país (84 para españa).
   - FF es el código del fabricante (30 o 34).
   - PPP es el código del producto (comenzando en el código base proporcionado a la función e incrementándolo en uno con cada nuevo código generado).
   - C es el dígito de control, resultante del módulo 8 de la suma de todas las cifras anteriores y calculado externamente en la función calcularDigitoDeControl().
   
   La función no devuelve ningún valor, porque imprime todos los códigos por consola directamente.
   */

  final int CODIGO_ESP = 84; // Suponemos que solo hacemos envíos a españa y por tanto solo tenemos que considerar el código numérico de país '84'.


  if (numeroDeCodigos <= 0) {
    println("·ERROR PROCESO 3: El número de códigos a generar ha de ser estrictamente positivo, " + numeroDeCodigos + " no es un número válido");
  } else {
    int codigoProductoActual = codigoProductoBase;

    for (int i = 0; i < numeroDeCodigos; i++) {
      
      // Como el código del fabricante es 30 ó 34 (equiprobablemente), lo asignamos por defecto a 30
      // Posteriormente, lo cambiamos a 34 con un 50% de posibilid.
      int codigoFabricante = 30;
      if (random(0, 1) < 0.5) {
        codigoFabricante = 34;
      }


      int codigoDigitoDeControl = ((sumarCifras(CODIGO_ESP) + sumarCifras(codigoFabricante) + sumarCifras(codigoProductoActual)) % 8);
      
      // Los tres 'if' solamente se encargan del formato del código del producto. 
      if (codigoProductoActual < 10) {
        println("Código de seguridad " + (i+1) + " -->" +  CODIGO_ESP + "" + codigoFabricante + "00" + codigoProductoActual + "" + codigoDigitoDeControl);
      } else if (codigoProductoActual < 100) {
        println("Código de seguridad " + (i+1) + " -->" +  CODIGO_ESP + "" + codigoFabricante + "0" + codigoProductoActual + "" + codigoDigitoDeControl);
      } else {
        println("Código de seguridad " + (i+1) + " -->" +  CODIGO_ESP + "" + codigoFabricante + "" + codigoProductoActual + "" + codigoDigitoDeControl);
      }

      // Debemos considerar el caso en el que el código del producto supera las tres cifras para evitar que el programa pase del 999
      if (codigoProductoActual != 999) {
        codigoProductoActual++; // Actualizamos el código del producto (los 3 dígitos)
      } else {
        codigoProductoActual = 0; // Reiniciamos al menor código de producto, que será el 0 (suponemos en nuestro programa que 000 es un número válido de tres cifras).
      }
    }
  }
}




// ======================== FUNCIÓN 4 ========================

float descargarCaramelos (int numeroDeDescargas, float kgPorCaja) {
  /* CORRESPONDIENTE A FUNCIÓN 4: DESCARGA DE CARAMELOS
  
   Dado un número entero correspondiente a cuántas veces debe descargar la tolva por caja y el peso ideal que la caja
   debería tener despúes de tal número de descargas, carga la caja devolviendo el peso real (de la caja) despúes de 
   las descargas. 
   */

  if (numeroDeDescargas <= 0) {

    println("·ERROR PROCESO 4: El número de descargas ha de ser estríctamente positivo");
    return -1.0;
  } else if (kgPorCaja <= 0) {

    println("·ERROR PROCESO 4: La peso por cada caja ha de ser estríctamente positivo");
    return -1.0;
    
  } else {

    float pesoCaja = 0; // Variable que actúa como contador para el peso de la caja
    float kgPorDescarga = kgPorCaja / numeroDeDescargas;
    println("Se van a realizar " + numeroDeDescargas + " descargas de " + kgPorDescarga + "kg cada una.");

    for (int i = 0; i < numeroDeDescargas; i++) {
      pesoCaja += random(kgPorDescarga, kgPorDescarga*1.1);
    }
    return pesoCaja;
  }
}




// ======================== FUNCIÓN 5 ========================

boolean optimizarCajas(int numeroDeCajas) {
  /*CORRESPONDIENTE A FUNCIÓN 5: CONFIGURACIÓN ÓPTIMA DE CAJAS
  
   Dado un número de cajas, busca una configuración de cajas para el palé teniendo en cuenta que:
   - En un palé hay entre 3 y 8 columnas de la misma altura.
   - Si alguna columna tiene más de ocho cajas de altura, debemos mostrar un mensaje de precaución.
   
   La función devuelve un valor booleano correspondiente a si es (o no) posible encontrar una configuración óptima de cajas.
   En caso de que sí lo sea, escribe todas las posibles configuraciones por pantalla.
   */

  boolean optimizacionPosible = false; // Será verdadero cuando haya una forma de optimizar las cajas
  println("Se van a distribuir " + numeroDeCajas + " cajas");

  if (numeroDeCajas <= 0) {
    println("· ERROR PROCESO 5: El número de cajas a distribuir ha de ser estrictamente positivo");
    return optimizacionPosible;
  }

  int alturaColumna;

  for (int numeroDeColumnas = 3; numeroDeColumnas <= 8; numeroDeColumnas++) {
    // Una vez fijo el número de columnas que queremos que el palé tenga, hay una única distribución posible (Unicidad del mínimo común múltiplo, Euclides).

    if ((numeroDeCajas % numeroDeColumnas) == 0) {
      optimizacionPosible = true;
      alturaColumna = numeroDeCajas / numeroDeColumnas;

      println("Una posible distribución de cajas es: " + numeroDeColumnas + " columnas, cada una con " + alturaColumna + " cajas. ");
      // Verificamos si esta distribución tiene más de ocho cajas por columna, en tal caso mandamos un mensaje.
      if (alturaColumna > 8) {
        println("¡CUIDADO! supera el límite de altura");
      } else {
        println("Esta distribución cumple con todos los requisitos.");
      }
    }
  }
  return optimizacionPosible;
}





void setup () {
  // DUDA: PESO IDEAL CAJA FUERA DEL SETUP (Y ME QUITO PARAM) O LA DEJO DENTRO Y LA PASO COMO PARAM
  final float PESO_IDEAL_CAJA = 8;
  println("############################### BOLETÍNN I ###############################\n");
  println("Cada función se ejecutará una vez con datos aleatorios en un rango adecuado.");
  println("Después de la ejecución usual, y tras la palabra 'COMPROBACIONES' ejecutaremos cada una de las funciones con casos límite y erróneos\n\n");



  println("····· PROCESO 1: SIMULACIÓN DE UN PALÉ ·····");
  generarPale((int) random(1, 100), PESO_IDEAL_CAJA); // La propia función ya muestra por la consola la información sobre el palé
  println("\nCOMPROBACIONES:");
  generarPale(-4, PESO_IDEAL_CAJA); // Numero negativo de cajas en el palé
  generarPale(10, -3); // Peso ideal de cada caja negativo


  println("\n····· PROCESO 2: DIFERENCIA DE PESOS ·····");
  // DUDA: Pongo el print dentro o fuera de la función
  float pesoRealCaja = random(PESO_IDEAL_CAJA, PESO_IDEAL_CAJA + 1);
  println("La diferencia entre: " + pesoRealCaja + "kg (peso real) y " + PESO_IDEAL_CAJA + "kg (peso ideal) es: " + diferenciaPesos(PESO_IDEAL_CAJA, pesoRealCaja) + "kg");
  println("\nCOMPROBACIONES:");
  diferenciaPesos(-2, 10); // Peso ideal negativo
  diferenciaPesos(10, -2); // Peso real negativo
  diferenciaPesos(7, 6); // Peso ideal mayor que el peso real


  println("\n····· PROCESO 3: CÓDIGOS NUMÉRICOS ·····");
  int numeroDeCodigos = (int)random(5, 11);
  int codigoBaseDelProducto = (int)random(0, 999.999);
  codigosNumericos(numeroDeCodigos, codigoBaseDelProducto); // Como los códigos se generan dentro de un for en la propia función, se imprimen por consola ahí
  println("\nCOMPROBACIONES:");
  codigosNumericos(-10, codigoBaseDelProducto); // Generar un número negativo de códigos


  println("\n····· PROCESO 4: DESCARGA DE CARAMELOS  ·····");
  int numeroDeDescargas = (int)random(5, 15);
  int kgPorCaja = (int)random(6, 20);
  println("El peso final de la caja, tras las descargas es de: " +  descargarCaramelos(numeroDeDescargas, kgPorCaja) + "kg.");
  println("\nCOMPROBACIONES:");
  descargarCaramelos(-10, kgPorCaja); // Número de descargas negativo
  descargarCaramelos(numeroDeDescargas, -10); // Número de kg en cada descarga negativo.

  println("\n····· PROCESO 5: CONFIGURACIÓN ÓPTIMA DE CAJAS  ·····");
  int numeroDeCajas = (int) random(5, 120);
  if (optimizarCajas(numeroDeCajas)) {
    println("El programa ha concluido que la distribución se puede optimizar de al menos una forma");
  } else {
    println("Lo sentimos, la distribución de estas cajas no se pueden optimizar correctamente");
  }
  println("\nCOMPROBACIONES:");
  optimizarCajas(-10); // Número de cajas a optimizar negativo

  println("\n····· FIN DE TODOS LOS PROCESOS  ·····");
}
