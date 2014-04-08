#include <stdlib.h>
 
typedef struct element element;
struct element
{
    int val;
    struct element *nxt;
};
 
typedef element* llist;

llist ajouterEnTete(llist liste, int valeur)
{
    /* On crée un nouvel élément */
    element* nouvelElement = malloc(sizeof(element));
 
    /* On assigne la valeur au nouvel élément */
    nouvelElement->val = valeur;
 
    /* On assigne l'adresse de l'élément suivant au nouvel élément */
    nouvelElement->nxt = liste;
 
    /* On retourne la nouvelle liste, i.e. le pointeur sur le premier élément */
    return nouvelElement;
}

llist ajouterEnFin(llist liste, int valeur)
{
    /* On crée un nouvel élément */
    element* nouvelElement = malloc(sizeof(element));
 
    /* On assigne la valeur au nouvel élément */
    nouvelElement->val = valeur;
 
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