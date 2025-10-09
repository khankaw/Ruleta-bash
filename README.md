Es un programita simple que te ayuda a entender porque las apuestas son malas en general.

### El programa se inicia así: ###  

./ruleta.sh -m (dinero) -t (tecnica)

Solamente están disponibles las técnicas de apuesta Martingala y Labouchere Inversa

## **Martingala**  
Es una técnica de apuesta con suerte simple. Apuestas una cantidad inicial
a par o impar.
### Si ganas ###  
- Se te devuelve la apuesta inicial multiplicada por 2  
### Si pierdes ###  
- Apuestas el doble de la apuesta inicial  

## **Labouchere Inversa** ##
También funciona con suerte simple, sin embargo la apuesta y la recompensa se calculan en base a un arreglo inicial, ya sea (1, 2, 3, 4) o uno distinto que sea definido, además que es un método en el que se apuesta en todo momento, ya sea que se gane o se pierda.

La apuesta empezará a ser el primer elemento del arreglo más el último (1+4=5).

### Si ganas ###  
- Se añade la apuesta inicial (5 en el ejemplo) como elemento del arreglo para calcular la siguiente apuesta
- Se te devuelve el doble de lo que apostaste
### Si pierdes ###
- Se quitan el último elemento del arreglo para calcuar la apuesta.
- Si el arreglo se queda en 0 elementos se reinicia al original
- Solamente se te quita la suma de los elementos como apuesta, no se quita el doble
