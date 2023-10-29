%{
#include <stdio.h>
#include <string.h>
#include "tokens.h"
%}

entero [-]?[0-9]+
exponente [eE]{entero}
flotante [-]?([0-9]+([.][0-9]*)?|[.][0-9]+){exponente}?

letra [a-zA-Z]
letrasSinE [a-zA-Z]{-}[eE]
exponenteInvalido {letrasSinE}|{letra}{letra}
idVariable {letra}({letra}|[0-9])*
idFuncion a?(sin|cos|tan)|sqrt|log
fueraDelAlfabeto [^ \n\t]{-}[0-9a-zA-Z.()^=*+/-]

identificador {idVariable}|{idFuncion}
numero {flotante}|{entero}
cadenaDesconocida {fueraDelAlfabeto}.*
realInvalido \.*{flotante}({exponenteInvalido}|[.])({numero}|{letra})*
constanteInvalida {entero}{exponenteInvalido}({letra}|{entero})*

%option header-file="scanner.h"
%option outfile="scanner.c"
%option yylineno
%option noinput 
%option nounput
%option noyywrap

%%

var {                                   return PR_VAR;}
salir {                                 return FDT;}
{identificador} {                       return IDENTIFICADOR;}
\n {                                    strcpy(yytext, "NL"); return NL;}
{numero} {                              return NUMERO;}
-=  {                                   return OP_MENOS_IG;} 
\+= {                                   return OP_MAS_IG;}
\*= {                                   return OP_POR_IG;}
\/= {                                   return OP_DIV_IG;}
{cadenaDesconocida} {                   printf("Error: Cadena desconocida: '%s'\n", yytext);}
{identificador}{cadenaDesconocida}  {   printf("Error: Identificador invalido: '%s'\n", yytext);}
{constanteInvalida} {                   printf("Error: Constante invalida: '%s'\n", yytext);}
{realInvalido} {                        printf("Error: Real invalido: '%s'\n", yytext);}
[=^+/*()-] {                            return yytext[0];}
.|\n                                    //null;
%%