%{
	#include <stdio.h>
	void yyerror(char *s);
	int yylex();
	extern FILE *yyin;

%}
%token SEP;
%token CONDITION;
%token CLE;
%token FIN_LIGNE;
%token FIN_INSTRUCTION;
%token FIN_PROGRAM;
%token TYPEVARIABLE;
%token SIGNATURE;
%token MOT;
%token ENTRESORTIE;
%left '+' '-';
%left '*' '/';

%%

/* definition d'une fonction */
fonction: CLE SEP expressionF SEP exprBeginEnd {printf("fonction");};

/* definition d'un progroamme */
program: CLE SEP MOT FIN_INSTRUCTION FIN_LIGNE {printf("programme");}

/* definition d'un main() */
main: expressionV exprBeginEnd {printf("programme principale");};

/* definition d'une boucle IF ... THEN ... | IF ... THEN ... ELSE ... */
boucleIF: CONDITION expressionBoucle CLE expression {printf("boucle if sans else");}
	| CONDITION expressionBoucle CLE expression CLE expression {printf("boucle if avec else");};

/* definitnio d'une boucle WHILE ... DO ... */
boucleWhilE: CONDITION expressionBoucle CLE FIN_LIGNE exprBeginEnd {printf("boucle while");};

/* definition d'un BEGIN ... END; | BEGIN ... END. */
exprBeginEnd: CLE FIN_LIGNE expression CLE FIN_INSTRUCTION FIN_LIGNE {printf("begin ... end;");}
	    | CLE FIN_LIGNE expression CLE FIN_PROGRAM FIN_LIGNE {printf("begin ... end.");};

/* definition d'une expression pour une condition if ou while */
expressionBoucle: "(" expression ")" {printf("la condition d'une boucle");};

/* definition d'un expression qui suit le mot cle FUNCTION */
expressionF: MOT "(" MOT SIGNATURE TYPEVARIABLE ")" SIGNATURE TYPEVARIABLE FIN_INSTRUCTION FIN_LIGNE expressionV {printf("l'expression après fonction");};

/* definition d'un expression qui suit le mot CLE VAR */
expressionV: CLE SIGNATURE TYPEVARIABLE FIN_INSTRUCTION FIN_LIGNE {printf("definition des variables");};

/* definition d'une entre/sortie */
exprEntreSortie: ENTRESORTIE "(" exprAppFonc ")" FIN_INSTRUCTION FIN_LIGNE {printf("entre sortie avec appel a fonction");}
	       | ENTRESORTIE "(" MOT ")" FIN_INSTRUCTION FIN_LIGNE {printf("entre sortie sans appel a fonction");};

/* definition d'un appel de fonction ex: f(x) */
exprAppFonc: MOT "(" MOT ")" {printf("appel a une fonction");};

/* definition d'un expression quelconque */
expression: FIN_INSTRUCTION FIN_LIGNE {printf("inconnu");}
	  | FIN_INSTRUCTION {}
          | {};

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
