# Digital_Voltmeter

El objetivo del trabajo consistió en especificar, diseñar, describir una arquitectura, simular, sintetizar e implementar en una FPGA, a partir de lenguaje descriptor de hardware VHDL, un sistema para un voltímetro digital con un rango de medición entre 0V y 3.30V, y con salida VGA. 

Se Implementó un voltímetro conformado por un conversor A/D Sigma-Delta con salida VGA. Dicho trabajo, se sintetizó con la herramienta Vivado. 
Se utilizó la placa Arty A7-35.


#<b>DISEÑO</b>

Como primera parte del diseño, se desarrollaron los componentes básicos para el armado de los bloques principales del voltímetro. 

- Flip Flop D 
 
Biestable utilizado en la mayoría de los componentes como memoria básica para las operaciones de lógica secuencial. Su función es dejar pasar lo que entra por D, a la salida Q, después de un pulso del reloj. Con esto se pudo generar sincronismo, registros y contadores. 
Contador genérico de N bits 
Este bloque se compone de N flip-flops tipo D en cascada, y se emplea para realizar el conteo de 0 a N y generar el ciclo de muestreo. Al llegar a N genera la señal de habilitación del registro para retener los datos muestreados, luego en N+1 genera un reset para el contador BCD y resetea la propia cuenta. 

- Comparador de N bits 

El comparador de N bits se encarga de ir comparando bit a bit las dos entradas ( A y B), indicando la relación de igualdad o desigualdad entre ellas por medio de "tres flags lógicos"
que corresponden a las relaciones A igual B, A mayor que B y A menor que B. Cada uno de estos flags se activará solo cuando la relación a la que corresponde sea verdadera, es decir, su salida sea 1 y las otras dos produzcan una salida igual a cero. Si la comparación del bit más significativo resulta mayor o menor, el resultado de la operación finaliza, si son iguales se habilita el siguiente comparador del bit consecutivo y vuelve a comparar, así sucesivamente hasta llegar al último bit. 
Contador BCD genérico de N dígitos 
Para generar un contador BCD genérico de N dígitos, se acoplaron varias etapas del contador BCD de un dígito. Este último, está conformado por un contador de 4 bits y un bloque que genera un flag cuando la cuenta llega al número 9, lo cual indica que hay que resetear la cuenta y comenzar de nuevo. 


Una vez desarrollados los componentes básicos, se procedió a analizar el proyecto en 3 bloques generales. 

-Bloque 1: Sigma-Delta 

El conversor sigma-delta se implementó incorporando un lazo de realimentación con unas resistencias junto con un capacitor a la entrada, más un registro que almacena los estados. 

-Bloque 2: ADC

El ADC es el encargado de adquirir los datos. Este bloque tiene como entrada la señal proveniente del sigma-delta y es interpretada por un contador de 3300000 cuentas que se encarga de generar una ventana de tiempo en la cual el contador BCD de 7 dígitos contabiliza la cantidad de estados altos generados. 
Cuando se llega al valor 3300000, el contador binario genera un flag de reset el cual resetea al contador BCD y a la vez habilita a 3 registros de 4 bits que van a mantener los valores censados hasta la siguiente señal de reset. 

-Bloque 3: Controlador VGA

El controlador de la VGA recibe los datos del ADC, los procesa y luego los presenta en pantalla, este bloque posee: 
• 2 contadores binarios que funcionan como coordenadas bidimensionales de los píxeles de la pantalla y determinados bits funcionan como selector en el multiplexor y como coordenadas en la memoria ROM. 
• Los registro a la entrada para el mismo funcionamiento que en el bloque ADC.
• Un multiplexor que se encarga de elegir el carácter según la posición de la pantalla en que se encuentran los contadores. La selección de la entrada que se va a reflejar en la salida se hace a través de la entrada de selección, habilitada por la señal “ena”. Ambas dependen de la sincronización horizontal y vertical del bloque de control VGA, procesadas por el bloque 
de lógica. 
• Una memoria ROM que contiene la información sobre los caracteres a mostrar en pantalla, y funciona como un combinacional al cual se le dan los datos de dirección del carácter, fila y columna, y cuya salida es un bit que está en "1" o en "0" según el carácter y la posición. • Decodificador 3 a 8. para demultiplexar. 
• 2 bloques que generan el sincronismo horizontal y vertical necesario para la comunicación con el monitor de entrada VGA. 

#VOLTIMETRO DIGITAL

El bloque sigma delta genera pulsos donde la densidad de estos es proporcional al nivel de tensión Vin, con el bloque ADC se contabilizan dichos niveles y su valor queda codificado en BCD, luego esos valores son mostrados en pantalla mediante el control VGA. Todos los bloques están sincronizados con el clk configurado e instanciado del módulo MMCM, encargado de generar un reloj de 25 MHz. 

-Prueba del circuito

Para el testeo, se generó una sucesión de 1's equiespaciados, de tal manera de poder controlar la tensión de entrada al circuito mediante un DAC. La salida generada se plasmó en el monitor en saltos en la tensión de aprox 0,10 V y se agregó un led indicador del nivel de tensión.




For more information: emilianobuglioni@gmail.com




