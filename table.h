#ifndef TABLE_H
#define TABLE_H

typedef enum TypeVariable TypeVariable;
enum TypeVariable
{
    INT, REEL, CHAR
};
typedef struct element element;
struct element
{
    char * valeur;
	TypeVariable type_variable;
    struct element *nxt;
};
typedef element* llist;
llist ajouterEnTeteSimple(char * valeur);
llist ajouterEnFin(llist liste, char* symbole);
llist ajouterEnTete(llist liste, char* symbole);
void afficherListe(llist liste);
int estVide(llist liste);
llist rechercherElement(llist liste, char* symbole);
llist ajoutSymbole(llist liste, char* symbole);
llist supprimerElementEnTete(llist liste);
void liberationMemoire(llist liste);

#endif