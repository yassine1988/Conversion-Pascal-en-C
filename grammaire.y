%{
	#include<stdio.h>
	#include<string.h>
	#include<stdlib.h>
	#include"table.h"
	
	void yyerror(char const *s);
	int yylex();
	extern FILE *yyin;
	int affichage_grammaire = 0;
	int affichage_traduction = 1;

	char * concatener_chaine(char * chaine1,char * chaine2, char * separateur) {
		char * ntest= malloc((strlen(separateur)+strlen(chaine2)+strlen(chaine1)+50)*sizeof(char));
		strcat(ntest,chaine1);
		strcat(ntest,separateur);
		strcat(ntest,chaine2);
		return ntest;
	}
	
	char * assignation_element="";
   // }
   // afficherListe(ma_liste);
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

%token<type_string> ESPACE;
%token<type_string> LIGNE;
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
%right THEN ELSE NOT;


%type <type_string> expression;
%type <type_string> variable;
%type <type_string> assignation;
%type <type_string> assignation_element;
%type <type_string> boolean;
%type <type_string> block_declaration_variable;
%type <type_string> block_declaration_variable_suite;
%type <type_string> declaration_variable;
%type <type_string> suite_identifiants;
%type <type_string> appel_fonction;
%type <type_string> identifiant_fonction;
%type <type_string> variables_fonction;
%type <type_string> variable_fonction;
%type <type_string> fonction_un_param_expression;
%type <type_string> boucle_for;
%type <type_string> boucle_repeat_until;
%type <type_string> boucle_while;
%type <type_string> condition_if;
%type <type_string> sous_block_instruction;
%type <type_string> appel_procedure;
%type <type_string> identifiant_procedure;
%type <type_string> block_instructions_global;
%type <type_string> instruction;
%type <type_string> block_instruction;
%type <type_string> block_instructions;
%type <type_string> prog_principal;
%type <type_string> block;
%type <type_string> block_declaration_variables;
%type <type_string> declaration_variables;
%type <type_string> declaration_variables_fonction;
%type <type_string> declaration_procedure;
%type <type_string> declaration_fonction;
%type <type_string> declarations_globale;
%type <type_string> declarations_globales;
%type <type_string> prog_entete;
%type <type_string> programme;
%type <type_string> tableau_crochets;
%type <type_string> suite_crochet;
%type <type_string> declaration_variable_spe_fonction;
%type <type_string> declaration_fonction1;
%type <type_string> declaration_fonction2;

%%
programme:
	prog_entete declarations_globales prog_principal 
		{ 
			if(affichage_traduction)
			{
				$1=concatener_chaine("#include<stdio.h>\n\n",$1,"");
				$1=concatener_chaine($1,$2,$3);
			}
			else
			{
				$2=concatener_chaine($2,$2," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance programme (%s)\n",$1); 
			$$=$1;
			printf("\n\n%s",$$);
		}
	;
	
prog_entete:
	PROGRAM IDENTIFIANT POINTVIRGULE 
		{ 
			if(affichage_traduction)
			{
				$1="int main() ";
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
				

			if(affichage_grammaire) printf("Fin de reconnaissance prog_entete (%s)\n",$1); 
			$$=$1;
		}
	;
	
declarations_globales:
	declarations_globale declarations_globales
		{ 
			if(affichage_traduction)
				$1=concatener_chaine($1,$2," ");
			else
				$1=concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance declarations_globales (%s)\n",$1); 
			$$=$1;
		}
	|
		{	
			if(affichage_grammaire) printf("Fin de reconnaissance declarations_globales (VIDE)\n"); 
			$$=" ";
		}
	;
	
declarations_globale:
	declaration_fonction POINTVIRGULE 
		{ 
			if(affichage_traduction)
				//$1=concatener_chaine($1,$2," ");
				$1=$1;
			else
				$1=concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance declarations_globale (%s)\n",$1); 
			$$=$1;
		}
	|
	declaration_variables POINTVIRGULE 
		{ 
			if(affichage_traduction)
				//$1=concatener_chaine($1,$2," ");
				$$=$1;
			else
				$1=concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance declarations_globale (%s)\n",$1); 
			$$=$1;
		}
	|
	declaration_procedure POINTVIRGULE 
		{ 
			if(affichage_traduction)
				//$1=concatener_chaine($1,$2," ");
				$$=$1;
			else
				$1=concatener_chaine($1,$2," ");
			if(affichage_grammaire) printf("Fin de reconnaissance declarations_globale (%s)\n",$1); 
			$$=$1;
		}
	;
	
declaration_fonction2:
	FUNCTION identifiant_fonction PARENTHESEOUVRANTE declaration_variables_fonction PARENTHESEFERMANTE DEUX_POINTS TYPE POINTVIRGULE 
		{ 
			printf("ici");
			if(affichage_traduction)
			{
				element * test = rechercherElement(table_fonction,$2,"");
				if(test==NULL)
				{
					if(strcmp($7,"int")==0 || strcmp($7,"float")==0)
					{
						ajouterEnFinSimple($2,"FUNCTION","NOMBRE");
						ajouterEnFinSimple($2,"NOMBRE","");
					}else
					{
						ajouterEnFinSimple($2,"FUNCTION","CHAINE_DE_CARACTERE");
						ajouterEnFinSimple($2,"CHAINE_DE_CARACTERE","");
					}
				}else
				{
					printf("\n\n\nERREUR la fonction %s a déja été déclaré, type ",$2,test->type_valeur_valeur);
				}
				$6=concatener_chaine("{\n ",$7,"");
				$6=concatener_chaine($6,$2," ");
				$6=concatener_chaine($6,";\n","");
				$5=concatener_chaine($5,$6," ");
				//$5=concatener_chaine($5,$9," ");
				
				$4=concatener_chaine($4,$5," ");
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3,"");
				$1=concatener_chaine($7,$2," ");
				//$1=concatener_chaine($1,$2," ");
				$1=concatener_chaine("\n",$1,"");
			}
			else
			{
				//$8=concatener_chaine($8,$9," ");
				$7=concatener_chaine($7,$8," ");
				$6=concatener_chaine($6,$7," ");
				$5=concatener_chaine($5,$6," ");
				$4=concatener_chaine($4,$5," ");
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			
			if(affichage_grammaire) printf("Fin de reconnaissance declaration_fonction (%s)\n",$1); 
			$$=$1;
		}
	;
	
declaration_fonction1:
	block
		{
			$$=$1;
		}
	;
declaration_fonction:
	declaration_fonction2 declaration_fonction1
	{
		element * tmp = table_fonction;
		element * tmp2;
		while(tmp != NULL)
		{
			tmp2 = tmp;
			tmp = tmp->nxt;
		}
		$2=concatener_chaine($2,"\nreturn ","");
		$2=concatener_chaine($2,tmp2->valeur,"");
		$2=concatener_chaine($2,";\n}","");
		$1=concatener_chaine($1,$2," ");
		$$=$1;
	}
	;

declaration_procedure:
	PROCEDURE identifiant_procedure PARENTHESEOUVRANTE declaration_variables_fonction PARENTHESEFERMANTE POINTVIRGULE block
		{ 
			if(affichage_traduction)
			{
				ajouterEnFinSimple($2,"FUNCTION","VOID");
				$6=concatener_chaine("{\n",$7,"");
				$6=concatener_chaine($6,"\n}","");
				$5=concatener_chaine($5,$6," ");
				$4=concatener_chaine($4,$5," ");
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3,"");
				$1=concatener_chaine("\nvoid ",$2,"");
			}
			else
			{
				$6=concatener_chaine($6,$7," ");
				$5=concatener_chaine($5,$6," ");
				$4=concatener_chaine($4,$5," ");
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			
			if(affichage_grammaire) printf("Fin de reconnaissance declaration_procedure (%s)\n",$1); 
			$$=$1;
		}
	;
	
declaration_variables_fonction:
	declaration_variables
		{ 
			if(affichage_grammaire) printf("Fin de reconnaissance declaration_variables_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
	declaration_variables_fonction POINTVIRGULE declaration_variables 
		{ 
			if(affichage_traduction)
			{
				$2=concatener_chaine(",",$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			
			if(affichage_grammaire) printf("Fin de reconnaissance declaration_variables_fonction (%s)\n",$1); 
			$$=$1;
		}
	;
	
declaration_variables:
	declaration_variable_spe_fonction 
		{ 
			if(affichage_grammaire) printf("Fin de reconnaissance declaration_variables (%s)\n",$1); 
			$$=$1;
		}
	|
		{
			if(affichage_grammaire) printf("Fin de reconnaissance declaration_variables (VIDE)\n"); 
			$$=" ";
		}
	;
declaration_variable_spe_fonction:
	suite_identifiants DEUX_POINTS TYPE 
		{ 
			if(affichage_traduction)
			{
				char* chaine = strdup($1);
				char* variable;
				$1="";
				while ((variable = strsep(&chaine, ","))!=NULL)
				{
					element * test = rechercherElement(table,variable,"");
					if(test==NULL)
					{
						if(strcmp($3,"int")==0 || strcmp($3,"float")==0)
						{
							ajouterEnFinSimple(variable,"NOMBRE","");
						}else
						{
							ajouterEnFinSimple(variable,"CHAINE_DE_CARACTERE","");
						}
					}else
					{
						printf("\n\n\nERREUR la variable %s a déja été déclaré, type %s",variable,test->type_valeur);
					}
					if(strcmp("",$1))
					{
						$1=concatener_chaine($1,",","");
					}
					$1=concatener_chaine($1,$3," ");
					$1=concatener_chaine($1,variable," ");
					
				}
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance declaration_variable (%s)\n",$1);
			$$=$1;
		}
	|
	suite_identifiants DEUX_POINTS ARRAY tableau_crochets OF TYPE  
		{ 
			if(affichage_traduction)
			{
				char* chaine = strdup($1);
				char* variable;
				$1="";
				while ((variable = strsep(&chaine, ","))!=NULL)
				{
					element * test = rechercherElement(table,variable,"");
					if(test==NULL)
					{
						if(strcmp($6,"int")==0 || strcmp($6,"float")==0)
						{
							ajouterEnFinSimple(variable,"ARRAY","NOMBRE");
						}else
						{
							ajouterEnFinSimple(variable,"ARRAY","CHAINE_DE_CARACTERE");
						}
					}else
					{
						printf("\n\n\nERREUR la variable %s a déja été déclaré, type %s",variable,test->type_valeur);
					}
					
					if(strcmp("",$1)==0)
					{
						$1=concatener_chaine($1,",","");
					}
					$1=concatener_chaine($1,$6," ");
					$1=concatener_chaine($1,variable," ");
					$1=concatener_chaine($1,$4,"");
				}
			}
			else
			{
				$5=concatener_chaine($5,$6," ");
				$4=concatener_chaine($4,$5," ");
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance declaration_variable (%s)\n",$1);
			$$=$1;
		}
	;
declaration_variable:
	suite_identifiants DEUX_POINTS TYPE 
		{ 
			if(affichage_traduction)
			{
				char* chaine = strdup($1);
				char* variable;
				$1="";
				while ((variable = strsep(&chaine, ","))!=NULL)
				{
					element * test = rechercherElement(table,variable,"");
					if(test==NULL)
					{
						if(strcmp($3,"int")==0 || strcmp($3,"float")==0)
						{
							ajouterEnFinSimple(variable,"NOMBRE","");
						}else
						{
							ajouterEnFinSimple(variable,"CHAINE_DE_CARACTERE","");
						}
					}else
					{
						printf("\n\n\nERREUR la variable %s a déja été déclaré, type %s",variable,test->type_valeur);
					}
					
					$1=concatener_chaine($1,$3," ");
					$1=concatener_chaine($1,variable," ");
					$1=concatener_chaine($1,";\n","");
				}
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance declaration_variable (%s)\n",$1);
			$$=$1;
		}
	|
	suite_identifiants DEUX_POINTS ARRAY tableau_crochets OF TYPE  
		{ 
			if(affichage_traduction)
			{
				char* chaine = strdup($1);
				char* variable;
				$1="";
				while ((variable = strsep(&chaine, ","))!=NULL)
				{
					element * test = rechercherElement(table,variable,"");
					if(test==NULL)
					{
						if(strcmp($6,"int")==0 || strcmp($6,"float")==0)
						{
							ajouterEnFinSimple(variable,"ARRAY","NOMBRE");
						}else
						{
							ajouterEnFinSimple(variable,"ARRAY","CHAINE_DE_CARACTERE");
						}
					}else
					{
						printf("\n\n\nERREUR la variable %s a déja été déclaré, type ",variable,test->type_valeur);
					}
					$1=concatener_chaine($1,$6," ");
					$1=concatener_chaine($1,variable," ");
					$1=concatener_chaine($1,$4,"");
					$1=concatener_chaine($1,";\n","");
				}
			}
			else
			{
				$5=concatener_chaine($5,$6," ");
				$4=concatener_chaine($4,$5," ");
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance declaration_variable (%s)\n",$1);
			$$=$1;
		}
	;

tableau_crochets:
	CROCHETOUVRANT expression POINTPOINT expression CROCHETFERMANT suite_crochet
		{
			if(affichage_traduction)
			{
				$1=concatener_chaine($1,$4,"(");
				$1=concatener_chaine($1,$2,")-(");
				$1=concatener_chaine($1,$5,")+1");
				$1=concatener_chaine($1,$6,"");
			}
			else
			{
				$5=concatener_chaine($5,$6," ");
				$4=concatener_chaine($4,$5," ");
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance tableau_crochets (%s)\n",$1);
			$$=$1;
		}
	;

suite_crochet:
	tableau_crochets
		{
			if(affichage_grammaire) printf("Fin de reconnaissance suite_crochet (%s)\n",$1);
			$$=$1;
		}
	|
		{
			if(affichage_grammaire) printf("Fin de reconnaissance suite_crochet (VIDE)\n");
			$$="";
		}
	;

suite_identifiants:
	suite_identifiants VIRGULE IDENTIFIANT 
		{ 	
			if(affichage_traduction)
			{
				$2=concatener_chaine($2,$3,"");
				$1=concatener_chaine($1,$2,"");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance suite_identifiants (%s)\n",$1);
			$$=$1;
		}
	|
	IDENTIFIANT 
		{ 
			if(affichage_grammaire) printf("Fin de reconnaissance suite_identifiants (%s)\n",$1);
			$$=$1;
		}
	;
	
block_declaration_variables:
	block_declaration_variable block_declaration_variables 
		{ 
			if(affichage_traduction)
			{
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$1=concatener_chaine($1,$2," ");
			}
			
			if(affichage_grammaire) printf("Fin de reconnaissance block_declaration_variables (%s)\n",$1); 
			$$=$1;
		}
	|
		{ 
			if(affichage_grammaire) printf("Fin de reconnaissance block_declaration_variables (VIDE)\n"); 
			$$=" ";
		}
	;
	
block_declaration_variable:
	VAR block_declaration_variable_suite 
		{ 
			if(affichage_traduction)
			{
				//$1=concatener_chaine($1,$2," ");
				$1=$2;
			}
			else
			{
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance block_declaration_variable (%s)\n",$1); 
			$$=$1;
		}
	|
	CONST block_declaration_variable_suite 
		{ 
			if(affichage_traduction)
			{
				$1=concatener_chaine("#define ",$2," ");
			}
			else
			{
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance block_declaration_variable (%s)\n",$1); 
			$$=$1;
		}
	;

block_declaration_variable_suite:
	declaration_variable POINTVIRGULE 
		{ 
			if(affichage_traduction)
			{
				//$1=concatener_chaine($1,$2," ");
				$$=$1;
			}
			else
			{
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance block_declaration_variable_suite (%s)\n",$1); 
			$$=$1;
		}
	|
	declaration_variable POINTVIRGULE block_declaration_variable_suite 
		{	
			if(affichage_traduction)
			{
				//$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$3," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			
			if(affichage_grammaire) printf("Fin de reconnaissance block_declaration_variable_suite (%s)\n",$1);
			$$=$1;
		}
	;

prog_principal:
	block_declaration_variables block_instructions_global POINT 
		{ 
			if(affichage_traduction)
			{
				//$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine("\n{\n ",$1," ");
				$1=concatener_chaine($1,$2," ");
				$1=concatener_chaine($1,"\nreturn 1;\n}\n"," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}

			if(affichage_grammaire) printf("Fin de reconnaissance prog_principal (%s)\n",$1); 
			$$=$1;
		}
	;
	
block:
	block_declaration_variables block_instructions_global 
		{ 
			if(affichage_traduction)
			{
				//$1=concatener_chaine("\n{\n ",$1," ");
				$1=concatener_chaine($1,$2," ");
				//$1=concatener_chaine($1,"\n}\n "," ");
			}
			else
			{
				$1=concatener_chaine($1,$2," ");
			}
			
			if(affichage_grammaire) printf("Fin de reconnaissance block (%s)\n",$1); 
			$$=$1;
		}
	;

block_instructions_global:
	TBEGIN block_instructions TEND 
		{ 
			if(affichage_traduction)
			{
				$2=concatener_chaine($2,"","");
				$1=concatener_chaine("",$2,"");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			
			if(affichage_grammaire) printf("Fin de reconnaissance block_instructions_global (%s)\n",$1); 
			$$=$1;
		}
	;

block_instructions:
	block_instructions block_instruction
		{ 
			if(affichage_traduction)
			{
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$1=concatener_chaine($1,$2," ");
			}
			
			if(affichage_grammaire) printf("Fin de reconnaissance block_instructions (%s)\n",$1); 
			$$=$1;
		}
	|
		{ 
			if(affichage_grammaire) printf("Fin de reconnaissance block_instructions (VIDE)\n"); 
			$$=" ";
		}
	;
block_instruction:
	instruction POINTVIRGULE
		{ 
			if(affichage_traduction)
			{
				//$1=concatener_chaine($1,$2," ");
				$$=$1;
			}
			else
			{
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance block_instruction (%s)\n",$1); 
			$$=$1;
		}
	;

expression:
	expression PLUS expression 
		{ 
			if(affichage_traduction)
			{
				assignation_element="NOMBRE";
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1;
		}
	|
	expression MOINS expression 
		{ 
			if(affichage_traduction)
			{
				assignation_element="NOMBRE";
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1;
		}
	|
	expression MULTIPLIE expression 
		{ 
			if(affichage_traduction)
			{
				assignation_element="NOMBRE";
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1;
		}
	|
	expression SLASH expression
		{ 
			if(affichage_traduction)
			{
				assignation_element="NOMBRE";
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1;
		}
	|
	expression DIV expression 
		{ 
			if(affichage_traduction)
			{
				assignation_element="NOMBRE";
				$1=concatener_chaine($1,"/"," ");
				$1=concatener_chaine($1,$3," ");
			}
			else
			{
				assignation_element="NOMBRE";
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1;
		}
	|
	expression MOD expression 
		{ 
			if(affichage_traduction)
			{
				assignation_element="NOMBRE";
				$1=concatener_chaine($1,"%"," ");
				$1=concatener_chaine($1,$3," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1;
		}
	|
	PARENTHESEOUVRANTE expression PARENTHESEFERMANTE 
		{ 
			if(affichage_traduction)
			{
				assignation_element="NOMBRE";
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1;
		}
	|
	variable 
		{ 
			if(affichage_grammaire) printf("Fin de reconnaissance variable (%s)\n",$1); 
			$$=$1;
		}
	|
	NOMBRE 
		{ 
			assignation_element="NOMBRE";
			if(affichage_grammaire) printf("Fin de reconnaissance nombre (%s)\n",$1); 
			$$=$1;
		}
	|
	NOMBREREEL 
		{ 
			assignation_element="NOMBRE";
			if(affichage_grammaire) printf("Fin de reconnaissance nombrereel (%s)\n",$1); 
			$$=$1;
		}
	|
	MOINS expression 
		{ 
			if(affichage_traduction)
			{
				assignation_element="NOMBRE";
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1;
		}
	|
	appel_fonction  
		{ 
			if(affichage_grammaire) printf("Fin de reconnaissance expression (%s)\n",$1); 
			$$=$1; 
		}
	;

variable:
	IDENTIFIANT 
		{ 
			element * test = rechercherElement(table,$1,"");
			element * test2 = rechercherElement(table_fonction,$1,"");
			if(test==NULL)
			{
				if(test2==NULL)
				{
					printf("\nERREUR l'identifiant %s n'existe pas!",$1);
				}else
				{
					assignation_element=test2->type_valeur;
				}
			}else
			{
				assignation_element=test->type_valeur;
			}
			if(affichage_grammaire) printf("Fin de reconnaissance IDENTIFIANT (%s)\n",$1); 
			$$=$1;
		}
	|
	IDENTIFIANT CROCHETOUVRANT expression CROCHETFERMANT 
		{ 
			if(affichage_traduction)
			{
				element * test = rechercherElement(table,$1,"");
				if(test==NULL)
				{
					printf("\nERREUR la variable %s n'existe pas!",$1);
				}else
				{
					assignation_element=test->type_valeur;
				}
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2,"");
			}
			else
			{
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}

			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	;
boolean:
	expression INF expression 
		{ 
			if(affichage_traduction)
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	expression INF_EGALE expression 
		{ 
			if(affichage_traduction)
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	expression SUP expression 
		{ 
			if(affichage_traduction)
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	expression SUP_EGALE expression 
		{ 
			if(affichage_traduction)
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	expression EGALE expression 
		{ 
			if(affichage_traduction)
			{
				$1=concatener_chaine($1,"=="," ");
				$1=concatener_chaine($1,$3," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	expression INEGALE expression 
		{ 
			if(affichage_traduction)
			{
				$1=concatener_chaine($1,"!="," ");
				$1=concatener_chaine($1,$3," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	boolean AND boolean 
		{ 
			if(affichage_traduction)
			{
				$1=concatener_chaine($1,"&&"," ");
				$1=concatener_chaine($1,$3," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	boolean OR boolean 
		{ 
			if(affichage_traduction)
			{
				$1=concatener_chaine($1,"||"," ");
				$1=concatener_chaine($1,$3," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	PARENTHESEOUVRANTE boolean PARENTHESEFERMANTE
		{ 
			if(affichage_traduction)
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	expression EGALE CHAINE_DE_CARACTERE
		{
			if(affichage_traduction)
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	NOT boolean
		{
			if(affichage_traduction)
			{
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$=$1;
		}
	|
	TTRUE 
		{ 
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$="1";
		}
	|
	TFALSE 
		{ 
			if(affichage_grammaire) printf("Fin de reconnaissance boolean (%s)\n",$1); 
			$$="0";
		}
	;

instruction:
	assignation
		{
			if(affichage_traduction)
			{
				$1=concatener_chaine($1,";\n","");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance instruction (%s)\n",$1); 
			$$=$1;
		}
	|
	boucle_while 
		{
			if(affichage_grammaire) printf("Fin de reconnaissance instruction (%s)\n",$1); 
			$$=$1;
		}
	|
	boucle_for
		{
			if(affichage_grammaire) printf("Fin de reconnaissance instruction (%s)\n",$1);
			$$=$1;
		}
	|
	boucle_repeat_until 
		{
			if(affichage_traduction)
			{
				$1=concatener_chaine($1,";\n","");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance instruction (%s)\n",$1); 
			$$=$1;
		}
	|
	condition_if 
		{
			if(affichage_grammaire) printf("Fin de reconnaissance instruction (%s)\n",$1);
			$$=$1;
		}
	|
	appel_fonction
		{
			if(affichage_traduction)
			{
				$1=concatener_chaine($1,";\n","");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance instruction (%s)\n",$1); 
			$$=$1;
		}
	|
	appel_procedure
		{
			if(affichage_traduction)
			{
				$1=concatener_chaine($1,";\n","");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance instruction (%s)\n",$1); 
			$$=$1;
		}
	;
	
appel_procedure:
	identifiant_procedure
	{
		if(affichage_traduction)
			{
				element * test = rechercherElement(table_fonction,$1,"");
				if(test==NULL)
				{
					printf("\nERREUR la procédure %s n'existe pas!",$1);
				}else
				{
					if(!strcmp(test->type_valeur_valeur,"VOID")==0)
					{
						printf("\nERREUR %s n'est pas une procédure!",$1);
					}
				}
				$1=concatener_chaine($1,"(","");
				$1=concatener_chaine($1,")"," ");
			}
		if(affichage_grammaire) printf("Fin de reconnaissance appel_procedure (%s)\n",$1);
		$$=$1;
	}
	;

appel_fonction:
	identifiant_fonction PARENTHESEOUVRANTE variables_fonction PARENTHESEFERMANTE
		{ 
			if(affichage_traduction)
			{
				element * test = rechercherElement(table_fonction,$1,"");
				if(test==NULL)
				{
					printf("\nERREUR la function %s n'existe pas!",$1);
				}else
				{
					if(strcmp(test->type_valeur_valeur,"int")==0 || strcmp(test->type_valeur_valeur,"float")==0)
					{
						assignation_element="NOMBRE";
					}else
					{
						assignation_element="CHAINE_DE_CARACTERE";
					}
				}
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2,"");
			}
			else
			{
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance appel_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
	WRITE PARENTHESEOUVRANTE variables_fonction PARENTHESEFERMANTE
		{ 
			if(affichage_traduction)
			{
				assignation_element="VOID";
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine("printf",$2,"");
			}
			else
			{
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance appel_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
	WRITELN PARENTHESEOUVRANTE variables_fonction PARENTHESEFERMANTE
		{ 
			if(affichage_traduction)
			{
				assignation_element="VOID";
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine("printf",$2,"");
			}
			else
			{
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance appel_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
	READLN PARENTHESEOUVRANTE variable PARENTHESEFERMANTE
		{ 
			if(affichage_traduction)
			{
				assignation_element="VOID";
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine("scanf",$2,"");
			}
			else
			{
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance appel_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
	CLRSCR
		{
			assignation_element="VOID";
			if(affichage_traduction)
			{
				$1="system('clear')";
			}
			if(affichage_grammaire) printf("Fin de reconnaissance appel_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
	GOTOXY PARENTHESEOUVRANTE expression VIRGULE expression PARENTHESEFERMANTE
		{ 
			if(affichage_traduction)
			{
				assignation_element="VOID";
				$5=concatener_chaine($5,$6," ");
				$4=concatener_chaine($4,$5," ");
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2,"");
			}
			else
			{
				$5=concatener_chaine($5,$6," ");
				$4=concatener_chaine($4,$5," ");
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance appel_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
	fonction_un_param_expression PARENTHESEOUVRANTE expression PARENTHESEFERMANTE
		{ 
			if(affichage_traduction)
			{
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2,"");
			}
			else
			{
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			
			if(affichage_grammaire) printf("Fin de reconnaissance appel_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
	TSQR PARENTHESEOUVRANTE expression PARENTHESEFERMANTE
		{ 
			if(affichage_traduction)
			{
				assignation_element="NOMBRE";
				$3=concatener_chaine($3,",2"," ");
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine("pow",$2,"");
			}
			else
			{
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			
			if(affichage_grammaire) printf("Fin de reconnaissance appel_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
	RANDOMIZE
		{
			if(affichage_traduction)
			{
				$1="srand(time(NULL))";
			}
			if(affichage_grammaire) printf("Fin de reconnaissance appel_fonction (%s)\n",$1); 
			$$=$1;
		}
	;
	
fonction_un_param_expression :
	TEXTCOLOR
		{
			assignation_element="VOID";
			if(affichage_grammaire) printf("Fin de reconnaissance fonction_un_param_expression (%s)\n",$1); 
			$$=$1;
		}
	|
	TEXTBACKGROUND
		{
			assignation_element="VOID";
			if(affichage_grammaire) printf("Fin de reconnaissance fonction_un_param_expression (%s)\n",$1); 
			$$=$1;
		}
	|
	RANDOM
		{
			assignation_element="NOMBRE";
			if(affichage_traduction)
			{
				$1="rand";
			}
			if(affichage_grammaire) printf("Fin de reconnaissance fonction_un_param_expression (%s)\n",$1); 
			$$=$1;
		}
	|
	TABS
		{
			assignation_element="NOMBRE";
			if(affichage_grammaire) printf("Fin de reconnaissance fonction_un_param_expression (%s)\n",$1); 
			$$=$1;
		}
	|
	TSQRT
		{
			assignation_element="NOMBRE";
			if(affichage_grammaire) printf("Fin de reconnaissance fonction_un_param_expression (%s)\n",$1); 
			$$=$1;
		}
	|
	TINT
		{
			assignation_element="NOMBRE";
			if(affichage_traduction)
			{
				$1="(int)floor";
			}
			if(affichage_grammaire) printf("Fin de reconnaissance fonction_un_param_expression (%s)\n",$1); 
			$$=$1;
		}
	;

identifiant_fonction:
	IDENTIFIANT
		{
			if(affichage_grammaire) printf("Fin de reconnaissance identifiant_fonction (%s)\n",$1); 
			$$=$1;
		}
	;
identifiant_procedure:
	IDENTIFIANT 
		{
			if(affichage_grammaire) printf("Fin de reconnaissance identifiant_procedure (%s)\n",$1); 
			$$=$1;
		}
	;
	
variables_fonction:
	variable_fonction VIRGULE variables_fonction 
		{ 
			if(affichage_traduction)
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance variables_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
	variable_fonction 
		{
			if(affichage_grammaire) printf("Fin de reconnaissance variables_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
		{ 
			if(affichage_grammaire) printf("Fin de reconnaissance variables_fonction (VIDE)\n"); 
			$$="";
		}
	;
	
variable_fonction:
	expression 
		{
			if(affichage_grammaire) printf("Fin de reconnaissance variable_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
	boolean 
		{
			assignation_element="BOOLEAN";
			if(affichage_grammaire) printf("Fin de reconnaissance variable_fonction (%s)\n",$1); 
			$$=$1;
		}
	|
	CHAINE_DE_CARACTERE
		{
			assignation_element="BOOLEAN";
			if(affichage_grammaire) printf("Fin de reconnaissance variable_fonction (%s)\n",$1); 
			$$=$1;
		}
	;

assignation:
	variable ASSIGNATION assignation_element 
		{ 
			if(affichage_traduction)
			{
				char* chaine = strdup($1);
				char* variable;
				variable = strsep(&chaine, "[");
				element * test = rechercherElement(table,variable,"");
				if(test==NULL)
				{
					printf("\nERREUR la variable %s n'est pas déclaré",variable);
				}else
				{
					if(!(strcmp(assignation_element,test->type_valeur)==0 || strcmp(assignation_element,test->type_valeur_valeur)==0))
					{
						printf("\nERREUR assignation, la variable %s est de type %s %s",variable,test->type_valeur,test->type_valeur_valeur);
						afficherListeSimple();
					}
				}
				assignation_element="";
				$2=concatener_chaine("=",$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance assignation (%s)\n",$1); 
			$$=$1;
		}
	;

assignation_element:
	expression
		{
			if(affichage_grammaire) printf("Fin de reconnaissance assignation_element (%s)\n",$1); 
			$$=$1;
		}
	|
	CHAINE_DE_CARACTERE
		{
			assignation_element="CHAINE_DE_CARACTERE";
			if(affichage_grammaire) printf("Fin de reconnaissance assignation_element (%s)\n",$1); 
			$$=$1;
		}
	|
	boolean
		{
			assignation_element="BOOLEAN";
			if(affichage_grammaire) printf("Fin de reconnaissance assignation_element (%s)\n",$1); 
			$$=$1;
		}
	;
	
boucle_while:
	WHILE boolean DO block_instructions_global 
		{ 
			if(affichage_traduction)
			{
				$4=concatener_chaine($4,"\n}\n "," ");
				$4=concatener_chaine(" \n{\n",$4," ");
				$2=concatener_chaine($2,")"," ");
				$2=concatener_chaine("(",$2,"");
				$1=concatener_chaine($1,$2," ");
				$1=concatener_chaine($1,$4," ");
			}
			else
			{
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			
			if(affichage_grammaire) printf("Fin de reconnaissance boucle_while (%s)\n",$1); 
			$$=$1;
		}
	;

boucle_for:
	FOR assignation TO expression DO sous_block_instruction
		{ 
			if(affichage_traduction)
			{
				char* chaine = strdup($2);
				char* variable = strsep(&chaine, "=");
				$2=concatener_chaine("(",$2,"");
				$2=concatener_chaine($2,";"," ");
				$2=concatener_chaine($2,$4," ");
				$2=concatener_chaine($2,"<="," ");
				$2=concatener_chaine($2,variable," ");
				$2=concatener_chaine($2,";"," ");
				$2=concatener_chaine($2,variable," ");
				$2=concatener_chaine($2,"++","");
				$2=concatener_chaine($2,")","");
				$2=concatener_chaine($2,$6," ");

				$1=concatener_chaine($1,$2,"");
			}
			else
			{
				$5=concatener_chaine($5,$6," ");
				$4=concatener_chaine($4,$5," ");
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance boucle_for (%s)\n",$1); 
			$$=$1;
		}
	|
	FOR assignation DOWNTO expression DO sous_block_instruction
		{ 
			if(affichage_traduction)
			{
				char * chaine = strdup($2);
				char * variable = strsep(&chaine, "=");
				$2=concatener_chaine("(",$2,"");
				$2=concatener_chaine($2,";"," ");
				$2=concatener_chaine($2,$4," ");
				$2=concatener_chaine($2,">="," ");
				$2=concatener_chaine($2,variable," ");
				$2=concatener_chaine($2,";"," ");
				$2=concatener_chaine($2,variable," ");
				$2=concatener_chaine($2,"--","");
				$2=concatener_chaine($2,")","");
				$2=concatener_chaine($2,$6," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$5=concatener_chaine($5,$6," ");
				$4=concatener_chaine($4,$5," ");
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance boucle_for (%s)\n",$1); 
			$$=$1;
		}
	;

boucle_repeat_until:
	REPEAT block_instructions UNTIL boolean 
		{ 
			if(affichage_traduction)
			{
				
				$3=concatener_chaine("while (",$4," ");
				$3=concatener_chaine($3,")"," ");
				$2=concatener_chaine($2," \n}\n "," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine("do \n{\n ",$2," ");
			}
			else
			{
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance boucle_repeat_until (%s)\n",$1); 
			$$=$1;
		}
	;

condition_if:
	IF boolean THEN sous_block_instruction 
		{ 
			if(affichage_traduction)
			{
				$2=concatener_chaine("(",$2," ");
				$2=concatener_chaine($2,")"," ");
				$2=concatener_chaine($2,$4," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			
			if(affichage_grammaire) printf("Fin de reconnaissance condition_if (%s)\n",$1); 
			$$=$1;
		}
	|
	IF boolean THEN sous_block_instruction ELSE sous_block_instruction
		{ 
			if(affichage_traduction)
			{
				$5=concatener_chaine($5,$6," ");
				$4=concatener_chaine($4,$5," ");
				$2=concatener_chaine("(",$2," ");
				$2=concatener_chaine($2,")"," ");
				$2=concatener_chaine($2,$4," ");
				$1=concatener_chaine($1,$2," ");
			}
			else
			{
				$5=concatener_chaine($5,$6," ");
				$4=concatener_chaine($4,$5," ");
				$3=concatener_chaine($3,$4," ");
				$2=concatener_chaine($2,$3," ");
				$1=concatener_chaine($1,$2," ");
			}
			
			if(affichage_grammaire) printf("Fin de reconnaissance condition_if (%s)\n",$1); 
			$$=$1;
		}
	;
	
sous_block_instruction:
	block_instructions_global 
		{
			if(affichage_traduction)
			{
				$1=concatener_chaine("\n{\n",$1," ");
				$1=concatener_chaine($1,"\n}\n "," ");
			}
			if(affichage_grammaire) printf("Fin de reconnaissance condition_if_instruction_else_debut (%s)\n",$1); 
			$$=$1;
		}
	|
	instruction
		{
			if(affichage_traduction)
			{
				$1=$1;
			}
			if(affichage_grammaire) printf("Fin de reconnaissance condition_if_instruction_else_debut (%s)\n",$1); 
			$$=$1;
		}
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
	printf("-------------------\n");
	ajouterEnFinSimple("toto","test","");
	afficherListeSimple();
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
