#!/bin/bash
########## VARIABLES

################################################################################################################################### FUNCIONES

function dinero()
{
	money="$1"
	
	while [[ ! "$money" =~ ^[0-9]+$ ]] || [ "$money" -le 0 ]; do

		echo -ne "\n$purpleColour [+] $endColour Introduzca una cantidad $redColour válida $endColour de dinero -> $yellowColour$ $endColour " > /dev/tty
		read money
			
	done

	echo $money

}

function seq_c_checker()
{
	echo -ne "\n$purpleColour [+] $endColour Introduzca el $blueColourel [arreglo] $endColour separado por espacios -> " > /dev/tty
	read -a arr
	
	declare -i flag=0

	for element in "${arr[@]}"; do

    	if [[ ! "$element" =~ ^[0-9]+$ ]]; then
        	flag=1
        	break
    	elif [ "$element" -le 0 ]; then
        	flag=1
        	break

        else
			flag=0
    	fi

	done
	
	
	while [ "$flag" -eq 1 ]; do

    	echo -ne "\n$purpleColour [+] $endColour Introduzca un $blueColourel [arreglo] $endColour $redColour valido $endColour-> " > /dev/tty
    	read -a arr

    	for element in "${arr[@]}"; do
			if [[ ! "$element" =~ ^[0-9]+$ ]]; then
            	flag=1
            	break
        	elif [ "$element" -le 0 ]; then
            	flag=1
            	break
        	else
            	flag=0
        	fi
    	done

	done

	echo "${arr[@]}"
}

function seq_s_checker()
{
	local dineros="$1"
	shift
	local arr=("$@")
	suma=$((${arr[0]} + ${arr[-1]}))
	
	if [ "$suma" -gt "$dineros" ]; then

		echo -e "\n$purpleColour [+] $endColour La suma de el $redColour primer $endColour y $redColur ultimo $endColour elemento es más grande que el dinero apostado." > /dev/tty
    	echo -ne "\n$purpleColour [+] $endColour Introduzca $blueColourl a $endColour para cambiar el arreglo o $blueColourl d $endColour para ingresar más dinero -> " > /dev/tty
    	read a_d

    	while [ "$a_d" != "a" ] && [ "$a_d" != "d" ]; do

        	echo -ne "\n$purpleColour [+] $endColour Introduzca solamente $redColour a $endColour o $redColour d $endColour -> " > /dev/tty
        	read a_d

    	done
	
	else

		a_d=n
		
	fi
	
	echo "$a_d"
}


################################################################################################################### FLUJO
mon=$(dinero $money)

echo -e "\n$purpleColour [+] $endColour El dinero es $yellowColour $ $mon $endColour"

echo -ne "\n$purpleColour [+] $endColour La secuencia por defecto es $blueColourel (1 2 3 4) $endColour. Desea cambiarla? -> " && read yes_no

while [ "$yes_no" != "si" ] && [ "$yes_no" != "no" ]; do

	echo -ne "\n$purpleColour [+] $endColour Introduzca solamente $greenColour si $endColour o $redColour no $endColour -> " && read yes_no

done 

if [ "$yes_no" == "si" ]; then

	arr=($(seq_c_checker))
	echo -e "\n$purpleColour [+]$endColour El arreglo es: $blueColourel [ ${arr[@]} ] $endColour"
else

	declare -a arr=(1 2 3 4)

fi

while true; do

	respuesta=$(seq_s_checker "$mon" "${arr[@]}")

	if [ "$respuesta" == "a" ]; then

    	arr=($(seq_c_checker))
		echo -e "\n$purpleColour [+] $endColour El dinero es: $yellowColour $mon $endColour"
		
	elif [ "$respuesta" == "d" ]; then

		
		echo -ne "\n$purpleColour [+] $endColour Ingrese una cantidad $redColour valida $endColour de dinero -> " && read din
		mon=$(dinero "$din")
		echo -e "\n$purpleColour [+] $endColour El arreglo es: $blueColourel [ ${arr[@]} ] $endColour"
		
	else
	
		break
			
	fi
	
done

echo -ne "\n$purpleColour [+] $endColour A qué deseas apostar continuamente? ($greenColour par $endColour / $redColour impar $endColour) -> " && read par_impar

while [ "$par_impar" != "par" ] && [ "$par_impar" != "impar" ]; do

	echo -ne "\nIntroduzca solamente $greenColour par $endColour o $redColour impar $endColour -> " && read par_impar

done

initial_bet=$((${arr[0]} + ${arr[-1]}))

mon=$(($mon - $initial_bet))

arr_aux=("${arr[@]}")

echo -e "\nVas a apostar a $greenColour $par_impar $endColour con una apuesta inicial de $yellowColour $ $initial_bet $endColour y el arreglo $blueColourl ${arr[@]} $endColour"

echo -e "\nTe quedas con $yellowColour $ $mon $endColour"

declare -i contador=0

while true; do

	contador+=1

    random_number="$(($RANDOM % 37))"

	if [ "$par_impar" == "par" ]; then
		if [ "$random_number" -eq 0 ]; then 
			echo -e "$redColour- - - - - - - - - - - - - - - - - - - - $endColour"
			echo -e "El número es $redColour 0 $endColour por lo tanto $redColour perdemos $endColour"

			unset arr[0]
			unset arr[-1] 2>/dev/null
			arr=("${arr[@]}")
			
			longitud=${#arr[@]}

			if [ "$longitud" -eq 0 ]; then

				arr=("${arr_aux[@]}")
				initial_bet=$((${arr[0]} + ${arr[-1]}))
				mon=$((mon - initial_bet))

				if [ "$mon" -le 0 ]; then
					echo -e "$redColour! ! ! ! ! $endColour"
					echo -e "Te quedas con $redColour $ 0 $endColour"
					echo -e "$purpleColour[+] $endColour Te has quedado sin dinero! $redColour Has perdido! $endColour"
					break
				else

					echo -e "$pinkColour° ° ° ° ° $endColour"
					echo -e "$purpleColour[+] $endColour El arreglo se ha $pinkColour reiniciado $endColour -> $blueColourl ${arr[@]} $endColour"
					echo -e "$purpleColour[+] $endColour La apuesta es: $yellowColour $ $initial_bet $endColour"
					echo -e "$purpleColour[+] $endColour Te quedas con $yellowColour $ $mon $endColour"
				fi

			elif [ "$longitud" -eq 1 ]; then

				initial_bet=${arr[0]}
				mon=$((mon - initial_bet))
				if [ "$mon" -le 0 ]; then
					echo -e "$redColour! ! ! ! ! $endColour"
					echo -e "Te quedas con $redColour $ 0 $endColour"
                    echo -e "$purpleColour[+] $endColour Te has quedado sin dinero! Has perdido!"
                    break
                else
                
                	echo -e "$purpleColour[+] $endColour El arreglo es $blueColourl ${arr[@]} $endColour"
					echo -e "$purpleColour[+] $endColour La apuesta es: $yellowColour $initial_bet $endColour"
					echo -e "$purpleColour[+] $endColour Te quedas con $yellowColour $ $mon $endColour"
					
				fi
				
			else
			
				initial_bet=$((${arr[0]} + ${arr[-1]}))
                mon=$((mon - initial_bet))
                if [ "$mon" -le 0 ]; then
                	echo -e "$redColour! ! ! ! ! $endColour"
                	echo -e "Te quedas con $redColour $ 0 $endColour"
                    echo -e "$purpleColour[+] $endColour Te has quedado sin dinero! $redColour Has perdido! $endColour"
                    break
                else
                	            
                	echo -e "$purpleColour[+] $endColour El arreglo es $blueColourl ${arr[@]} $endColour"
               	 	echo -e "$purpleColour[+] $endColour La apuesta es: $yellowColour $initial_bet $endColour"
                	echo -e "$purpleColour[+] $endColour Te quedas con $ $yellowColour $mon $endColour"
				fi
			fi		

		elif [ "$((random_number % 2))" -ne 0 ]; then

			echo -e "$redColour- - - - - - - - - - - - - - - - - - - - $endColour"
			echo -e "El número $random_number es $redColour impar $endColour por tanto $redColour perdemos $endColour"

			unset arr[0]
            unset arr[-1] 2>/dev/null
            arr=("${arr[@]}")

            longitud=${#arr[@]}
            
			if [ "$longitud" -eq 0 ]; then

                arr=("${arr_aux[@]}")
                initial_bet=$((${arr[0]} + ${arr[-1]}))
                mon=$(($mon - $initial_bet))

                if [ "$mon" -le 0 ]; then
                	echo -e "$redColour! ! ! ! ! $endColour"
                	echo -e "Te quedas con $redColour $ 0 $endColour"
                    echo -e "$purpleColour[+] $endColour Te has quedado sin dinero! $redColour Has perdido! $endColour"
                    break
                else

       				echo -e "$pinkColour° ° ° ° ° $endColour"
                	echo -e "$purpleColour[+] $endColour El arreglo se ha reiniciado $blueColour ${arr[@]} $endColour"
                	echo -e "$purpleColour[+] $endColour La apuesta es: $yellowColour $initial_bet $endColour"
                	echo -e "$purpleColour[+] $endColour Te quedas con $yellowColour $ $mon $endColour"
                fi

            elif [ "$longitud" -eq 1 ]; then

                initial_bet=${arr[0]}
                mon=$(($mon - $initial_bet))
                if [ "$mon" -le 0 ]; then
                	echo -e "$redColour! ! ! ! ! $endColour"
                	echo -e "Te quedas con $redColour $ 0 $endColour"
                    echo -e "$purpleColour[+] $endColour Te has quedado sin dinero! $redColour Has perdido! $endColour"
                    break
          		else

					echo -e "$purpleColour[+] $endColour El arreglo es $blueColourl ${arr[0]} $endColour"
                    echo -e "$purpleColour[+] $endColour La apuesta es: $yellowColourl $initial_bet $endColour"
                    echo -e "$purpleColour[+] $endColour Te quedas con $yellowColour $ $mon $endColour"
          		
          		fi
            else
            	
                initial_bet=$((${arr[0]} + ${arr[-1]}))
                mon=$(($mon - $initial_bet))
                
            	if [ "$mon" -le 0 ]; then
            		echo -e "$redColour! ! ! ! ! $endColour"
            		echo -e "Te quedas con $redColour $ 0 $endColour"
            		echo -e "$purpleColour[+] $endColour Te has quedado sin dinero! $redColour Has perdido! $endColour"
            		break
            	else
            		
                	echo -e "$purpleColour[+] $endColour El arreglo es $blueColourl ${arr[@]} $endColour"
                	echo -e "$purpleColour[+] $endColour La apuesta es: $yellowColour $initial_bet $endColour"
                	echo -e "$purpleColour[+] $endColour Te quedas con $yellowColour $ $mon $endColour"
           	  	fi
           fi
        elif [ "$((random_number % 2))" -eq 0 ]; then

        	echo -e "$greenColour+ + + + + + + + + + + + + + + + + + + + $endColour"
        	echo -e "$purpleColour[+] $endColour El número $random_number es $greenColour par $endColour por tanto $greenColour ganamos $endColour"
        	recompensa=$((${arr[0]} + ${arr[-1]}))
        	arr+=("$recompensa")
        	initial_bet=$((${arr[0]} + ${arr[-1]}))
        	reward=$(($recompensa*2))
            mon=$(($mon + $reward))
        	echo -e "$purpleColour[+] $endColour El arreglo es $blueColourl ${arr[@]} $endColour"
        	echo -e "$purpleColour[+] $endColour Tu recompensa es: $greenColour $reward $endColour"
        	echo -e "$purpleColour[+] $endColour Te quedas con $yellowColour $ $mon $endColour"
        	mon=$((mon - initial_bet))
        	echo -e "$purpleColour[+] $endColour La apuesta es $yellowColour $initial_bet $endColour"
        	echo -e "$purpleColour[+] $endColour Te quedas con $yellowColour $mon $endColour"
        	
		fi

	elif [ "$par_impar" == "impar" ];then
		if [ "$random_number" -eq 0 ];then
			echo -e "$redColour- - - - - - - - - - - - - - - - - - - - $endColour"
            echo -e "El número es $redColour 0 $endColour por lo tanto $redColour perdemos $endColour"

            unset arr[0]
            unset arr[-1] 2>/dev/null
            arr=("${arr[@]}")

            longitud=${#arr[@]}

            if [ "$longitud" -eq 0 ]; then

                arr=("${arr_aux[@]}")
                initial_bet=$((${arr[0]} + ${arr[-1]}))
                mon=$((mon - initial_bet))

                if [ "$mon" -le 0 ]; then
                    echo -e "$redColour! ! ! ! ! $endColour"
                    echo -e "Te quedas con $redColour $ 0 $endColour"
                    echo -e "$purpleColour[+] $endColour Te has quedado sin dinero! $redColour Has perdido! $endColour"
                    break
                else

                    echo -e "$pinkColour° ° ° ° ° $endColour"
                    echo -e "$purpleColour[+] $endColour El arreglo se ha $pinkColour reiniciado $endColour -> $blueColourl ${arr[@]} $endColour"
                    echo -e "$purpleColour[+] $endColour La apuesta es: $yellowColour $initial_bet $endColour"
                    echo -e "$purpleColour[+] $endColour Te quedas con $yellowColour $ $mon $endColour"
                fi
             	   
             elif [ "$longitud" -eq 1 ]; then

                initial_bet=${arr[0]}
                mon=$((mon - initial_bet))
                if [ "$mon" -le 0 ]; then
                    echo -e "$redColour! ! ! ! ! $endColour"
                    echo -e "Te quedas con $redColour $ 0 $endColour"
                    echo -e "$purpleColour[+] $endColour Te has quedado sin dinero! Has perdido!"
                    break
                else

                	echo -e "$purpleColour[+] $endColour El arreglo es $blueColourl ${arr[@]} $endColour"
                    echo -e "$purpleColour[+] $endColour La apuesta es: $yellowColour $initial_bet $endColour"
                    echo -e "$purpleColour[+] $endColour Te quedas con $yellowColour $ $mon $endColour"

             	fi

        	 else

             	initial_bet=$((${arr[0]} + ${arr[-1]}))
                mon=$((mon - initial_bet))
                if [ "$mon" -le 0 ]; then
                    echo -e "$redColour! ! ! ! ! $endColour"
                    echo -e "Te quedas con $redColour $ 0 $endColour"
                    echo -e "$purpleColour[+] $endColour Te has quedado sin dinero! $redColour Has perdido! $endColour"
                    break
                else

                    echo -e "$purpleColour[+] $endColour El arreglo es $blueColourl ${arr[@]} $endColour"
                    echo -e "$purpleColour[+] $endColour La apuesta es: $yellowColour $initial_bet $endColour"
                    echo -e "$purpleColour[+] $endColour Te quedas con $ $yellowColour $mon $endColour"
                fi
             fi
        elif [ "$((random_number % 2))" -eq 0 ]; then

        	echo -e "$redColour- - - - - - - - - - - - - - - - - - - - $endColour"
            echo -e "El número $random_number es $redColour par $endColour por tanto $redColour perdemos $endColour"

            unset arr[0]
            unset arr[-1] 2>/dev/null
            arr=("${arr[@]}")

            longitud=${#arr[@]}

            if [ "$longitud" -eq 0 ]; then

                arr=("${arr_aux[@]}")
                initial_bet=$((${arr[0]} + ${arr[-1]}))
                mon=$(($mon - $initial_bet))

                if [ "$mon" -le 0 ]; then
                    echo -e "$redColour! ! ! ! ! $endColour"
                    echo -e "Te quedas con $redColour $ 0 $endColour"
                    echo -e "$purpleColour[+] $endColour Te has quedado sin dinero! $redColour Has perdido! $endColour"
                    break
                else

                    echo -e "$pinkColour° ° ° ° ° $endColour"
                    echo -e "$purpleColour[+] $endColour El arreglo se ha reiniciado $blueColour ${arr[@]} $endColour"
                    echo -e "$purpleColour[+] $endColour La apuesta es: $yellowColour $initial_bet $endColour"
                    echo -e "$purpleColour[+] $endColour Te quedas con $yellowColour $ $mon $endColour"
                fi
                
            elif [ "$longitud" -eq 1 ]; then

                initial_bet=${arr[0]}
                mon=$(($mon - $initial_bet))
                if [ "$mon" -le 0 ]; then
                    echo -e "$redColour! ! ! ! ! $endColour"
                    echo -e "Te quedas con $redColour $ 0 $endColour"
                    echo -e "$purpleColour[+] $endColour Te has quedado sin dinero! $redColour Has perdido! $endColour"
                    break
                else

                    echo -e "$purpleColour[+] $endColour El arreglo es $blueColourl ${arr[0]} $endColour"
                    echo -e "$purpleColour[+] $endColour La apuesta es: $yellowColourl $initial_bet $endColour"
                    echo -e "$purpleColour[+] $endColour Te quedas con $yellowColour $ $mon $endColour"

                fi
            else

                initial_bet=$((${arr[0]} + ${arr[-1]}))
                mon=$(($mon - $initial_bet))

                if [ "$mon" -le 0 ]; then
                    echo -e "$redColour! ! ! ! ! $endColour"
                    echo -e "Te quedas con $redColour $ 0 $endColour"
                    echo -e "$purpleColour[+] $endColour Te has quedado sin dinero! $redColour Has perdido! $endColour"
                    break
                else

                    echo -e "$purpleColour[+] $endColour El arreglo es $blueColourl ${arr[@]} $endColour"
                    echo -e "$purpleColour[+] $endColour La apuesta es: $yellowColour $initial_bet $endColour"
                    echo -e "$purpleColour[+] $endColour Te quedas con $yellowColour $ $mon $endColour"
                fi
            fi

        elif [ "$((random_number % 2))" -ne 0 ]; then

        	echo -e "$greenColour+ + + + + + + + + + + + + + + + + + + + $endColour"
            echo -e "$purpleColour[+] $endColour El numero $random_number es $greenColour impar $endColour por tanto $greenColour ganamos $endColour"
            recompensa=$((${arr[0]} + ${arr[-1]}))
            arr+=("$recompensa")
            initial_bet=$((${arr[0]} + ${arr[-1]}))
            reward=$(($recompensa*2))
            mon=$(($mon + $reward))
            echo -e "$purpleColour[+] $endColour El arreglo es $blueColourl ${arr[@]} $endColour"
            echo -e "$purpleColour[+] $endColour Tu recompensa es: $greenColour $reward $endColour"
            echo -e "$purpleColour[+] $endColour Te quedas con $yellowColour $ $mon $endColour"
            mon=$((mon - initial_bet))
            echo -e "$purpleColour[+] $endColour La apuesta es $yellowColour $initial_bet $endColour"
            echo -e "$purpleColour[+] $endColour Te quedas con $yellowColour $mon $endColour"
            
		fi
			 
	fi
	         
done

echo -e "\n $purpleColour [+] $endColour $blueColourll Numero total de jugadas: $endColour $contador"
