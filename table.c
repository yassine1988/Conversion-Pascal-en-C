#include <stdlib.h>
 
typedef struct element element;
struct element
{
    int val;
    struct element *nxt;
};
 
typedef element* llist;