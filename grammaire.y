%{
	#include <stdio.h>
	void yyerror(char *s);
	int yylex();
	extern FILE *yyin;

%}
%union {
	int integer;
};
%token <integer> NOMBRE;
%token FIN;
%token FIN_LIGNE;
%left '+' '-';
%left '*' '/';

%type <integer> expression;

%%

expression:
	 {  }
	;
%%
int main(int argc, char * argv[])
{
	FILE * f=NULL;
	if(argc > 1)
	{
		f=fopen(argv[1],"r");
		if(f==NULL)
		{
			fprintf(stderr,"Impossible d'ouvrir %s\n",argv[1]);
			return -1;
		}
		yyin = f;
	}
	yyparse();
	printf("\nFin du programme\n");
	if(f != NULL)
	{
		fclose(f);
	}	
}

void yyerror(char *s)
{
	fprintf(stderr,"Erreur %s\n",s);
}
