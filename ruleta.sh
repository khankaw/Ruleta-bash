#!/bin/bash

#############################COLORES##############################################

#Colours
greenColour="\e[38;5;46m\e[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[38;5;21m\e[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[38;5;92m\e[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"
pinkColour="\e[38;5;197m\e[1m"
pinklColour="\e[38;5;198m\e[1m"
pinkllColour="\e[38;5;199m\e[1m"
pinklllColour="\e[38;5;200m\e[1m"
pinkFive="\e[38;5;201m\e[1m"
pinkSix="\e[38;5;206m\e[1m"
pinkSeven="\e[38;5;207m\e[1m"
pinkEight="\e[38;5;213m\e[1m"
blueColourl="\e[38;5;27m\e[1m"
blueColourll="\e[38;5;33m\e[1m"
blueColourel="\e[38;5;39m\e[1m"


##################################################################################

##########CTRL_C##########

function ctrl_c()
{

	echo -e "\n$redColour [+] $endColour Saliendo...\n"
	exit 1

}

trap ctrl_c INT

##########################

##########FUNCIOES##########

function helpPanel()
{

	echo -e "\n $greenColour ********** Panel de ayda ********** $endColour \n"
	echo -e "\n $blueColourl -m $endColour Para indicar la cantidad de dinero a apostar\n"
	echo -e "\n $blueColourll -t $endColour Para indicar la tecnica de apuesta que se va a usar (linversa o martingala)\n"
	echo -e "\n $purpleColour Ejemplo: $endColour -m 100 -t martingala"
	
	exit 1
}

function martingala ()
{

	echo -e "\n Dinero inicial: $yellowColour $ $money $endColour \n"

	echo -ne "\nDinero para apostar -> " && read initial_bet

	while [[ ! "$initial_bet" =~ ^[0-9]+$ ]] || [ $initial_bet -le 0 ] || [ $initial_bet -gt $money ]; do

		echo -ne "\nIngresa una cantidad $redColour válida $endColour -> " && read initial_bet
		
	done
	
	backup="$initial_bet"		

	money=$(($money-$initial_bet))

	echo -ne "\nA qué deseas apostar continuamente? (par/impar) -> " && read bet

	while [ "$bet" != "par" ]; do

		if [ "$bet" == "impar" ]; then

			break
			
		else

			echo -ne "\nIndica solamente $greenColour par $endColour o $redColour impar $endColour -> " && read bet 
			
		fi
	
	done 
	
	echo -e "\nAcabas de apostar $yellowColour $initial_bet $endColour y tienes $yellowColour $money $endColour \n" 

	tput civis

	declare -i contador=0
		
	while [ "$money" -ge 0 ]; do

		let contador+=1
							
		random_number="$(($RANDOM % 37))"

		if [ "$bet" == "par" ]; then

			if [ "$((random_number % 2))" -eq 0 ]; then
		
				if [ "$random_number" -eq 0 ]; then
				
					initial_bet=$((initial_bet*2))
					
                	money=$(($money-$initial_bet))
					
					if [ "$money" -lt 0 ];then
					
                    	echo -e "$redColour- - - - - - - - - - - - - - - - - - - - $endColour"
                    	echo -e "El número es $redColour 0 $endColour por tanto $redColour perdemos $endColour\n"
                    	echo -e "$purpleColour[+] $endColour Tu apuesta se duplica a $yellowColour $initial_bet $endColour"
                    	echo -e "$purpleColour[+] $endColour Debes $redColour apostar más $endColour de lo que tienes!"
                    	echo -e "$purpleColour[+] $endColour Tu dinero ahora es $redColour 0$endColour. Lo$redColour perdiste todo!!! $endColour"
                	else
                    	echo -e "El número es $redColour 0 $endColour por tanto $redColour perdemos $endColour\n"
                    	echo -e "$purpleColour [+]$endColour Tu apuesta se duplica a $yellowColour $initial_bet $endColour"
                    	echo -e "$purpleColour [+]$endColour Tu dinero ahora es $yellowColour $money $endColour"
                	fi
                		
				else
					echo -e "$greenColour + + + + + + + + + + + + + + + + + + + + $endColour"
					echo -e "$purpleColour [+]$endColour El número $random_number es $greenColour par $endColour por lo tanto $greenColour ganamos $endColour"
					money=$((initial_bet*2 + $money))
					diferencia=$((initial_bet*2))
					echo -e "$purpleColour [+]$endColour Tu apuesta fue de $yellowColour $initial_bet $endColour"
					echo -e "$purpleColour [+]$endColour Ganaste $yellowColour $diferencia $endColour"
					echo -e "$purpleColour [+]$endColour Tu dinero ahora es  $yellowColour $ $money $endColour"
					initial_bet="$backup"
					echo -e "$purpleColour [+] $endColour La apuesta ahora se reinicia a $yellowColour $initial_bet $endColour"
				fi
			
			else

				initial_bet=$((initial_bet*2))
				money=$(($money-$initial_bet))
				
				if [ "$money" -lt 0 ];then
					echo -e "$redColour- - - - - - - - - - - - - - - - - - - -$endColour"
					echo -e "$purpleColour [+] $endColour El número $random_number es $redColour impar $endColour por lo tanto $redColour perdemos $endColour"
                    echo -e "$purpleColour [+] $endColour Tu apuesta se duplica a $yellowColour $initial_bet $endColour"
                    echo -e "$purpleColour [+] $endColour Debes $redColour apostar más $endColour de lo que tienes!"
					echo -e "$purpleColour [+] $endColour Tu dinero ahora es $redColour 0$endColour. Lo$redColour perdiste todo!!! $endColour"
				else
					echo -e "$redColour- - - - - - - - - - - - - - - - - - - -$endColour"
					echo -e "$purpleColour [+] $endColour El número $random_number es impar por lo tanto $redColour perdemos $endColour"
					echo -e "$purpleColour [+] $endColour Tu apuesta se duplica a $yellowColour $initial_bet $endColour"
					echo -e "$purpleColour [+] $endColour Tu dinero ahora es $yellowColour $money $endColour"
				fi
			fi
			
		elif [ "$bet" == "impar" ]; then

			if [ "$((random_number % 2))" -eq 0 ]; then

                if [ "$random_number" -eq 0 ]; then

                    initial_bet=$((initial_bet*2))

                    money=$(($money-$initial_bet))

                    if [ "$money" -lt 0 ];then

                        echo -e "$redColour- - - - - - - - - - - - - - - - - - - -$endColour"
                        echo -e "$purpleColour [+] $endColour El número es $redColour 0 $endColour por tanto $redColour perdemos $endColour\n"
                        echo -e "$purpleColour [+] $endColour Tu apuesta se duplica a $yellowColour $initial_bet $endColour"
                        echo -e "$purpleColour [+] $endColour Debes $redColour apostar más $endColour de lo que tienes!"
                        echo -e "$purpleColour [+] $endColour Tu dinero ahora es $redColour 0$endColour. Lo$redColour perdiste todo!!! $endColour"
                    else
                        echo -e "$redColour- - - - - - - - - - - - - - - - - - - -$endColour"
                        echo -e "El número es $redColour 0 $endColour por tanto $redColour perdemos $endColour\n"
                        echo -e "Tu apuesta se duplica a $yellowColour $initial_bet $endColour"
                        echo -e "Tu dinero ahora es $yellowColour $money $endColour"
                    fi
					
                else
                
                    initial_bet=$((initial_bet*2))
                	money=$(($money-$initial_bet))

                	if [ "$money" -lt 0 ];then
                    	echo -e "$redColour- - - - - - - - - - - - - - - - - - - -$endColour"
                    	echo -e "$purpleColour [+] $endColour El número $random_number es $redColour par $endColour por lo tanto $redColour perdemos $endColour"
                    	echo -e "$purpleColour [+] $endColour Tu apuesta se duplica a $yellowColour $initial_bet $endColour"
                    	echo -e "$purpleColour [+] $endColour Debes $redColour apostar más $endColour de lo que tienes!"
                    	echo -e "$purpleColour [+] $endColour Tu dinero ahora es $redColour 0$endColour. Lo$redColour perdiste todo!!! $endColour"
                	else
                    	echo -e "$redColour- - - - - - - - - - - - - - - - - - - -$endColour"
                    	echo -e "$purpleColour [+] $endColour El numero $random_number es $redColour par $redColour por lo tanto $redColour perdemos $endColour"
                    	echo -e "$purpleColour [+] $endColour Tu apuesta se duplica a $yellowColour $initial_bet $endColour"
                    	echo -e "$purpleColour [+] $endColour Tu dinero ahora es $yellowColour $money $endColour"
                	fi
            	fi
            
            else

                	echo -e "$greenColour+ + + + + + + + + + + + + + + + + + + +$endColour"
                    echo -e "$purpleColour [+] $endColour El número $random_number es $greenColour impar $endColour por lo tanto $greenColour ganamos $endColour"
                    money=$((initial_bet*2 + $money))
                    diferencia=$((initial_bet*2))
                    echo -e "$purpleColour [+] $endColour Tu apuesta fue de $yellowColour $initial_bet $endColour"
                    echo -e "$purpleColour [+] $endColour Ganaste $yellowColour $diferencia $endColour"
                    echo -e "$purpleColour [+] $endColour Tu dinero ahora es  $yellowColour $ $money $endColour"
                    initial_bet="$backup"
                    echo -e "$purpleColour [+] $endColour La apuesta ahora se reinicia a $yellowColour $initial_bet $endColour"
            fi
			
		fi			
			
	done

	echo -e "$blueColourll Numero total de jugadas: $endColour $contador"
		
	tput cnorm

}

function linversa()
{

	source linversa2.sh

}

###########################

##########FLUJO##########

while getopts "m:t:h" arg; do

	case $arg in

		m) money=$OPTARG;;
		t) tech=$OPTARG;;
		h) helpPanel;;
	
	esac

done
#########################

##########LLAMADAS##########

if [ $money ] && [ $tech ]; then

	if [ $money -le 0 ]; then
	
		echo -e "No se admite dinero negativo"

	else

		if [ "$tech" == "martingala" ]; then
			martingala
		elif [ "$tech" == "linversa" ]; then
			linversa
		else
			echo "No existe tal técnica"
			helpPanel
		fi
	fi 
else

	helpPanel
	
fi 

#########################
