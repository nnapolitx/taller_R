¡Buenas tardes!

A continuación, dejo una lista de las sugerencias que dejo al script. Para 
facilitar y hacer más rápido la visualización, hago referencia a la línea del
código en el script original, seguido por un '/', la línea donde empieza el 
cambio en el script nuevo ('script_1-nn.R'), un '-', y la línea donde termina el
cambio en el script nuevo. Por ejemplo, el primer cambio fue agregado a la línea
71 en el script original, empieza en el script nuevo en 71, y termina en 93. No
dude escribirme con cualquier duda o pregunta. ¡Saludos!

71/71-93: Agregué esta explicación porque pienso, si alguien descarga un archivo
          .csv del internet de EEUU, es probable que el separador es un ',' y no 
          ';'. También, para ser consistente con el archivo, dejé la explicación 
          en inglés.

122/142-143: Agregué esta explicación de cómo aclarar el espacio de trabajo.

177/199-205: Cambié 'Anxiety' por 'Openess', para poder compararla data fácilmente
             ya que aparecen al lado en el dataframe.

181/202-202: Chatgpt me ayudó con este. Si haces un 'scale', R te da un matriz,
             inclusive si es con una sola variable, y luego inserta el matriz en
             el data frame, porque los data frames pueden contener matices (no 
             sabía eso). Entonces, para evitar problemas con manipulación de
             datos después, hay que insertarlo como un valor numeric.
             
187/209-210: la línea para ver y comparar los nuevos datos.



