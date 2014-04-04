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
%token TEND; 
%token FOR; 
%token FUNCTION ;
%token IF ;
%token MOD ;
%token NOT ;
%token OF ;
%token OR ;
%token TBEGIN; 
%token PROCEDURE ;
%token PROGRAM; 
%token THEN; 
%token TO; 
%token DOWNTO;
%token VAR ;
%token WHILE ;
%token WITH ;
%token IDENTIFIANT ;
%token TYPE ;
%token TFALSE;
%token TTRUE;

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
%token WRITE;
%token WRITELN;
%token READLN;
%token CLRSCR;
%token GOTOXY;
%token TEXTCOLOR;
%token TEXTBACKGROUND;
%token RANDOMIZE;
%token RANDOM;
%token TABS;
%token TSQRT;
%token TSQR;
%token TINT;
%token REPEAT;
%token UNTIL;
 
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
%left MULTIPLIE SLASH DIV MOD AND OR;
%right PARENTHESEOUVRANTE;

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
	|
	declaration_procedure POINTVIRGULE {}
	;
	
declaration_fonction:
	FUNCTION identifiant_fonction PARENTHESEOUVRANTE declaration_variables_fonction PARENTHESEFERMANTE DEUX_POINTS TYPE POINTVIRGULE block { }
	;

declaration_procedure:
	PROCEDURE identifiant_procedure PARENTHESEOUVRANTE declaration_variables_fonction PARENTHESEFERMANTE POINTVIRGULE block { }
	;
	
declaration_variables_fonction:
	declaration_variable {}
	|
	declaration_variables_fonction POINTVIRGULE declaration_variable {}
	;
	
declaration_variables:
	declaration_variable {}
	|
	;
	
declaration_variable:
	suite_identifiants DEUX_POINTS type_variable {}
	;

type_variable:
	TYPE
	|
	ARRAY CROCHETOUVRANT expression POINTPOINT expression CROCHETFERMANT OF TYPE
	;

suite_identifiants:
	suite_identifiants VIRGULE IDENTIFIANT {}
	|
	IDENTIFIANT
	;
	
block_declaration_variables:
	block_declaration_variables block_declaration_variable {}
	|
	;
	
block_declaration_variable:
	VAR block_declaration_variable_suite {}
	|
	CONST block_declaration_variable_suite {}
	;

block_declaration_variable_suite:
	declaration_variable POINTVIRGULE {}
	|
	declaration_variable POINTVIRGULE block_declaration_variable_suite {}
	;

prog_principal:
	block_declaration_variables block_instructions_global POINT { }
	;
	
block:
	block_declaration_variables block_instructions_global {}
	;

block_instructions_global:
	TBEGIN block_instructions TEND {}
	;

block_instructions:
	bloc_instruction_multi
	|
	instruction {}
	;

bloc_instruction_multi:
	block_instruction bloc_instruction_multi {}
	|
	;
block_instruction:
	instruction POINTVIRGULE { printf("fin instruction");}
	;

expression:
	expression PLUS expression {}
	|
	expression MOINS expression {}
	|
	expression MULTIPLIE expression {}
	|
	expression SLASH expression {}
	|
	expression DIV expression {}
	|
	expression MOD expression {}
	|
	PARENTHESEOUVRANTE expression PARENTHESEFERMANTE {}
	|
	variable {}
	|
	NOMBRE {}
	|
	NOMBREREEL {}
	|
	MOINS expression {}
	|
	appel_fonction {}
	;
	
variable:
	IDENTIFIANT {}
	|
	IDENTIFIANT CROCHETOUVRANT expression CROCHETFERMANT {}
	;
boolean:
	expression INF expression {}
	|
	expression INF_EGALE expression {}
	|
	expression SUP expression {}
	|
	expression SUP_EGALE expression {}
	|
	expression EGALE expression {}
	|
	expression INEGALE expression {}
	|
	boolean AND boolean {}
	|
	boolean OR boolean {}
	|
	PARENTHESEOUVRANTE boolean PARENTHESEFERMANTE
	|
	TTRUE {}
	|
	TFALSE {}
	;

instruction:
	assignation {}
	|
	boucle_while {}
	|
	boucle_for {} 
	|
	boucle_repeat_until {}
	|
	condition_if {}
	|
	appel_fonction {}
	|
	appel_procedure {}
	;
	
appel_procedure:
	identifiant_procedure
	;

appel_fonction:
	identifiant_fonction PARENTHESEOUVRANTE variables_fonction PARENTHESEFERMANTE
	|
	WRITE PARENTHESEOUVRANTE variables_fonction PARENTHESEFERMANTE
	|
	WRITELN PARENTHESEOUVRANTE variables_fonction PARENTHESEFERMANTE
	|
	READLN PARENTHESEOUVRANTE variable PARENTHESEFERMANTE
	|
	CLRSCR
	|
	GOTOXY PARENTHESEOUVRANTE expression VIRGULE expression PARENTHESEFERMANTE
	|
	fonction_un_param_expression PARENTHESEOUVRANTE expression PARENTHESEFERMANTE
	|
	RANDOMIZE
	;
	
fonction_un_param_expression :
	TEXTCOLOR
	|
	TEXTBACKGROUND
	|
	RANDOM
	|
	TABS
	|
	TSQR
	|
	TSQRT
	|
	TINT
	;

identifiant_fonction:
	IDENTIFIANT {}
	;
identifiant_procedure:
	IDENTIFIANT {}
	;
	
variables_fonction:
	variables_fonction VIRGULE variable_fonction {}
	|
	variable_fonction {}
	|
	{}
	;
	
variable_fonction:
	expression {}
	|
	boolean {}
	|
	CHAINE_DE_CARACTERE {}
	;

assignation:
	variable ASSIGNATION assignation_element {}
	;

assignation_element:
	expression
	|
	CHAINE_DE_CARACTERE
	|
	boolean
	;
	
boucle_while:
	WHILE boolean DO block_instructions_global {}
	|
	WHILE NOT PARENTHESEOUVRANTE boolean PARENTHESEFERMANTE DO block_instructions_global {}
	;

boucle_for:
	FOR assignation TO expression DO block_instructions_global {}
	|
	FOR assignation TO expression DO instruction {}
	|
	FOR assignation DOWNTO expression DO block_instructions_global {}
	|
	FOR assignation DOWNTO expression DO instruction {}
	;

boucle_repeat_until:
	REPEAT block_instructions_global UNTIL boolean {}
	;

condition_if:
	IF boolean THEN condition_if_instruction {}
	;
	
condition_if_instruction:
	block_instructions_global condition_if_instruction_else {}
	|
	instruction {}
	;

condition_if_instruction_else:
	POINTVIRGULE {}
	|
	ELSE block_instructions_global {};
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
