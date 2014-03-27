%{
	#include <stdio.h>
	extern FILE *yyin;
	int ligne_no = 1;	
%}

A [aA]
B [bB]
C [cC]
D [dD]
E [eE]
F [fF]
G [gG]
H [hH]
I [iI]
J [jJ]
K [kK]
L [lL]
M [mM]
N [nN]
O [oO]
P [pP]
Q [qQ]
R [rR]
S [sS]
T [tT]
U [uU]
V [vV]
W [wW]
X [xX]
Y [yY]
Z [zZ]
NQUOTE [^']

%%

{A}{N}{D}   printf( "AND ");
{A}{R}{R}{A}{Y}   printf( "ARRAY ");
{C}{A}{S}{E}   printf( "CASE ");
{C}{O}{N}{S}{T}   printf( "CONST ");
{D}{I}{V}   printf( "DIV ");
{D}{O}    printf( "DO ");
{E}{L}{S}{E}   printf( "ELSE ");
{E}{N}{D}   printf( "END ");
{F}{O}{R}   printf( "FOR ");
{F}{U}{N}{C}{T}{I}{O}{N} printf( "FUNCTION ");
{I}{F}    printf( "IF ");
{M}{O}{D}   printf( "MOD ");
{N}{O}{T}   printf( "NOT ");
{O}{F}    printf( "OF ");
{O}{R}    printf( "OR ");
{B}{E}{G}{I}{N}   printf( "BEGIN ");
{F}{I}{L}{E}   printf( "FILE ");
{P}{R}{O}{C}{E}{D}{U}{R}{E} printf( "PROCEDURE ");
{P}{R}{O}{G}{R}{A}{M}  printf( "PROGRAM ");
{T}{H}{E}{N}   printf( "THEN ");
{T}{O}    printf( "TO ");
{V}{A}{R}   printf( "VAR ");
{W}{H}{I}{L}{E}   printf( "WHILE ");
{W}{I}{T}{H}   printf( "WITH ");
[a-zA-Z]([a-zA-Z0-9])*  printf( "VARIABLE ");

 ":="    printf( "ASSIGNATION ");
'({NQUOTE}|'')+'  printf( "CHAINE_DE_CARACTERE ");
 ":"    printf( "DEUX_POINTS ");
 ","    printf( "VIRGULE ");
[0-9]+    printf( "NOMBRE ");
 "."    printf( "POINT ");
 ".."    printf( "POINTPOINT ");
 "="    printf( "EGALE ");
 ">="    printf( "SUP_EGALE ");
 ">"    printf( "SUP ");
 "["    printf( "CROCHETOUVRANT ");
 "<="    printf( "INF_EGALE ");
 "("    printf( "PARENTHESEOUVRANTE ");
 "<"    printf( "INF ");
 "-"    printf( "MOINS ");
 "<>"    printf( "INEGALE ");
 "+"    printf( "PLUS ");
 "]"    printf( "CROCHETFERMANT ");
[0-9]+"."[0-9]+   printf( "NOMBREREEL ");
 ")"    printf( "PARENTHESEFERMANTE ");
 ";"    printf( "POINTVIRGULE ");
 "/"    printf( "SLASH ");
 "*"    printf( "MULTIPLIE ");
 "**"    printf( "PUISSANCE ");
 "->"   |
 "^"    printf( "FLECHEHAUT ");

 "{"    { register int c;
     while ((c = input()))
     {
      if (c == '}')
       break;
      else if (c == '*')
      {
       if ((c = input()) == ')')
        break;
       else
        unput (c);
      }
      else if (c == '\n')
       ligne_no++;
      else if (c == 0)
       commenteof();
     }
    }

[ \t\f]    printf( " ");

\n    { ligne_no++; printf( "\n ");}

.    { fprintf (stderr,
     "'%c' (0%o): mauvais caratère à la ligne %d\n ",
     yytext[0], yytext[0], ligne_no);
    }

%%
int main(int argc, char * argv[])
{
	FILE * f=NULL;
	if(argc > 1)
	{
		f=fopen(argv[1], "r");
		if(f==NULL)
		{
			fprintf(stderr, "Impossible d'ouvrir %s\n ",argv[1]);
			return -1;
		}
		yyin = f;
	}
	yylex();
	printf( "\nFin du programme\n ");
	if(f != NULL)
	{
		fclose(f);
	}	
}
commenteof()
{
 fprintf (stderr,  "Fin de fichier innatendue à la ligne : %d\n ",
  ligne_no);
 exit (1);
}

yywrap ()
{
 return (1);
}
