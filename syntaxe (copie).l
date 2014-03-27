%{
    #include "grammaire.tab.h"
%}

TYPE "integer"|"INTEGER"|"real"|"REAL"|"boolean"|"BOOLEAN"
OPERATEUR "+"|"-"|"*"|"/"|"DIV"|"MOD"|"<"|"<="|">"|">="|"="|"<>"
AFFECTATION ":="
IF "IF"|"if"
WHILE "WHILE"|"while"
LETTRE [a-zA-Z_]
CHIFFRE [0-9]
REAL {CHIFFRE}+(","{CHIFFRE}+)?
MOTCLE "begin"|"end"|"BEGIN"|"END"|"PROGRAM"|"FUNCTION"|"VAR"|"DO"|"PROCEDURE"|"THEN"|"then"|"ELSE"|"else"
ENTRSORTI "WRITELN"|"writeln"|"READLN"|"readln"
SEPARATEUR [ \t]

%x COMMENTAIRE
%%

{TYPE} {
    return TYPEVARIABLE;
}

{ENTRSORTI} {
    return ENTRESORTIE;
}

{IF}|{WHILE} {
    return CONDITION;
}

{MOTCLE} {
    return CLE;
}

";" {
    return FIN_INSTRUCTION;
}

"." {
    return FIN_PROGRAM;
}

":" {
    return SIGNATURE;
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

{AFFECTATION} {
    printf("affectation(%s)",yytext);
}

{OPERATEUR} {
    printf("operateur(%s)",yytext);
}

{LETTRE}({LETTRE}|{CHIFFRE})* {
    printf("variable(%s)",yytext);
    return MOT;
}


{SEPARATEUR}* {
	return SEP;
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

\n {
	return FIN_LIGNE;
}

. {
    printf("Erreur, caractère non reconnu!!!");
}

%%
