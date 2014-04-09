%{
	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	void yyerror(char const *s);
	int yylex();
	extern FILE *yyin;
	int affichage_grammaire = 1;
	
	char * concatener_chaine(char * chaine1,char * chaine2, char * separateur) {
		char * ntest= malloc((strlen(separateur)+strlen(chaine2)) * sizeof(char));;
		strcat(ntest,separateur);
		strcat(ntest,chaine2);
		strcat(chaine1,ntest);
	}
%}
%union 
{
	int type_integer;
	char * type_string;
};

%error-verbose

%token<type_string> AND;
%token<type_string> ARRAY;
%token<type_string> CASE;
%token<type_string> CONST;
%token<type_string> DIV;
%token<type_string> DO;
%token<type_string> ELSE ;
%token<type_string> TEND; 
%token<type_string> FOR; 
%token<type_string> FUNCTION ;
%token<type_string> IF ;
%token<type_string> MOD ;
%token<type_string> NOT ;
%token<type_string> OF ;
%token<type_string> OR ;
%token<type_string> TBEGIN; 
%token<type_string> PROCEDURE ;
%token<type_string> PROGRAM; 
%token<type_string> THEN; 
%token<type_string> TO; 
%token<type_string> DOWNTO;
%token<type_string> VAR ;
%token<type_string> WHILE ;
%token<type_string> WITH ;
%token<type_string> IDENTIFIANT ;
%token<type_string> TYPE ;
%token<type_string> TFALSE;
%token<type_string> TTRUE;

%token<type_string> ASSIGNATION ;
%token<type_string> CHAINE_DE_CARACTERE ;
%token<type_string> DEUX_POINTS; 
%token<type_string> VIRGULE; 
%token<type_string> NOMBRE ;
%token<type_string> POINT; 
%token<type_string> POINTPOINT ;
%token<type_string> EGALE; 
%token<type_string> SUP_EGALE ;
%token<type_string> SUP; 
%token<type_string> CROCHETOUVRANT ;
%token<type_string> INF_EGALE; 
%token<type_string> PARENTHESEOUVRANTE ;
%token<type_string> INF; 
%token<type_string> MOINS ;
%token<type_string> INEGALE ;
%token<type_string> PLUS; 
%token<type_string> CROCHETFERMANT ;
%token<type_string> NOMBREREEL; 
%token<type_string> PARENTHESEFERMANTE ;
%token<type_string> POINTVIRGULE; 
%token<type_string> SLASH; 
%token<type_string> MULTIPLIE ;
%token<type_string> PUISSANCE; 
%token<type_string> FLECHEHAUT ;
%token<type_string> WRITE;
%token<type_string> WRITELN;
%token<type_string> READLN;
%token<type_string> CLRSCR;
%token<type_string> GOTOXY;
%token<type_string> TEXTCOLOR;
%token<type_string> TEXTBACKGROUND;
%token<type_string> RANDOMIZE;
%token<type_string> RANDOM;
%token<type_string> TABS;
%token<type_string> TSQRT;
%token<type_string> TSQR;
%token<type_string> TINT;
%token<type_string> REPEAT;
%token<type_string> UNTIL;
 
%token<type_string> SEPARATEUR;
%token<type_string> CONDITION;
%token<type_string> CLE;
%token<type_string> FIN_LIGNE;
%token<type_string> FIN_INSTRUCTION;
%token<type_string> FIN_PROGRAM;
%token<type_string> TYPEVARIABLE;
%token<type_string> SIGNATURE;
%token<type_string> MOT;
%token<type_string> ENTRESORTIE;
%left PLUS MOINS;
%left MULTIPLIE SLASH DIV MOD AND OR;
%right PARENTHESEOUVRANTE;


%type <type_string> expression;
%type <type_string> variable;
%type <type_string> assignation;
%type <type_string> assignation_element;
%type <type_string> boolean;
%type <type_string> block_declaration_variable;
%type <type_string> block_declaration_variable_suite;
%type <type_string> declaration_variable;
%type <type_string> suite_identifiants;
%type <type_string> type_variable;
%type <type_string> appel_fonction;
%type <type_string> identifiant_fonction;
%type <type_string> variables_fonction;
%type <type_string> variable_fonction;
%type <type_string> fonction_un_param_expression;
%%
programme:
	prog_entete declarations_globales prog_principal { if(affichage_grammaire) printf("Fin d'analyse\n"); }
	;
	
prog_entete:
	PROGRAM IDENTIFIANT POINTVIRGULE{ if(affichage_grammaire) printf("Fin de déclaration entete (%s %s %s)\n",$1,$2,$3); }
	;
	
declarations_globales:
	declarations_globales declarations_globale { }
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
	declaration_variables {}
	|
	declaration_variables_fonction POINTVIRGULE declaration_variables {}
	;
	
declaration_variables:
	declaration_variable {}
	|
	;
	
declaration_variable:
	suite_identifiants DEUX_POINTS type_variable 
		{ 
			if(affichage_grammaire) printf("Fin de reconnaissance declaration_variable (%s : %s)\n",$1,$3);
			concatener_chaine($1,$3," : ");
			$$=$1;
		}
	;

type_variable:
	TYPE { if(affichage_grammaire) printf("Fin de reconnaissance TYPE (%s)\n",$1); }
	|
	ARRAY CROCHETOUVRANT expression POINTPOINT expression CROCHETFERMANT OF TYPE 
		{
			concatener_chaine($7,$8," ");
			concatener_chaine($6,$7," ");
			concatener_chaine($5,$6," ");
			concatener_chaine($4,$5," ");
			concatener_chaine($3,$4," ");
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance ARRAY (%s)\n",$1);
			$$=$1;
		}
	;

suite_identifiants:
	suite_identifiants VIRGULE IDENTIFIANT 
		{ 	
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance suite_identifiants (%s)\n",$1);
			$$=$1;
		}
	|
	IDENTIFIANT { if(affichage_grammaire) printf("Fin de reconnaissance IDENTIFIANT (%s)\n",$1);}
	;
	
block_declaration_variables:
	block_declaration_variables block_declaration_variable {}
	|
	;
	
block_declaration_variable:
	VAR block_declaration_variable_suite 
		{ if(affichage_grammaire) printf("Fin de reconnaissance block_declaration_variable (%s %s)\n",$1,$2); }
	|
	CONST block_declaration_variable_suite 
		{ if(affichage_grammaire) printf("Fin de reconnaissance block_declaration_variable (%s %s)\n",$1,$2); }
	;

block_declaration_variable_suite:
	declaration_variable POINTVIRGULE { $$=$1;}
	|
	declaration_variable POINTVIRGULE block_declaration_variable_suite 
		{	
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance block_declaration_variable_suite (%s)\n",$1);
			$$=$1;
		}
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
	instruction POINTVIRGULE { }
	;

expression:
	expression PLUS expression 
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1;
		}
	|
	expression MOINS expression 
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1;
		}
	|
	expression MULTIPLIE expression 
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1;
		}
	|
	expression SLASH expression
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1;
		}
	|
	expression DIV expression 
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1;
		}
	|
	expression MOD expression 
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1;
		}
	|
	PARENTHESEOUVRANTE expression PARENTHESEFERMANTE 
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1;
		}
	|
	variable { if(affichage_grammaire) printf("Fin de reconnaissance variable (%s)\n",$1); }
	|
	NOMBRE { if(affichage_grammaire) printf("Fin de reconnaissance nombre (%s)\n",$1); }
	|
	NOMBREREEL { if(affichage_grammaire) printf("Fin de reconnaissance nombrereel (%s)\n",$1); }
	|
	MOINS expression 
		{ 
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1;
		}
	|
	appel_fonction {}
	;

variable:
	IDENTIFIANT { if(affichage_grammaire) printf("Fin de reconnaissance IDENTIFIANT (%s)\n",$1); }
	|
	IDENTIFIANT CROCHETOUVRANT expression CROCHETFERMANT {}
	;
boolean:
	expression INF expression 
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	expression INF_EGALE expression 
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	expression SUP expression 
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	expression SUP_EGALE expression 
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	expression EGALE expression 
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	expression INEGALE expression 
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	boolean AND boolean 
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	boolean OR boolean 
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	PARENTHESEOUVRANTE boolean PARENTHESEFERMANTE
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	TTRUE 
		{ 
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	TFALSE 
		{ 
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
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
		{ 
			concatener_chaine($3,$4," ");
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance appel_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
	WRITE PARENTHESEOUVRANTE variables_fonction PARENTHESEFERMANTE
		{ 
			concatener_chaine($3,$4," ");
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance appel_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
	WRITELN PARENTHESEOUVRANTE variables_fonction PARENTHESEFERMANTE
		{ 
			concatener_chaine($3,$4," ");
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance appel_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
	READLN PARENTHESEOUVRANTE variable PARENTHESEFERMANTE
		{ 
			concatener_chaine($3,$4," ");
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance appel_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
	CLRSCR
	|
	GOTOXY PARENTHESEOUVRANTE expression VIRGULE expression PARENTHESEFERMANTE
	|
	fonction_un_param_expression PARENTHESEOUVRANTE expression PARENTHESEFERMANTE
		{ 
			concatener_chaine($2,$4," ");
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance appel_fonction (%s)\n",$1); 
			$$=$1;
		}
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
	variables_fonction VIRGULE variable_fonction 
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance variables_fonction (%s)\n",$1); 
			$$=$1;
		}
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
	variable ASSIGNATION assignation_element
		{ 
			concatener_chaine($2,$3," ");
			concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance assignation (%s)\n",$1); 
			$$=$1;
		}
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
	instruction condition_if_instruction_else {}
	;

condition_if_instruction_else:
	POINTVIRGULE {}
	|
	POINTVIRGULE ELSE block_instructions_global {}
	|
	POINTVIRGULE ELSE instruction  {}
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
	fprintf(stderr,"Erreur %s à la ligne ...\n",s);
}
