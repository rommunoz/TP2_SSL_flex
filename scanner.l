%{
#include <stdio.h>
#include <string.h>
#include "tokens.h"
%}

entero                              [-]?[0-9]+
exponente                           [eE]{entero}
flotante                            [-]?([0-9]+([.][0-9]*)?|[.][0-9]+){exponente}?

letra                               [a-zA-Z]
letrasSinE                          [a-zA-Z]{-}[eE]
exponenteInvalido                   {letrasSinE}|{letra}{letra}
idVariable                          {letra}({letra}|[0-9])*
idFuncion                           a?(sin|cos|tan)|sqrt|log
fueraDelAlfabeto                    [^ \n\t]{-}[0-9a-zA-Z.()^=*+/-]

identificador                       {idVariable}|{idFuncion}
numero                              {flotante}|{entero}
cadenaDesconocida                   {fueraDelAlfabeto}[^ \n\t]*
realInvalido                        \.*{flotante}({exponenteInvalido}|[.])({numero}|{letra}|\.)*
constanteInvalida                   {entero}{exponenteInvalido}({letra}|{entero})*

%option header-file="scanner.h"
%option outfile="scanner.c"
%option yylineno
%option noinput 
%option nounput
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
\.({numero}|[^ \n\t])*              |
{realInvalido}                      printf("Error lexico: Real invalido: '%s'\n", yytext);
{cadenaDesconocida}                 printf("Error lexico: Cadena desconocida: '%s'\n", yytext);
[=^+/*()-]                          return yytext[0];
.|\n                                //null;

%%
int yywrap(){ //para poder correrlo en windows sin -lfl
	return 1;
}