%{
	#include"table.h"
	#include "grammaire.tab.h"
	extern FILE *yyin;
	int ligne_no = 1;
	int affichage = 0;
	
	char * copier_chaine(char * chaine_a_copier) 
	{
		char *copie = malloc(sizeof(chaine_a_copier)); 
		strcpy(copie,chaine_a_copier); 
		return copie;
	}
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

{A}{N}{D}  					{ if(affichage)	printf("AND "); 	yylval.type_string = copier_chaine(yytext); 	return(AND);		}
{A}{R}{R}{A}{Y}  			{ if(affichage)	printf("ARRAY "); 	yylval.type_string = copier_chaine(yytext);  return(ARRAY);		}
{C}{A}{S}{E}  				{ if(affichage)	printf("CASE "); 	yylval.type_string = copier_chaine(yytext); 	return(CASE);		}
{C}{O}{N}{S}{T}  			{ if(affichage)	printf("CONST "); 	yylval.type_string = copier_chaine(yytext);  return(CONST);		}
{D}{I}{V}   				{ if(affichage)	printf("DIV "); 	yylval.type_string = copier_chaine(yytext); 	return(DIV);		}
{D}{O}    					{ if(affichage)	printf("DO "); 		yylval.type_string = copier_chaine(yytext); return(DO);			}
{E}{L}{S}{E}   				{ if(affichage)	printf("ELSE "); 	yylval.type_string = copier_chaine(yytext); 	return(ELSE);		}
{E}{N}{D}   				{ if(affichage)	printf("END "); 	yylval.type_string = copier_chaine(yytext); 	return(TEND);		}
{F}{O}{R}   				{ if(affichage)	printf("FOR "); 	yylval.type_string = copier_chaine(yytext); 	return(FOR);		}
{F}{U}{N}{C}{T}{I}{O}{N} 	{ if(affichage)	printf("FUNCTION "); yylval.type_string = copier_chaine(yytext); 	return(FUNCTION);	}
{I}{F}    					{ if(affichage)	printf("IF "); 		yylval.type_string = copier_chaine(yytext); return(IF);			}
{M}{O}{D}   				{ if(affichage)	printf("MOD "); 	yylval.type_string = copier_chaine(yytext); 	return(MOD);		}
{N}{O}{T}   				{ if(affichage)	printf("NOT "); 	yylval.type_string = copier_chaine(yytext); 	return(NOT);		}
{O}{F}    					{ if(affichage)	printf("OF "); 		yylval.type_string = copier_chaine(yytext); return(OF);			}
{O}{R}    					{ if(affichage)	printf("OR "); 		yylval.type_string = copier_chaine(yytext); return(OR);			}
{B}{E}{G}{I}{N}   			{ if(affichage)	printf("BEGIN "); 	yylval.type_string = copier_chaine(yytext); return(TBEGIN);		}
{P}{R}{O}{C}{E}{D}{U}{R}{E} { if(affichage)	printf("PROCEDURE ");yylval.type_string = copier_chaine(yytext);  return(PROCEDURE);	}
{P}{R}{O}{G}{R}{A}{M}  		{ if(affichage)	printf("PROGRAM "); yylval.type_string = copier_chaine(yytext); 	return(PROGRAM);	}
{T}{H}{E}{N}   				{ if(affichage)	printf("THEN "); 	yylval.type_string = copier_chaine(yytext); 	return(THEN);		}
{T}{O}   					{ if(affichage)	printf("TO "); 		yylval.type_string = copier_chaine(yytext); return(TO);			}
{D}{O}{W}{N}{T}{O}			{ if(affichage) printf("DOWNTO ");	yylval.type_string = copier_chaine(yytext); return(DOWNTO);		}
{V}{A}{R}   				{ if(affichage) printf("VAR "); 	yylval.type_string = copier_chaine(yytext); 	return(VAR);		}
{W}{R}{I}{T}{E}{L}{N}  		{ if(affichage) printf("WRITELN "); yylval.type_string = copier_chaine(yytext); 	return(WRITELN);	}
{W}{R}{I}{T}{E}		  		{ if(affichage) printf("WRITE "); 	yylval.type_string = copier_chaine(yytext); return(WRITE);		}
{R}{E}{A}{D}{L}{N}			{ if(affichage) printf("READLN ");	yylval.type_string = copier_chaine(yytext); return(READLN);		}
{W}{H}{I}{L}{E}  			{ if(affichage) printf("WHILE "); 	yylval.type_string = copier_chaine(yytext); return(WHILE);		}
{W}{I}{T}{H}   				{ if(affichage) printf("WITH "); 	yylval.type_string = copier_chaine(yytext); 	return(WITH);		}
{C}{L}{R}{S}{C}{R}			{ if(affichage) printf("CLRSCR ");	yylval.type_string = copier_chaine(yytext); return(CLRSCR);		}
{G}{O}{T}{O}{X}{Y}			{ if(affichage) printf("GOTOXY ");	yylval.type_string = copier_chaine(yytext); return(CLRSCR);		}
{T}{E}{X}{T}{C}{O}{L}{O}{R}	{ if(affichage) printf("TEXTCOLOR ");	yylval.type_string = copier_chaine(yytext); return(TEXTCOLOR);	}
{T}{E}{X}{T}{B}{A}{C}{K}{G}{R}{O}{U}{N}{D}	{ if(affichage) printf("TEXTBACKGROUND "); yylval.type_string = copier_chaine(yytext); return(TEXTBACKGROUND);}
{R}{A}{N}{D}{O}{M}{I}{Z}{E}	{ if(affichage) printf("RANDOMIZE ");	yylval.type_string = copier_chaine(yytext); return(RANDOMIZE);	}
{R}{A}{N}{D}{O}{M}			{ if(affichage) printf("RANDOM ");		yylval.type_string = copier_chaine(yytext); return(RANDOM);		}
{A}{B}{S}					{ if(affichage) printf("ABS "); 		yylval.type_string = copier_chaine(yytext); return(TABS);		}
{S}{Q}{R}{T}				{ if(affichage) printf("SQRT ");		yylval.type_string = copier_chaine(yytext); return(TSQRT);		}
{S}{Q}{R}					{ if(affichage) printf("SQR ");		yylval.type_string = copier_chaine(yytext); return(TSQR);		}
{I}{N}{T}					{ if(affichage) printf("INT ");		yylval.type_string = copier_chaine(yytext); return(TINT);		}
{R}{E}{P}{E}{A}{T}			{ if(affichage) printf("REPEAT ");		yylval.type_string = copier_chaine(yytext); return(REPEAT);		}
{U}{N}{T}{I}{L}				{ if(affichage) printf("UNTIL ");		yylval.type_string = copier_chaine(yytext); return(UNTIL);		}

{S}{T}{R}{I}{N}{G}			{ 	if(affichage) printf("STRING ");	
								yylval.type_string = copier_chaine("char * "); 
								return(TYPE);		
							}
{I}{N}{T}{E}{G}{E}{R}		{ 	if(affichage) printf("INTEGER ");	
								yylval.type_string = copier_chaine("int");  
								return(TYPE);			
							}
{T}{R}{U}{E}				{ if(affichage) printf("TRUE ");	yylval.type_string = copier_chaine(yytext);	return(TTRUE);		}
{F}{A}{L}{S}{E}				{ if(affichage) printf("FALSE ");	yylval.type_string = copier_chaine(yytext);	return(TFALSE);		}

[a-zA-Z]([a-zA-Z0-9])*  	{ 	if(affichage) printf("IDENTIFIANT "); 
								yylval.type_string = copier_chaine(yytext); 
								return(IDENTIFIANT);
							}



 ":="   			{ if(affichage) printf( "ASSIGNATION "); 			yylval.type_string = copier_chaine(yytext); return(ASSIGNATION);		}
'({NQUOTE}|'')+'  	{ if(affichage) printf( "CHAINE_DE_CARACTERE "); 	yylval.type_string = copier_chaine(yytext); return(CHAINE_DE_CARACTERE);}
 ":"    			{ if(affichage) printf( "DEUX_POINTS "); 			yylval.type_string = copier_chaine(yytext); return(DEUX_POINTS);		}
 ","    			{ if(affichage) printf( "VIRGULE "); 				yylval.type_string = copier_chaine(yytext); return(VIRGULE);			}
[0-9]+  			{ 	if(affichage) printf( "NOMBRE "); 			
						yylval.type_string = copier_chaine(yytext); 
						return(NOMBRE);
					}
 "."    			{ if(affichage) printf( "POINT "); 				yylval.type_string = copier_chaine(yytext); return(POINT);				}
 ".."   			{ if(affichage) printf( "POINTPOINT "); 		yylval.type_string = copier_chaine(yytext); 	return(POINTPOINT);			}
 "="    			{ if(affichage) printf( "EGALE "); 				yylval.type_string = copier_chaine(yytext); return(EGALE);				}
 ">="   ;			{ if(affichage) printf( "SUP_EGALE "); 			yylval.type_string = copier_chaine(yytext); return(SUP_EGALE);			}
 ">"    			{ if(affichage) printf( "SUP "); 				yylval.type_string = copier_chaine(yytext); 	return(SUP);				}
 "["    			{ if(affichage) printf( "CROCHETOUVRANT "); 	yylval.type_string = copier_chaine(yytext); 	return(CROCHETOUVRANT);		}
 "<="   			{ if(affichage) printf( "INF_EGALE "); 			yylval.type_string = copier_chaine(yytext); return(INF_EGALE);			}
 "("    			{ if(affichage) printf( "PARENTHESEOUVRANTE "); yylval.type_string = copier_chaine(yytext); 	return(PARENTHESEOUVRANTE);	}
 "<"    			{ if(affichage) printf( "INF "); 				yylval.type_string = copier_chaine(yytext); 	return(INF);				}
 "-"    			{ if(affichage) printf( "MOINS "); 				yylval.type_string = copier_chaine(yytext); return(MOINS);				}
 "<>"   			{ if(affichage) printf( "INEGALE "); 			yylval.type_string = copier_chaine(yytext); 	return(INEGALE);			}
 "+"    			{ if(affichage) printf( "PLUS "); 				yylval.type_string = copier_chaine(yytext); return(PLUS);				}
 "]"    			{ if(affichage) printf( "CROCHETFERMANT "); 	yylval.type_string = copier_chaine(yytext); 	return(CROCHETFERMANT);		}
[0-9]+"."[0-9]+   	{ 	if(affichage) printf( "NOMBREREEL "); 		
						yylval.type_string = copier_chaine(yytext);  	
						return(NOMBREREEL);			
					}
 ")"    			{ if(affichage) printf( "PARENTHESEFERMANTE "); yylval.type_string = copier_chaine(yytext); 	return(PARENTHESEFERMANTE);	}
 ";"    			{ if(affichage) printf( "POINTVIRGULE "); 		yylval.type_string = copier_chaine(yytext); return(POINTVIRGULE);		}
 "/"    			{ if(affichage) printf( "SLASH "); 				yylval.type_string = copier_chaine(yytext); return(SLASH);				}
 "*"    			{ if(affichage) printf( "MULTIPLIE "); 			yylval.type_string = copier_chaine(yytext); return(MULTIPLIE);			}
 "**"    			{ if(affichage) printf( "PUISSANCE "); 			yylval.type_string = copier_chaine(yytext); return(PUISSANCE);			}
 "->" | "^" 		{ if(affichage) printf( "FLECHEHAUT "); 		yylval.type_string = copier_chaine(yytext); 	return(FLECHEHAUT);			}
		
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

[ \t\f] { 
		if(affichage) printf(" "); 
		yylval.type_string = copier_chaine(yytext);
		//return ESPACE;
	};

\n    { 
		ligne_no++; 
		if(affichage) printf( "\n ");
		yylval.type_string = copier_chaine(yytext);
		//return LIGNE;
	}

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
