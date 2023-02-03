#!/usr/local/bin/gnuplot -persist
reset #On réinitialise les paramètre de gnuplot.
set terminal png size 1080, 720 #On définie la taille de la fenêtre à 2000 pixels de long sur 1000 pixels de large.
set grid layerdefault   lt 0 linecolor 0 linewidth 0.500,  lt 0 linecolor 0 linewidth 0.500 #On créer un cadrillage sous forme de pointillées.
set output "w_png" #On indique que le fichier de sortie doit s'appeler t1_png.
set title "Carte des vents" #On définie "Température t1" comme titre du graphique.
set title  font ",17" #On met la taille de la police à 17.
set xlabel "Longitude" #On définie "ID Stations" comme nom de l'axe des abscisses.
set xlabel  font ",9" #On met la taille de la police à 10.
set ylabel "Latitude" #On définie "Température" comme nom de l'axe des ordonnées.
set ylabel  font ",9" #On met la taille de la police à 10.
Shadecolor_a = "#ff9966" #On déclare une variable contenant la couleur orange.
set datafile separator ';' #On indique que le séparateur dans le fichier qui sera lu est ";".
plot 'vent5.csv' using 2:3:($4*cos($5*pi/180)):($4*sin($5*pi/180)) with vectors head filled lw 2 lc Shadecolor_a title "Direction du vent"  #on utilise le dossier " " pour créer deux courbes : une avec la température minimale à maximale en orange, qui utilisera des courbes remplis à l'aide des colonnes 1, 2 et 4 du fichier. Et l'autre avec la température moyenne en rouge, qui utilisera des courbes à l'aide des colonnes 1 et 3 du fichier.
