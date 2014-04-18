#ifndef TABLE_H
#define TABLE_H

typedef struct element element;
typedef element* llist;

struct element
{
    char * valeur;
	char * type_valeur;
	char * type_valeur_valeur;
    struct element *nxt;
};
llist table;
llist table_fonction;

int ligne_no;

llist ajouterEnFinSimple(char * valeur,char * type_valeur,char * type_valeur_valeur);
void afficherListeSimple();
void afficherListe(llist list);
llist ajouterEnFin(llist list, char* symbole,char * type_valeur,char * type_valeur_valeur);
llist rechercherElement(llist liste, char* symbole, char * type_valeur);

#endif