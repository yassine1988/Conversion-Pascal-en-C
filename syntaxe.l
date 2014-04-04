%{
	#include "grammaire.tab.h"
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

{A}{N}{D}  					{ printf("AND "); 		return(AND);		}
{A}{R}{R}{A}{Y}  			{ printf("ARRAY "); 	return(ARRAY);		}
{C}{A}{S}{E}  				{ printf("CASE "); 		return(CASE);		}
{C}{O}{N}{S}{T}  			{ printf("CONST "); 	return(CONST);		}
{D}{I}{V}   				{ printf("DIV "); 		return(DIV);		}
{D}{O}    					{ printf("DO "); 		return(DO);			}
{E}{L}{S}{E}   				{ printf("ELSE "); 		return(ELSE);		}
{E}{N}{D}   				{ printf("END "); 		return(TEND);		}
{F}{O}{R}   				{ printf("FOR "); 		return(FOR);		}
{F}{U}{N}{C}{T}{I}{O}{N} 	{ printf("FUNCTION "); 	return(FUNCTION);	}
{I}{F}    					{ printf("IF "); 		return(IF);			}
{M}{O}{D}   				{ printf("MOD "); 		return(MOD);		}
{N}{O}{T}   				{ printf("NOT "); 		return(NOT);		}
{O}{F}    					{ printf("OF "); 		return(OF);			}
{O}{R}    					{ printf("OR "); 		return(OR);			}
{B}{E}{G}{I}{N}   			{ printf("BEGIN "); 	return(TBEGIN);		}
{P}{R}{O}{C}{E}{D}{U}{R}{E} { printf("PROCEDURE "); return(PROCEDURE);	}
{P}{R}{O}{G}{R}{A}{M}  		{ printf("PROGRAM "); 	return(PROGRAM);	}
{T}{H}{E}{N}   				{ printf("THEN "); 		return(THEN);		}
{T}{O}   					{ printf("TO "); 		return(TO);			}
{D}{O}{W}{N}{T}{O}			{ printf("DOWNTO ");	return(DOWNTO);		}
{V}{A}{R}   				{ printf("VAR "); 		return(VAR);		}
{W}{R}{I}{T}{E}{L}{N}  		{ printf("WRITELN "); 	return(WRITELN);	}
{W}{R}{I}{T}{E}		  		{ printf("WRITE "); 	return(WRITE);		}
{R}{E}{A}{D}{L}{N}			{ printf("READLN ");	return(READLN);		}
{W}{H}{I}{L}{E}  			{ printf("WHILE "); 	return(WHILE);		}
{W}{I}{T}{H}   				{ printf("WITH "); 		return(WITH);		}
{C}{L}{R}{S}{C}{R}			{ printf("CLRSCR ");	return(CLRSCR);		}
{G}{O}{T}{O}{X}{Y}			{ printf("GOTOXY ");	return(CLRSCR);		}
{T}{E}{X}{T}{C}{O}{L}{O}{R}	{ printf("TEXTCOLOR ");	return(TEXTCOLOR);	}
{T}{E}{X}{T}{B}{A}{C}{K}{G}{R}{O}{U}{N}{D}	{ printf("TEXTBACKGROUND "); return(TEXTBACKGROUND);}
{R}{A}{N}{D}{O}{M}{I}{Z}{E}	{ printf("RANDOMIZE ");	return(RANDOMIZE);	}
{R}{A}{N}{D}{O}{M}			{ printf("RANDOM");		return(RANDOM);		}
{A}{B}{S}					{ printf("ABS "); 		return(TABS);		}
{S}{Q}{R}{T}				{ printf("SQRT ");		return(TSQRT);		}
{S}{Q}{R}					{ printf("SQR");		return(TSQR);		}
{I}{N}{T}					{ printf("INT");		return(TINT);		}

{S}{T}{R}{I}{N}{G}			{ printf("STRING");		return(TYPE);		}
{I}{N}{T}{E}{G}{E}{R}		{ printf("INTEGER");	return(TYPE);		}
{T}{R}{U}{E}				{ printf("TRUE");		return(TTRUE);		}
{F}{A}{L}{S}{E}				{ printf("FALSE");		return(TFALSE);		}

[a-zA-Z]([a-zA-Z0-9])*  	{ printf("IDENTIFIANT");return(IDENTIFIANT);}



 ":="   			{ printf( "ASSIGNATION "); 			return(ASSIGNATION);		}
'({NQUOTE}|'')+'  	{ printf( "CHAINE_DE_CARACTERE "); 	return(CHAINE_DE_CARACTERE);}
 ":"    			{ printf( "DEUX_POINTS "); 			return(DEUX_POINTS);		}
 ","    			{ printf( "VIRGULE "); 				return(VIRGULE);			}
[0-9]+  			{ printf( "NOMBRE "); 				return(NOMBRE);				}
 "."    			{ printf( "POINT "); 				return(POINT);				}
 ".."   			{ printf( "POINTPOINT "); 			return(POINTPOINT);			}
 "="    			{ printf( "EGALE "); 				return(EGALE);				}
 ">="   			{ printf( "SUP_EGALE "); 			return(SUP_EGALE);			}
 ">"    			{ printf( "SUP "); 					return(SUP);				}
 "["    			{ printf( "CROCHETOUVRANT "); 		return(CROCHETOUVRANT);		}
 "<="   			{ printf( "INF_EGALE "); 			return(INF_EGALE);			}
 "("    			{ printf( "PARENTHESEOUVRANTE "); 	return(PARENTHESEOUVRANTE);	}
 "<"    			{ printf( "INF "); 					return(INF);				}
 "-"    			{ printf( "MOINS "); 				return(MOINS);				}
 "<>"   			{ printf( "INEGALE "); 				return(INEGALE);			}
 "+"    			{ printf( "PLUS "); 				return(PLUS);				}
 "]"    			{ printf( "CROCHETFERMANT "); 		return(CROCHETFERMANT);		}
[0-9]+"."[0-9]+   	{ printf( "NOMBREREEL "); 			return(NOMBREREEL);			}
 ")"    			{ printf( "PARENTHESEFERMANTE "); 	return(PARENTHESEFERMANTE);	}
 ";"    			{ printf( "POINTVIRGULE "); 		return(POINTVIRGULE);		}
 "/"    			{ printf( "SLASH "); 				return(SLASH);				}
 "*"    			{ printf( "MULTIPLIE "); 			return(MULTIPLIE);			}
 "**"    			{ printf( "PUISSANCE "); 			return(PUISSANCE);			}
 "->" | "^" 		{ printf( "FLECHEHAUT "); 			return(FLECHEHAUT);			}
		
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

[ \t\f]    printf(" ");

\n    { ligne_no++; printf( "\n ");}

.    { fprintf (stderr,
     "'%c' (0%o): mauvais caratère à la ligne %d\n ",
     yytext[0], yytext[0], ligne_no);
    }

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
