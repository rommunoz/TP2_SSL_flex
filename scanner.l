%{
#include <stdio.h>
#include <string.h>
#include "tokens.h"
%}
                      
exponente                           [-]?[eE][0-9]+ 
flotante                            ([0-9]+([.][0-9]*)?|[.][0-9]+){exponente}?

letra                               [a-zA-Z]
letrasSinE                          [a-zA-Z]{-}[eE]
exponenteInvalido                   {letrasSinE}|{letra}{letra}
idVariable                          {letra}({letra}|[0-9])*
idFuncion                           a?(sin|cos|tan)|sqrt|log
fueraDelAlfabeto                    [[:punct:]]{-}[0-9a-zA-Z.()^=*+/-]

identificador                       {idVariable}|{idFuncion}
numero                              {flotante}|[0-9]+
cadenaDesconocida                   {fueraDelAlfabeto}+
realInvalido                        \.*{flotante}({exponenteInvalido}|[.])({numero}|{letra}|\.)*
constanteInvalida                   [0-9]+{exponenteInvalido}({letra}|[0-9]+)*

%option header-file="scanner.h"
%option outfile="scanner.c"
%option yylineno
%option noinput 
%option nounput
    //%option noyywrap
    //%option debug

%%

var                                 return PR_VAR;
salir                               return FDT;
{identificador}                     return IDENTIFICADOR;
\n                                  return NL;
{numero}                            return NUMERO;
-=                                  return OP_MENOS_IG;
\+=                                 return OP_MAS_IG;
\*=                                 return OP_POR_IG;
\/=                                 return OP_DIV_IG;
{identificador}{cadenaDesconocida}  printf("Error lexico: Identificador invalido: '%s'\n", yytext);
{constanteInvalida}                 printf("Error lexico: Constante invalida: '%s'\n", yytext);
\.({numero}|[[:punct:]])*           |
{realInvalido}                      printf("Error lexico: Real invalido: '%s'\n", yytext);
{cadenaDesconocida}                 printf("Error lexico: Cadena desconocida: '%s'\n", yytext);
[=^+/*()-]                          return yytext[0];
.|\n                                //null;

%%