#ifndef TABLE_H
#define TABLE_H

typedef enum TypeVariable TypeVariable;
enum TypeVariable
{
    INT, REEL, CHAR
};

typedef struct element element;
typedef element* llist;
llist table;

llist ajouterEnTeteSimple(char * valeur);
llist ajouterEnFinSimple(char * valeur,char * type_valeur,char * type_valeur_valeur);
void afficherListeSimple();
void afficherListe(llist list);
llist ajouterEnFin(llist liste, char* symbole,char * type_valeur,char * type_valeur_valeur);
llist ajouterEnTete(llist liste, char* symbole);
void afficherListe(llist liste);
int estVide(llist liste);
llist rechercherElement(llist liste, char* symbole, char * type_valeur);
llist ajoutSymbole(llist liste, char* symbole);
llist supprimerElementEnTete(llist liste);
void liberationMemoire(llist liste);
llist effacerListe(llist liste);

#endif