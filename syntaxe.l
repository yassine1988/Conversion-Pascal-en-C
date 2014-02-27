%{
#include<stdio.h>
void yyerror(char *s);
%}

TYPEVARIABLE "integer"|"real"|"boolean"|"INTEGER"|"REAL"|"BOOLEAN"
OPERATEUR "+"|"-"|"*"|"/"|"DIV"|"MOD"|"<"|"<="|">"|">="|"="|"<>"
AFFECTATION ":="
IF "IF"|"if"
ELSE "ELSE"|"else"
THEN "THEN"|"then"
WHILE "WHILE"|"while"
LETTRE [a-zA-Z_]
CHIFFRE [0-9]
REAL {CHIFFRE}+(","{CHIFFRE}+)?
MOTCLE "begin"|"end"|"BEGIN"|"END"|"PROGRAM"|"FUNCTION"|"VAR"|"DO"
ENTRESORTIE "WRITELN"|"writeln"|"READLN"|"readln"
SEPARATEUR [ \t]

%x COMMENTAIRE
%%
{ENTRESORTIE} {
    printf("entresortie(%s)",yytext);
}

{IF}|{ELSE}|{THEN}|{WHILE}|{MOTCLE} {
    printf("motcle(%s)",yytext);
}

{TYPEVARIABLE} {
    printf("typevariable(%s)",yytext);
}


";" {

}

"." {

}

":" {
    printf("definition(%s)",yytext);
}

"(" {
    printf("%s",yytext);
}

")" {
     printf("%s",yytext);
}

{CHIFFRE}+ {
     printf("integer(%s)",yytext);
}

{REAL} {
    printf("real(%s)",yytext);
}

{AFFECTATION} {
    printf("affectation(%s)",yytext);
}

{OPERATEUR} {
    printf("operateur(%s)",yytext);
}

{LETTRE}({LETTRE}|{CHIFFRE})* {
    printf("variable(%s)",yytext);
}


{SEPARATEUR}* {

}

"{" {
	BEGIN(COMMENTAIRE);
	printf("Commen");
}

<COMMENTAIRE>"}" {
	BEGIN(INITIAL);
	printf("taire");
}

<COMMENTAIRE>.|\n {
}

<COMMENTAIRE><<EOF>> {
	BEGIN(INITIAL);
	printf("Erreur, commentaire non terminé\n	");
}

. {
    printf("Erreur, caractère non reconnu!!!");
}

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
	yylex();			
	if(f != NULL)
	{
		fclose(f);
	}	
}

void yyerror(char *s)
{
	fprintf(stderr,"Erreur %s\n",s);
}