#include<stdio.h>
#include<stdlib.h>
#include<time.h>
#define TAILLE 100


void affiche_tab(float tab[], int taille_tab){//procédure qui affiche le tableau
int i;
for(i=0;i<taille_tab;i++){
printf("la %d eme case =%f\n",i+1, tab[i]);
}

}

float tab_moy(float tab[], int taille_tab){//moyenne du tableau
int i;
float moy=0;
for(i=0;i<taille_tab;i++){
moy+=tab[i];
}
moy=moy/taille_tab;
return(moy);
}

float max_tableau(float tab[], int taille_tab){//sort le chiffre le plus haut
float max=tab[0];
int i;
for(i=0;i<taille_tab;i++){
if (max<tab[i]){
max=tab[i];
}
}
return max;
}

float min_tableau(float tab[], int taille_tab){//sort le chiffre le plus bas
float min=tab[0];
int i;
for(i=0;i<taille_tab;i++){
if (min>tab[i]){
min=tab[i];
}
}
return min;
}


int main(){
int i;
float note[TAILLE]={0};
srand(time(NULL));
//remplissage du tableau
for(i=0;i<TAILLE;i++){
note[i]=(rand()%81)/4.0;
}
affiche_tab(note, TAILLE);
printf("la moyenne de ce tableau est %f\n", tab_moy(note,TAILLE));
printf("le max de ce tableau est %f\n", max_tableau(note,TAILLE));
printf("le min de ce tableau est %f\n", min_tableau(note,TAILLE));
return 0;
}