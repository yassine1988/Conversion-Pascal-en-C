#include <stdlib.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "table.h"

typedef struct element element;

typedef element * llist;

int ligne_no = 0;

llist table;
llist table_fonction;

llist ajouterEnFinSimple(char * valeur, char * type_valeur,char * type_valeur_valeur)
{
	if(strcmp(type_valeur,"FUNCTION")==0)
	{
		table_fonction=ajouterEnFin(table_fonction, valeur,type_valeur,type_valeur_valeur);
	} else
	{
		table=ajouterEnFin(table, valeur,type_valeur,type_valeur_valeur);
	}
}

void afficherListeSimple()
{
	afficherListe(table);
	afficherListe(table_fonction);
}

void afficherListe(llist list)
{
    element * tmp = list;
    while(tmp != NULL)
    {
        printf("Symbole %s, valeur %s %s\n",tmp->valeur,tmp->type_valeur,tmp->type_valeur_valeur);
        tmp = tmp->nxt;
    }
}

llist ajouterEnFin(llist liste, char * valeur, char * type_valeur,char * type_valeur_valeur)
{
    /* On crée un nouvel élément */
    element* nouvelElement = malloc(sizeof(element));
 
    /* On assigne la valeur au nouvel élément */
    nouvelElement->valeur = valeur;
	
	nouvelElement->type_valeur = type_valeur;
	
	nouvelElement->type_valeur_valeur = type_valeur_valeur;
 
    /* On ajoute en fin, donc aucun élément ne va suivre */
    nouvelElement->nxt = NULL;
 
    if(liste == NULL)
    {
        /* Si la liste est videé il suffit de renvoyer l'élément créé */
        return nouvelElement;
    }
    else
    {
        /* Sinon, on parcourt la liste à l'aide d'un pointeur temporaire et on
        indique que le dernier élément de la liste est relié au nouvel élément */
        element* temp=liste;
        while(temp->nxt != NULL)
        {
            temp = temp->nxt;
        }
        temp->nxt = nouvelElement;

        return liste;
    }
}


llist rechercherElement(llist liste, char * valeur, char * type_valeur)
{
    element *tmp=liste;
    /* Tant que l'on n'est pas au bout de la liste */
    while(tmp != NULL)
    {
        if(strcmp(tmp->valeur,valeur)==0 && (strcmp(tmp->type_valeur,type_valeur)==0 || strcmp("",type_valeur)==0))
        {
            /* Si l'élément a la valeur recherchée, on renvoie son adresse */
            return tmp;
        }
        tmp = tmp->nxt;
    }
    return NULL;
}