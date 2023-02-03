#include<stdio.h>
#include<stdlib.h>
#define TAILLE 50
#define TAILLE_L 50
#define TAILLE_L1 50
#define TAILLE_L2 50
#define TAILLE_L3 50


typedef struct Arbre{
int elmt;
struct Arbre *fg;
struct Arbre *fd;
int equilibre;
}Arbre;

typedef Arbre *pArbre;

typedef struct File{
struct Arbre *tete;
struct Arbre *queue;
}File;

typedef struct Liste{
pArbre val;
struct Liste *suivant;
}Liste;

typedef Liste *pListe;

void ParcoursPrefixe(pArbre a);
void ParcoursSuffixe(pArbre a);
void tri_insertion(float tab[], int taille);
pArbre creerArbre(int e);int estVide(pArbre a);
int estFeuille(pArbre a);
int element(pArbre a);
int existeFG(pArbre a);
int existeFD(pArbre a);
int ajouterFG(pArbre a, int e);
int ajouterFD(pArbre a, int e);
void ecrire_fichier(struct Arbre *arbre, FILE *fp);
int traiter( struct Arbre *fichier);
void decroissant(pArbre a);
pArbre modifierRacine(pArbre a, int e);
pArbre rotationGauche(pArbre a);
pArbre rotationDroite(pArbre a);
pArbre doubleRotationGauche(pArbre a);
pArbre doubleRotationDroite(pArbre a);
pArbre equilibrageAVL(pArbre a);
pArbre supFG(pArbre a);
pArbre supFD(pArbre a);
pArbre supFG(pArbre a);
pArbre supFD(pArbre a);
int recherche(pArbre a, int e);
pArbre insertAVL(pArbre a, int e, int *h);
pArbre supMax(pArbre a, int *pe)