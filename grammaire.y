%{
	#include <stdio.h>
	void yyerror(char const *s);
	int yylex();
	extern FILE *yyin;

%}

%error-verbose

%token AND;
%token ARRAY;
%token CASE;
%token CONST;
%token DIV;
%token DO;
%token ELSE ;
%token END; 
%token FOR; 
%token FUNCTION ;
%token IF ;
%token MOD ;
%token NOT ;
%token OF ;
%token OR ;
%token BEGIN; 
%token PROCEDURE ;
%token PROGRAM; 
%token THEN; 
%token TO; 
%token VAR ;
%token WHILE ;
%token WITH ;
%token IDENTIFIANT ;
%token TYPE ;

%token ASSIGNATION ;
%token CHAINE_DE_CARACTERE ;
%token DEUX_POINTS; 
%token VIRGULE; 
%token NOMBRE ;
%token POINT; 
%token POINTPOINT ;
%token EGALE; 
%token SUP_EGALE ;
%token SUP; 
%token CROCHETOUVRANT ;
%token INF_EGALE; 
%token PARENTHESEOUVRANTE ;
%token INF; 
%token MOINS ;
%token INEGALE ;
%token PLUS; 
%token CROCHETFERMANT ;
%token NOMBREREEL; 
%token PARENTHESEFERMANTE ;
%token POINTVIRGULE; 
%token SLASH; 
%token MULTIPLIE ;
%token PUISSANCE; 
%token FLECHEHAUT ;
 
%token SEPARATEUR;
%token CONDITION;
%token CLE;
%token FIN_LIGNE;
%token FIN_INSTRUCTION;
%token FIN_PROGRAM;
%token TYPEVARIABLE;
%token SIGNATURE;
%token MOT;
%token ENTRESORTIE;
%left PLUS MOINS;
%left MULTIPLIE DIV;
%left '+' '-';
%left '*' '/';

%%
programme:
	prog_entete declarations_globales prog_principal {}
	;
	
prog_entete:
	PROGRAM IDENTIFIANT POINTVIRGULE{}
	;
	
declarations_globales:
	declarations_globales declarations_globale {}
	|
	;
	
declarations_globale:
	declaration_fonction POINTVIRGULE {}
	|
	declaration_variables POINTVIRGULE {}
	;
	
declaration_fonction:
	FUNCTION IDENTIFIANT PARENTHESEOUVRANTE declaration_variables PARENTHESEFERMANTE DEUX_POINTS TYPE POINTVIRGULE block {}
	;
	
declaration_variables:
	declaration_variables declaration_variable {}
	|
	;
	
declaration_variable:
	IDENTIFIANT DEUX_POINTS TYPE {}
	;
	
block_declaration_variables:
	block_declaration_variables block_declaration_variable {}
	|
	;
	
block_declaration_variable:
	VAR declaration_variable POINTVIRGULE {}
	;

prog_principal:
	block_instructions POINT {}
	;
	
block:
	block_declaration_variables block_instructions {}
	;

block_instructions:
	BEGIN block_instruction END {}
	;

block_instruction:
	expression POINTVIRGULE {}
	|
	instruction POINTVIRGULE {}
	;

expression:
	NOMBRE {}
	|
	expression PLUS expression {}
	|
	expression MOINS expression {}
	|
	expression MULTIPLIE expression {}
	|
	expression DIV expression {}
	|
	IDENTIFIANT {}
	;

instruction:
	IDENTIFIANT PARENTHESEOUVRANTE IDENTIFIANT PARENTHESEFERMANTE {}
	;
%%
int main(int argc, char * argv[])
{
	FILE * f = NULL;
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

void yyerror(char const *s)
{
	fprintf(stderr,"Erreur %s\n",s);
}
