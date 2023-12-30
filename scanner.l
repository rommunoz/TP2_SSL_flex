%{
#include <stdio.h>
#include <string.h>
#include "tokens.h"
%}
                      
exponente                           [-]?[eE][0-9]+ 
flotante                            ([0-9]+([.][0-9]*)?|[.][0-9]+){exponente}?

letra                               [a-zA-Z]
exponenteInvalido                   [a-zA-Z]{-}[eE]|{letra}{letra}
fueraDelAlfabeto                    [[:punct:]]{-}[0-9a-zA-Z.()^=*+/-]

identificador                       {letra}({letra}|[0-9])*
numero                              {flotante}|[0-9]+
realInvalido                        \.*{flotante}({exponenteInvalido}|[.])({numero}|{letra}|\.)*
constanteInvalida                   [0-9]+{exponenteInvalido}({letra}|[0-9]+)*
idInvalido                          {identificador}{fueraDelAlfabeto}.*

%option header-file="scanner.h"
%option outfile="scanner.c"
%option yylineno
%option noinput 
%option nounput
%option noyywrap
    //%option debug

%%

var                                 return PR_VAR;
salir                               return PR_SALIR;
{identificador}                     return IDENTIFICADOR;
\n                                  return NL;
{numero}                            return NUMERO;
-=                                  return OP_MENOS_IG;
\+=                                 return OP_MAS_IG;
\*=                                 return OP_POR_IG;
\/=                                 return OP_DIV_IG;
{idInvalido}                        printf("Error léxico: Identificador invalido: '%s'\n", yytext);
{constanteInvalida}                 printf("Error léxico: Constante invalida: '%s'\n", yytext);
\.({numero}|[[:punct:]])+           |
{realInvalido}                      printf("Error léxico: Real invalido: '%s'\n", yytext);
{fueraDelAlfabeto}+                 printf("Error léxico: Cadena desconocida: '%s'\n", yytext);
[=^+/*()-]                          return yytext[0];
.|\n                                //null;

%%