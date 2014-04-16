#include <stdlib.h>
#include <string.h>
#include <stdlib.h>
#include "table.h"

typedef struct element element;

typedef element* llist;

llist table;

llist ajouterEnTeteSimple(char * valeur)
{
	ajouterEnTete(table, valeur);
}

llist ajouterEnTete(llist liste, char * valeur)
{
    /* On crée un nouvel élément */
    element* nouvelElement = malloc(sizeof(element));
 
    /* On assigne la valeur au nouvel élément */
    nouvelElement->valeur = valeur;
 
    /* On assigne l'adresse de l'élément suivant au nouvel élément */
    nouvelElement->nxt = liste;
 
    /* On retourne la nouvelle liste, i.e. le pointeur sur le premier élément */
    return nouvelElement;
}

llist ajouterEnFin(llist liste, char * valeur)
{
    /* On crée un nouvel élément */
    element* nouvelElement = malloc(sizeof(element));
 
    /* On assigne la valeur au nouvel élément */
    nouvelElement->valeur = valeur;
 
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

llist supprimerElementEnTete(llist liste)
{
    if(liste != NULL)
    {
        /* Si la liste est non vide, on se prépare à renvoyer l'adresse de
        l'élément en 2ème position */
        element* aRenvoyer = liste->nxt;
        /* On libère le premier élément */
        free(liste);
        /* On retourne le nouveau début de la liste */
        return aRenvoyer;
    }
    else
    {
        return NULL;
    }
}

llist supprimerElementEnFin(llist liste)
{
    /* Si la liste est vide, on retourne NULL */
    if(liste == NULL)
        return NULL;
 
    /* Si la liste contient un seul élément */
    if(liste->nxt == NULL)
    {
        /* On le libère et on retourne NULL (la liste est maintenant vide) */
        free(liste);
        return NULL;
    }
 
    /* Si la liste contient au moins deux éléments */
    element* tmp = liste;
    element* ptmp = liste;
    /* Tant qu'on n'est pas au dernier élément */
    while(tmp->nxt != NULL)
    {
        /* ptmp stock l'adresse de tmp */
        ptmp = tmp;
        /* On déplace tmp (mais ptmp garde l'ancienne valeur de tmp */
        tmp = tmp->nxt;
    }
    /* A la sortie de la boucle, tmp pointe sur le dernier élément, et ptmp sur
    l'avant-dernier. On indique que l'avant-dernier devient la fin de la liste
    et on supprime le dernier élément */
    ptmp->nxt = NULL;
    free(tmp);
    return liste;
}

llist rechercherElement(llist liste, char * valeur)
{
    element *tmp=liste;
    /* Tant que l'on n'est pas au bout de la liste */
    while(tmp != NULL)
    {
        if(tmp->valeur == valeur)
        {
            /* Si l'élément a la valeur recherchée, on renvoie son adresse */
            return tmp;
        }
        tmp = tmp->nxt;
    }
    return NULL;
}

int nombreOccurences(llist liste, char * valeur)
{
    int i = 0;
 
    /* Si la liste est vide, on renvoie 0 */
    if(liste == NULL)
        return 0;
 
    /* Sinon, tant qu'il y a encore un élément ayant la val = valeur */
    while((liste = rechercherElement(liste, valeur)) != NULL)
    {
        /* On incrémente */
        liste = liste->nxt;
        i++;
    }
    /* Et on retourne le nombre d'occurrences */
    return i;
}

llist element_i(llist liste, int indice)
{
    int i;
    /* On se déplace de i cases, tant que c'est possible */
    for(i=0; i<indice && liste != NULL; i++)
    {
        liste = liste->nxt;
    }
 
    /* Si l'élément est NULL, c'est que la liste contient moins de i éléments */
    if(liste == NULL)
    {
        return NULL;
    }
    else
    {
        /* Sinon on renvoie l'adresse de l'élément i */
        return liste;
    }
}

llist supprimerElement(llist liste, char * valeur)
{
    /* Liste vide, il n'y a plus rien à supprimer */
    if(liste == NULL)
        return NULL;
 
    /* Si l'élément en cours de traitement doit être supprimé */
    if(liste->valeur == valeur)
    {
        /* On le supprime en prenant soin de mémoriser 
        l'adresse de l'élément suivant */
        element* tmp = liste->nxt;
        free(liste);
        /* L'élément ayant été supprimé, la liste commencera à l'élément suivant
        pointant sur une liste qui ne contient plus aucun élément ayant la valeur recherchée */
        tmp = supprimerElement(tmp, valeur);
        return tmp;
    }
    else
    {
        /* Si l'élement en cours de traitement ne doit pas être supprimé,
        alors la liste finale commencera par cet élément et suivra une liste ne contenant
        plus d'élément ayant la valeur recherchée */
        liste->nxt = supprimerElement(liste->nxt, valeur);
        return liste;
    }
}

llist effacerListe(llist liste)
{
    if(liste == NULL)
    {
        /* Si la liste est vide, il n'y a rien à effacer, on retourne 
        une liste vide i.e. NULL */
        return NULL;
    }
    else
    {
        /* Sinon, on efface le premier élément et on retourne le reste de la 
        liste effacée */
        element *tmp;
        tmp = liste->nxt;
        free(liste);
        return effacerListe(tmp);
    }
}