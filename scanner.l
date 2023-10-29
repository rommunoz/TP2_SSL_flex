%{
#include <stdio.h>
#include <string.h>
#include "tokens.h"
%}

entero [+-]?[0-9]+
exponente [eE]{entero}
flotante [+-]?([0-9]+([.][0-9]*)?|[.][0-9]+){exponente}?

letra [a-zA-z]
letrasSinE [a-zA-z]{-}[eE]
idVariable {letra}({letra}|[0-9])*
idFuncion a?(sin|cos|tan)|sqrt|log
fueraDelAlfabeto [^0-9a-zA-Z.()=*+/-]{-}[ \n\t]

identificador {idVariable}|{idFuncion}
numero {flotante}|{entero}
menosIgual -=
masIgual \+=
porIgual \*=
divIgual \/=
palResVar var
palResSalida salir
cadenaDesconocida {fueraDelAlfabeto}.*
literalInvalido {numero}({letra}+|[.]([0-9]*[.]+[0-9]*)+)

%option header-file="scanner.h"
%option outfile="scanner.c"
%option yylineno
%option noinput 
%option nounput

%%

var {                                   return PR_VAR;}
salir {                                 return PR_SALIR;}
{identificador} {                       return IDENTIFICADOR;}
\n {                                    strcpy(yytext, ""); return NL;}
{numero} {                              return NUMERO;}
{menosIgual} {                          strcpy(yytext, ""); return OP_MENOS_IG;} 
{masIgual} {                            strcpy(yytext, ""); return OP_MAS_IG;}
{porIgual} {                            strcpy(yytext, ""); return OP_POR_IG;}
{divIgual} {                            strcpy(yytext, ""); return OP_DIV_IG;}
{cadenaDesconocida} {                   printf("Error: Cadena desconocida: %s", yytext);}
{identificador}{cadenaDesconocida}  {   printf("Error: Identificador invalido: %s", yytext);}
{literalInvalido} {                     printf("Error: Literal invalido: %s", yytext);}

%%