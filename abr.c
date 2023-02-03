#include<stdio.h>
#include<stdlib.h>

typedef struct Arbre{
int elmt;
struct Arbre *fg;
struct Arbre *fd;
}Arbre;

typedef Arbre* pArbre;
typedef struct Liste {
pArbre val;
struct Liste * suivant;
} Liste;

typedef Liste* Pliste;
typedef struct File{
struct Arbre* tete;
struct Arbre* queue;
}File;

typedef struct sfile{
Pliste tete;
Pliste queue;
}sfile;

pArbre supFG(pArbre a);//on défini la fonction supp fg
pArbre supFD(pArbre a);//on défini la fonction supp fd
pArbre creerArbre(int a){
pArbre noeud =malloc(sizeof(Arbre));
noeud->elmt=a;
noeud->fg=NULL;
noeud->fd=NULL;
return noeud;
}

int estVide(pArbre a){//vérifie su k'arbre est nul
if(a==NULL){
return 1;
}
else{
return 0;
}
}

int estFeuille(pArbre a){
if(a==NULL){
printf("erreur");
exit(1);
}
if(a->fg==NULL && a->fd==NULL){
return 1;
}
else{
return 0;
}
}

int element(pArbre a){
if(a==NULL){
printf("arbre vide\n");
}
else{
return a->elmt;
}
}

int existefilsGauche(pArbre a){
if(a==NULL){
printf("arbre vide\n");
exit(1);
}
else if(a->fg==NULL){
return 0;
}//retourne 0 si l'arbre n'a pas de fg
else{
return 1;
}
}

int existefilsDroit(pArbre a){
if(a==NULL){
printf("arbre vide\n");
exit(1);
}
else if(a->fd==NULL){
return 0;//retourne 0 si l'arbre n'a pas de fd
}
else{
return 1;
}
}

int ajouterFilsGauche(pArbre a,int e){
if(a==NULL){
a=creerArbre(e);
return 0;
}
else if(existefilsGauche(a)==0){
a->fg=creerArbre(e);//ajoute un fg
return 1;
}
else{
return 0;
}
}

int ajouterFilsDroit(pArbre a,int e){
if(a==NULL){
a=creerArbre(e);
return 0;
}
else if(existefilsDroit(a)==0){
a->fd=creerArbre(e);//ajoute un fd
return 1;
}
else{
return 0;
}
}

void traiter(int elmt){
printf("%d\n",elmt);//affiche l'élément
}

void recursifprefixe(pArbre a){
if(a!=NULL){
traiter(element(a));
recursifprefixe(a->fg);
recursifprefixe(a->fd);
}
}//parcourt l'arbre (centre puis gauche puis droite)

void recursifpostfixe(pArbre a){
if(a!=NULL){
recursifpostfixe(a->fg);
recursifpostfixe(a->fd);
traiter(element(a));
}
}

void parcoursLongeurInfixe(pArbre a){
if(a!=NULL){
parcoursLongeurInfixe(a->fg);
traiter(element(a));
parcoursLongeurInfixe(a->fd);
}
}

pArbre modifierRacine(pArbre a, int e){
if(a==NULL){
printf("error\n");
exit(1);
}
else{
a->elmt=e;
}
return a;
}

pArbre supFG(pArbre a){
if(a==NULL){
printf("error arbre vide\n");
exit(1);
}
else if(existefilsGauche(a)==1){
if(existefilsGauche(a->fg)==1){
supFG(a->fg);
}// on supprime le fg si il y en a un
if(existefilsDroit(a->fg)==1){
supFD(a->fg);
}// on supprime le fg si il y en a un
free(a->fg);//on libére l'espace alloué au fg
a->fg=NULL;//il n'y a plus de fg
}
}

pArbre supFD(pArbre a){
if(a==NULL){
printf("error arbre vide\n");
}
else if(existefilsDroit(a)==1){
if(existefilsGauche(a->fd)==1){
supFG(a->fd);
}// on supprime le fd si il y en a un
if(existefilsDroit(a->fd)==1){
supFD(a->fd);
}// on supprime le fd si il y en a un
free(a->fd);//libère l'espace
a->fd=NULL;
}
}

Pliste CreerElemenListe(pArbre p){
Pliste n= malloc(sizeof(Liste));
if(n==NULL){
 printf("erreur, impossible de creer un element");
 exit(1);
}
n->val=p;
n->suivant=NULL;
return n;
}

void CreerFile(sfile *f){
f->tete=NULL;
f->queue=NULL;
}

int FileVide(sfile *f){
if(f->tete==NULL){
 return 1;
}
else{
 return 0;
}
}

void enfiler(sfile *f, pArbre e){
Pliste elmt=CreerElemenListe(e);
if(f->queue==NULL){
f->tete=elmt;
}
else{
f->queue->suivant=elmt;
 }
 
f->queue= elmt;
}

pArbre defiler(sfile *f){
Pliste r;
pArbre element;
r= f->tete;
if(r==NULL){
  printf("arbre vide\n");
  exit(1);
}
f->tete= r->suivant;
if(r==f->queue){
f->queue=NULL;
}
element=r->val;
free(r);
return element;
}

void parcoursLargeur(pArbre a, sfile f)
{  pArbre x;
 if(estVide(a)==0){
CreerFile(&f);
enfiler(&f, a);
while(FileVide(&f)==0){
    x=defiler(&f);
    traiter(element(x));
if(existefilsGauche(x)==1){
enfiler(&f, x->fg);
   }
   if(existefilsDroit(x)==1){
    enfiler(&f, x->fd);
   }
}
 }
}

int nbFeuilles(pArbre a){
if (estVide(a)){
return 0;
}
if (estFeuille(a)){
return 1;
}
return nbFeuilles(a->fg) + nbFeuilles(a->fd);
}

int taille(pArbre a) {
if (estVide(a) || estFeuille(a)){
return 0;
}
return 1 + taille(a->fg) + taille(a->fd);

}

int max (int a,int b)
  {
   if(a>=b)
     return a;
     else
     return b;
 
  }

int hauteur(pArbre a) {
if (estVide(a)){
return -1;
}
return 1 + max(hauteur(a->fg), hauteur(a->fd));  
}

int recherche(pArbre a, int e){
if(a==NULL){
printf("error!\n");
return 0;
}
else if(element(a)==e){
return 1;
}
else if(e<element(a)){
recherche(a->fg,e);
}
else{
recherche(a->fd,e);
}
}

pArbre insertABR(pArbre a, int e){
if(a==NULL){
return creerArbre(e);
}
else if(e<element(a)){
a->fg=insertABR(a->fg,e);
}
else if(e>element(a)){
a->fd=insertABR(a->fd,e);
}
return a;
}

pArbre suppmax(pArbre a, int* pe){
pArbre tmp;
if(existefilsDroit(a)==1){
a->fd=suppmax(a->fd,pe);
}
else{
*pe=element(a);
tmp=a;
a=a->fg;
free(tmp);
}
return a;
}

pArbre supr(pArbre a, int e){
pArbre tmp;
int p =element(a);
if(a==NULL){
return a;
}
else if(e>a->elmt){
a->fd=supr(a->fd,e);
}
else if(e<a->elmt){
a->fg=supr(a->fg,e);
}
else if(existefilsGauche(a)==0){
tmp=a;
a=a->fd;
free(tmp);
}
else{
a->fg=suppmax(a->fg,&p);
}
return a;
}


int main(){
int *h = NULL;
pArbre a = NULL;
FILE *fichier = fopen("temp.csv", "r");
if (fichier == NULL){
printf("\033[0;31m Le fichier est vide.\033[0m\n");
return 0;
}
int elmt;
while(fscanf(fichier, "%d", &elmt) == 0){
insertABR(a, elmt);
}
printf("preFixe :\n");
recursifprefixe(a);
return 0;
}
