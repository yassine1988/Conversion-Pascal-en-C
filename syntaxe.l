%{
	#include "grammaire.tab.h"
	extern FILE *yyin;
	int ligne_no = 1;
	int affichage = 0;
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

{A}{N}{D}  					{ if(affichage)	printf("AND "); 		return(AND);		}
{A}{R}{R}{A}{Y}  			{ if(affichage)	printf("ARRAY "); 	return(ARRAY);		}
{C}{A}{S}{E}  				{ if(affichage)	printf("CASE "); 		return(CASE);		}
{C}{O}{N}{S}{T}  			{ if(affichage)	printf("CONST "); 	return(CONST);		}
{D}{I}{V}   				{ if(affichage)	printf("DIV "); 		return(DIV);		}
{D}{O}    					{ if(affichage)	printf("DO "); 		return(DO);			}
{E}{L}{S}{E}   				{ if(affichage)	printf("ELSE "); 		return(ELSE);		}
{E}{N}{D}   				{ if(affichage)	printf("END "); 		return(TEND);		}
{F}{O}{R}   				{ if(affichage)	printf("FOR "); 		return(FOR);		}
{F}{U}{N}{C}{T}{I}{O}{N} 	{ if(affichage)	printf("FUNCTION "); 	return(FUNCTION);	}
{I}{F}    					{ if(affichage)	printf("IF "); 		return(IF);			}
{M}{O}{D}   				{ if(affichage)	printf("MOD "); 		return(MOD);		}
{N}{O}{T}   				{ if(affichage)	printf("NOT "); 		return(NOT);		}
{O}{F}    					{ if(affichage)	printf("OF "); 		return(OF);			}
{O}{R}    					{ if(affichage)	printf("OR "); 		return(OR);			}
{B}{E}{G}{I}{N}   			{ if(affichage)	printf("BEGIN "); 	return(TBEGIN);		}
{P}{R}{O}{C}{E}{D}{U}{R}{E} { if(affichage)	printf("PROCEDURE "); return(PROCEDURE);	}
{P}{R}{O}{G}{R}{A}{M}  		{ if(affichage)	printf("PROGRAM "); 	return(PROGRAM);	}
{T}{H}{E}{N}   				{ if(affichage)	printf("THEN "); 		return(THEN);		}
{T}{O}   					{ if(affichage)	printf("TO "); 		return(TO);			}
{D}{O}{W}{N}{T}{O}			{ if(affichage) printf("DOWNTO ");	return(DOWNTO);		}
{V}{A}{R}   				{ if(affichage) printf("VAR "); 		return(VAR);		}
{W}{R}{I}{T}{E}{L}{N}  		{ if(affichage) printf("WRITELN "); 	return(WRITELN);	}
{W}{R}{I}{T}{E}		  		{ if(affichage) printf("WRITE "); 	return(WRITE);		}
{R}{E}{A}{D}{L}{N}			{ if(affichage) printf("READLN ");	return(READLN);		}
{W}{H}{I}{L}{E}  			{ if(affichage) printf("WHILE "); 	return(WHILE);		}
{W}{I}{T}{H}   				{ if(affichage) printf("WITH "); 		return(WITH);		}
{C}{L}{R}{S}{C}{R}			{ if(affichage) printf("CLRSCR ");	return(CLRSCR);		}
{G}{O}{T}{O}{X}{Y}			{ if(affichage) printf("GOTOXY ");	return(CLRSCR);		}
{T}{E}{X}{T}{C}{O}{L}{O}{R}	{ if(affichage) printf("TEXTCOLOR ");	return(TEXTCOLOR);	}
{T}{E}{X}{T}{B}{A}{C}{K}{G}{R}{O}{U}{N}{D}	{ if(affichage) printf("TEXTBACKGROUND "); return(TEXTBACKGROUND);}
{R}{A}{N}{D}{O}{M}{I}{Z}{E}	{ if(affichage) printf("RANDOMIZE ");	return(RANDOMIZE);	}
{R}{A}{N}{D}{O}{M}			{ if(affichage) printf("RANDOM ");		return(RANDOM);		}
{A}{B}{S}					{ if(affichage) printf("ABS "); 		return(TABS);		}
{S}{Q}{R}{T}				{ if(affichage) printf("SQRT ");		return(TSQRT);		}
{S}{Q}{R}					{ if(affichage) printf("SQR ");		return(TSQR);		}
{I}{N}{T}					{ if(affichage) printf("INT ");		return(TINT);		}

{S}{T}{R}{I}{N}{G}			{ if(affichage) printf("STRING ");	char *copie = malloc(sizeof(copie)); strcpy(copie,yytext); yylval.type_string = copie; return(TYPE);		}
{I}{N}{T}{E}{G}{E}{R}		{ if(affichage) printf("INTEGER ");	char *copie = malloc(sizeof(copie)); strcpy(copie,yytext); yylval.type_string = copie; return(TYPE);			}
{T}{R}{U}{E}				{ if(affichage) printf("TRUE ");		return(TTRUE);		}
{F}{A}{L}{S}{E}				{ if(affichage) printf("FALSE ");		return(TFALSE);		}

[a-zA-Z]([a-zA-Z0-9])*  	{ if(affichage) printf("IDENTIFIANT "); char *copie = malloc(sizeof(copie)); strcpy(copie,yytext); yylval.type_string = copie; return(IDENTIFIANT);}



 ":="   			{ if(affichage) printf( "ASSIGNATION "); 			return(ASSIGNATION);		}
'({NQUOTE}|'')+'  	{ if(affichage) printf( "CHAINE_DE_CARACTERE "); 	return(CHAINE_DE_CARACTERE);}
 ":"    			{ if(affichage) printf( "DEUX_POINTS "); 			return(DEUX_POINTS);		}
 ","    			{ if(affichage) printf( "VIRGULE "); 				return(VIRGULE);			}
[0-9]+  			{ if(affichage) printf( "NOMBRE "); 			yylval.type_string = yytext;	return(NOMBRE);				}
 "."    			{ if(affichage) printf( "POINT "); 				return(POINT);				}
 ".."   			{ if(affichage) printf( "POINTPOINT "); 			return(POINTPOINT);			}
 "="    			{ if(affichage) printf( "EGALE "); 				return(EGALE);				}
 ">="   			{ if(affichage) printf( "SUP_EGALE "); 			return(SUP_EGALE);			}
 ">"    			{ if(affichage) printf( "SUP "); 					return(SUP);				}
 "["    			{ if(affichage) printf( "CROCHETOUVRANT "); 		return(CROCHETOUVRANT);		}
 "<="   			{ if(affichage) printf( "INF_EGALE "); 			return(INF_EGALE);			}
 "("    			{ if(affichage) printf( "PARENTHESEOUVRANTE "); 	return(PARENTHESEOUVRANTE);	}
 "<"    			{ if(affichage) printf( "INF "); 					return(INF);				}
 "-"    			{ if(affichage) printf( "MOINS "); 				return(MOINS);				}
 "<>"   			{ if(affichage) printf( "INEGALE "); 				return(INEGALE);			}
 "+"    			{ if(affichage) printf( "PLUS "); 				return(PLUS);				}
 "]"    			{ if(affichage) printf( "CROCHETFERMANT "); 		return(CROCHETFERMANT);		}
[0-9]+"."[0-9]+   	{ if(affichage) printf( "NOMBREREEL "); 		yylval.type_string = yytext;	return(NOMBREREEL);			}
 ")"    			{ if(affichage) printf( "PARENTHESEFERMANTE "); 	return(PARENTHESEFERMANTE);	}
 ";"    			{ if(affichage) printf( "POINTVIRGULE "); 		return(POINTVIRGULE);		}
 "/"    			{ if(affichage) printf( "SLASH "); 				return(SLASH);				}
 "*"    			{ if(affichage) printf( "MULTIPLIE "); 			return(MULTIPLIE);			}
 "**"    			{ if(affichage) printf( "PUISSANCE "); 			return(PUISSANCE);			}
 "->" | "^" 		{ if(affichage) printf( "FLECHEHAUT "); 			return(FLECHEHAUT);			}
		
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

[ \t\f]    { if(affichage) printf(" "); };

\n    { ligne_no++; if(affichage) printf( "\n ");}

.    { fprintf (stderr,"'%c' (0%o): mauvais caratère à la ligne %d\n ",yytext[0], yytext[0], ligne_no); }

%%

commenteof()
{
	fprintf (stderr,  "Fin de fichier innatendue à la ligne : %d\n ", ligne_no);
	exit (1);
}

yywrap ()
{
	return (1);
}
