#!/bin/bash
verification (){ #focntion qui vérifie que les arguments entrés par l'utilisateur correspondent à ceux attendu par le programme
	test=" "
	for ((arg = 1; arg <= $#; arg++)); do
	if [[ ${!arg} != "-t1" ]] && [[ ${!arg} != "-t2" ]] && [[ ${!arg} != "-t3" ]] && [[ ${!arg} != "-p1" ]] && [[ ${!arg} != "-p2" ]] && [[ ${!arg} != "-p3" ]] && [[ ${!arg} != "-w" ]] && [[ ${!arg} != "-h" ]] && [[ ${!arg} != "-m" ]] && [[ ${!arg} != "-F" ]] && [[ ${!arg} != "-G" ]] && [[ ${!arg} != "-S" ]] && [[ ${!arg} != "-A" ]] && [[ ${!arg} != "-O" ]] && [[ ${!arg} != "-Q" ]] && [[ ${!arg} != "--tab" ]] && [[ ${!arg} != "--abr" ]] && [[ ${!arg} != "--avl" ]] && [[ ${!arg} != "--help" ]] && [[ ${!arg} != "-f" ]] && [[ ${!arg} != *.csv ]] && [[ ${!arg} != "-d" ]]; then
		echo -e "\033[31mErreur ! Vous n'avez pas entré d'arguments valides. Veuillez réessayer\033[0m"
		exit 1 #on sort du programme car un des arguments rentrés n'est pas valide
	elif [[ ${!arg} = "-f" ]]; then
		arg=$(( arg+1 )) #on prend l'argument directement après -f 
		test=1
		if [[ ${!arg} = *.csv ]]; then #pour vérifier qu'il soit bien un fichier csv
			file=${!arg}
			echo "Vous avez bien entré un fichier compatible"
		else
			echo "Erreur ! Vous n'avez pas entré de fichier compatible"
			exit 1
		fi
	fi
done
if [[ $test = " " ]];then
	echo "ici"
	echo -e "Erreur ! Vous n'avez pas entré le nom du fichier"
	exit 1
fi
Tri_lieux1 $file $@
}
aide () { # fonction qui affiche l'aide si l'argument --help est détecté 
	for arg2 in $@
	do
	if [[ $arg2 = "--help" ]]; then
		echo "Vous avez demandé de l'aide. Voici donc la liste d'actions possibles."
		echo "Voici les différentes options de type de données :"
		echo "	-t<mode> pour la température. Un seul à la fois"
		echo "		->t1 pour avoir les températures minimale, moyennes et maximales par station"
		echo "		->t2 pour avoir le jour et l'heure des mesures et sa moyenne"
		echo "		->t3 pour avoir la date et les valeurs mesurées triés par ordre de stations"
		echo "	-p<mode> pour la pression atmosphérique. Un seul à la fois"
		echo "		->p1 pour avoir les températures minimale, moyennes et maximales par station"
		echo "		->p2 pour avoir le jour et l'heure des mesures et sa moyenne"
		echo "		->p3 pour avoir la date et les valeurs mesurées triés par ordre de stations"
		echo "	-w pour avoir le vent"
		echo "	-h pour avoir la hauteur'"
		echo "	-m pour avoir l'humidité'"
		echo "Voici les différentes restrictions géographiques :"
		echo "	-F pour avoir la France métropolitaine"
		echo "	-G pour avoir la Guyane"
		echo "	-S pour avoir Saint-Pierre et Miquelon"
		echo "	-A pour avoir les Antilles"
		echo "	-O pour avoir l'Ocean Indien"
		echo "	-Q pour avoir l'Antartique"
		echo "Toutefois cette option n'est pas obligatoire"
		echo "Si vous ne mettez pas de restrictions géographiques, vous aurez les mesures dans le monde entier"
		echo "Vous ne pouvez pas entrer plusieurs zones"
		echo "Voici les différents types de tri :"
		echo "	--tab pour avoir un tri sous forme d'une liste chainée"
		echo "	--ABR pour avoir un tri sous forme d'un arbre binaire de recherche"
		echo "	--AVL pour avoir un tri sous forme d'un arbre binaire de recherche équilibré"
		echo "Toutefois cette option n'est pas obligatoire"
		echo "Si vous ne précisez pas de tri particulier, vous aurez un tri par défaut qui est le tri par AVL"
		echo "Vous ne pouvez pas entrer plusieurs tris"
		echo "Voici les restrictions temporelles"
		echo "	-d<min><max> les données de sortie sont dans l'intervalle de dates incluses. La date est une chaîne de type YYYY-MM-DD (années-mois-jour)"
		echo -e "\033[31m Attention vous ne pouvez pas entrer plusieurs fois le même argument sinon un message d'erreur sera affiché\033[0m "
		exit 1
	fi 
	done
	return
} 

	#FONCTION DATES

Dates () {
	for arg in $@
	do
	if [ $arg != "-d" ]; then
		return
	fi
	done
	if [ $arg = "$#" ]; then
		echo "Vous n'avez pas précisé de dates limites. Consultez aide"
		exit 1
	fi
	arg=$(( arg+1 ))
	if [[ ! "{!$arg}" =~ ^20(1[0-9]|2[0-2])-(0[1-9]|1[0-2])-(0[1-9]|1[0-9]|2[0-9]|3[01])$ ]];then
		echo "la condition de restriction de temps min est fausse. Consultez aide"
		exit 1
	fi
	tempsMin={!$arg}
	arg=$(( arg+1 )) #on prend l'argument directement après celui = à -f
	if [[ ! "{!$arg}" =~ ^20(1[0-9]|2[0-2])-(0[1-9]|1[1-2])-(0[1-9]|[12][0-9]|3[01])$ ]];then
		echo "la condition de restriction de temps max est fausse. Consultez aide"
		exit 1
	fi
	tempsMax={!$arg}
	if [ "tempsMin" \> "tempsMax" ]; then
		echo "la date minimum est plus grande que la date maximum"
		exit 1
	fi
	
	#tri par rapport aux dates
}
	
	#FONCTION LIEUX

Tri_lieux1 () { #cette fonction va limiter la recherche géographique par rapport au choix de l'utilisateur
	for ((arg = 1; arg <= $#; arg++));
		do
		if [ "${!arg}" = "-F" ]; then #limite la recherche à la France métropolitaine et la Corse
			cat $file | grep -e "^07..." > lieu1.csv
			return
		elif [ "${!arg}" = "-G" ]; then #limite la recherche à la Guyane Française
			cat $file | grep -e "^814.." > lieu1.csv
			return
		elif [ "${!arg}" = "-S" ]; then #limite la recherche à Saint-Pierre et Miquelon
			cat $file | grep -e "^71805" > lieu1.csv
			return
		elif [ "${!arg}" = "-A" ]; then #limite la recherche aux Antilles
			cat $file | grep -e "^78890" -e "^78897" -e "^78894" -e "^78922" -e "^78995" > lieu1.csv
			return
		elif [ "${!arg}" = "-O" ]; then #limite la recherche à l'Océan Indien
			cat $file | grep -e "^61980" -e "^67005" > lieu1.csv
			return
		elif [ "${!arg}" = "-Q" ]; then #limite la recherche à l'Antarctique
			cat $file | grep -e "^6197.s" -e "^6199." > lieu1.csv
			return
		fi
		cat $file | grep -e "^....." > lieu1.csv
done
}

	#FONCTION DE SELECTION DES TRI

Tri_donnees () {
	for ((arg = 1; arg <= $#; arg++));
		do 
			if [ "${!arg}" = "-d" ]; then
				Dates $arg
			elif [ "${!arg}" = "-w" ]; then #option pour le vent
				cut -d ";" -f1,4,5,10 lieu1.csv > vent.csv
				sed '1d' vent.csv > vent1.csv #on supprime la 1ère ligne du fichier qui est inutile à notre calcul
				sort -t, -k1n vent1.csv > vent2.csv #on trie par rapport aux numéros des stations$
				grep -v ";$" vent2.csv > vent3.csv #cette commande permet d'enlever les lignes vides et de garder seulement les pleines
				sed 's/,/;/g' vent3.csv > vent4.csv
				awk -F";" 'BEGIN {n=0;t=0;c1=0;c2=0}{
					if(n!=$1){
						if(t!=0){
							print n";"s/t";"s2/t";"c1";"c2
						}
						n=$1;
						s=0;
						s2=0;
						t=0;
						c1=$4;
						c2=$5;
					}
					s += $2; t++;
					s2 += $3;
				}
				END {print n";"s/t";"s2/t";"c1";"c2}' vent4.csv > vent5.csv
				rm vent.csv #on supprime le fichier temporaire
				rm vent1.csv #on supprime le fichier temporaire
				rm vent2.csv #on supprime le fichier temporaire
				rm vent3.csv #on supprime le fichier temporaire
				rm vent4.csv #on supprime le fichier temporaire
			gnuplot -p w_gnu.sh
			display w_png
			
			##OPTION POUR L'HUMIDITE
			
			elif [ "${!arg}" = "-m" ]; then #option pour l'humidité
				cut -d ";" -f1,6,10 lieu1.csv > hum.csv
				sed '1d' hum.csv > hum1.csv #on supprime la 1ère ligne du fichier qui est inutile à notre calcul
				sort -t, -k2nr hum1.csv > hum2.csv #on trie par rapport aux numéros des stations$
				grep -v ";$" hum2.csv > hum3.csv #cette commande permet d'enlever les lignes vides et de garder seulement les pleines
				sed 's/,/;/g' hum3.csv > hum4.csv
				awk -F";" 'BEGIN {n="";c1=0;c2=0}{
					if(n!=$1){
						print n";"m";"c1";"c2
						n=$1;
						m=$2;
						c1=$3;
						c2=$4;
					}
					if($2>m){
						m=$2;
					}
				}
				END {print n";"m";"c1";"c2}' hum4.csv > hum5.csv
				sed '1d' hum5.csv > hum6.csv
				gnuplot -p m_gnu.sh
				display m_png
				rm hum.csv #on supprime le fichier temporaire
				rm hum1.csv #on supprime le fichier temporaire
				rm hum2.csv #on supprime le fichier temporaire
				rm hum3.csv #on supprime le fichier temporaire
				rm hum4.csv #on supprime le fichier temporaire
				rm hum5.csv #on supprime le fichier temporaire
				
			elif [[ "${!arg}" =~ ^-[tp][123] ]]; then #option pour la température
				if [[ "${!arg}" =~ ^-[tp]1 ]]; then
					if [ "${!arg}" = "-t1" ]; then
						cut -d ";" -f 1,11 lieu1.csv > temp.csv
						sed '1d' temp.csv > temp1.csv #on supprime la 1ère ligne du fichier qui est inutile à notre calcul
						sort -t, -k1n temp1.csv > temp2.csv #on trie par rapport aux numéros des stations$
						grep -v ";$" temp2.csv > temp3.csv
						awk -F";" 'BEGIN {n = 0; total = 0}{
									if( n != $1 ){
										if(total != 0){
											print n";"sum/total";"min";"max
										}
										n = $1;
										sum = 0;
										total = 0;
										min = $2;
										max = $2;
									}
									sum += $2; total ++;
									if( $2 < min ){
										min = $2;
									}
									if( max < $2 ){
										max = $2;
									}
								}
						END {print n";"  sum/total";"min";"max}' temp3.csv > temp4.csv
						gnuplot -p t1_gnu.sh #fait le graphique
						display t1_png #affiche le graphique 
						rm temp.csv #on supprime le fichier temporaire
						rm temp1.csv #on supprime le fihier temporaire
						rm temp2.csv #on supprime le fihier temporaire
						rm temp3.csv #on supprime le fihier temporaire
					fi
					if [ "${!arg}" = "-p1" ]; then
						cut -d ";" -f 1,7 lieu1.csv > press.csv
						sed '1d' press.csv > press1.csv #on supprime la 1ère ligne du fichier qui est inutile à notre calcul
						sort -t, -k1n press1.csv > press2.csv #on trie par rapport aux numéros des stations$
						grep -v ";$" press2.csv > press3.csv
						awk -F";" 'BEGIN {n = 0; total = 0}{
									if( n != $1 ){
										if(total != 0){
											print n";"sum/total";"min";"max
										}
										n = $1;
										sum = 0;
										total = 0;
										min = $2;
										max = $2;
									}
									sum += $2; total ++;
									if( $2 < min ){
										min = $2;
									}
									if( max < $2 ){
										max = $2;
									}
								}
						END {print n";"  sum/total";"min";"max}' press3.csv > press4.csv
						gnuplot -p p1_gnu.sh #fait le graphique
						display p1_png #affiche le graphique
						rm press.csv #on supprime le fichier temporaire
						rm press1.csv #on supprime le fihier temporaire
						rm press2.csv #on supprime le fihier temporaire
						rm press3.csv #on supprime le fihier temporaire
					fi
					else 
						echo "vous n'avez pas spécifié de type de modes"
					fi
			elif [ "${!arg}" = "-h" ]; then  #option altitude
				cut -d ";" -f1,10,14 lieu1.csv > alt.csv
				sed '1d' alt.csv > alt1.csv #on supprime la 1ère ligne du fichier qui est inutile à notre calcul
				sort -t, -k2nr alt1.csv > alt2.csv #on trie par rapport aux numéros des stations$
				grep -v ";$" alt2.csv > alt3.csv #cette commande permet d'enlever les lignes vides et de garder seulement les pleines
				sed 's/,/;/g' alt3.csv > alt4.csv
				awk -F";" 'BEGIN {n="";c1=0;c2=0}{
					if(n!=$1){
						print n";"m";"c1";"c2
						n=$1;
						m=$2;
						c1=$3;
						c2=$4;
					}
					if($2>m){
						m=$2;
					}
				}
				END {print n";"m";"c1";"c2}' alt4.csv > alt5.csv
				sed '1d' alt5.csv > alt6.csv
				gnuplot -p h_gnu.sh #fait le tracé du graphique
				display h_png #affiche le graphique
				rm alt.csv #on supprime le fichier temporaire
				rm alt1.csv #on supprime le fichier temporaire
				rm alt2.csv #on supprime le fichier temporaire
				rm alt3.csv #on supprime le fichier temporaire
				rm alt4.csv #on supprime le fichier temporaire
				rm alt5.csv #on supprime le fichier temporaire
		fi
	done
}

#fonction non utilisé car le c n'est pas implémeté
#le nom de code c ne corresponde pas

Tri_tri () {
	tri = 0
	for arg in $@
	do
	if [ tri !=0 ]; then
		echo "vous avez déjà précisé à un type de tri"
		exit 1
	elif [ $arg = "--avl" ]; then
		gcc -o code_AVL code_AVL.c #appelle la fonction c qui trie en utilisant un avl
		tri = tri + 1
	elif [ $arg = "--abr" ]; then	
		gcc -o code_ABR code_ABR.c
		tri = tri + 1
	elif [ $arg = "--tableau" ]; then
		gcc -o code_tableau code_tableau.c
		tri =tri + 1
	fi 
	done
		
}
if [ $# = 0 ]; then
	echo -e "\033[31mErreur ! Vous n avez pas entre d arguments :( Veuillez relancer avec des arguments cette fois-ci :)\033[0m "
	exit 1
else
	aide $@ #appelle la fonction aide
	verification $@ #appelle la fonction aide
	echo -e "\033[32mVotre lieu a bien été sélectionné \033[0m"
	Tri_donnees $@ #appelle la fonction tri de données
fi


